#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

# ── Registry ──────────────────────────────────────────────────
declare -A TARGET=(
  ["nvim"]="$HOME/.config/nvim"
  ["tmux"]="$HOME/.config/tmux"
  ["zsh"]="$HOME/.config/zsh"
  ["keyd"]="/etc/keyd"
  ["lazygit"]="$HOME/.config/lazygit"
)

declare -A TYPE=(
  ["nvim"]="symlink"
  ["tmux"]="symlink"
  ["zsh"]="files"
  ["keyd"]="copy"
  ["lazygit"]="files"
)

declare -A PLATFORM=(
  ["keyd"]="linux"
)

# ── Colors ────────────────────────────────────────────────────
CYAN=$'\033[36m'
GREEN=$'\033[32m'
YELLOW=$'\033[33m'
RED=$'\033[31m'
BOLD=$'\033[1m'
RESET=$'\033[0m'

info()    { echo "${CYAN}${*}${RESET}"; }
success() { echo "${GREEN}${*}${RESET}"; }
warn()    { echo "${YELLOW}${*}${RESET}"; }
error()   { echo "${RED}${*}${RESET}"; }

# ── Clean mode ──────────────────────────────────────────────
if [ "${1:-}" = "--clean" ]; then
  cleaned=0

  for name in "${!TARGET[@]}"; do
    platform="${PLATFORM[$name]:-}"
    [ -n "$platform" ] && [ "$(uname -s)" != "$platform" ] && continue

    target="${TARGET[$name]}"
    type="${TYPE[$name]}"

    case "$type" in
      symlink)
        dir="$(dirname "$target")"
        [ -d "$dir" ] || continue
        base="$(basename "$target")"
        while IFS= read -r -d '' bak; do
          rm -rf "$bak"
          echo "  removed $bak"
          cleaned=$((cleaned + 1))
        done < <(find "$dir" -maxdepth 1 \( -name "${base}.bak" -o -name "${base}.bak.[0-9]*" \) -print0)
        ;;
      files)
        [ -d "$target" ] || continue
        while IFS= read -r -d '' bak; do
          rm -rf "$bak"
          echo "  removed $bak"
          cleaned=$((cleaned + 1))
        done < <(find "$target" \( -name '*.bak' -o -name '*.bak.[0-9]*' \) -print0)
        ;;
      copy)
        [ -d "$target" ] || continue
        while IFS= read -r -d '' bak; do
          sudo rm -rf "$bak"
          echo "  removed $bak"
          cleaned=$((cleaned + 1))
        done < <(sudo find "$target" \( -name '*.bak' -o -name '*.bak.[0-9]*' \) -print0)
        ;;
    esac
  done

  # .zshenv backups at $HOME
  while IFS= read -r -d '' bak; do
    rm -rf "$bak"
    echo "  removed $bak"
    cleaned=$((cleaned + 1))
  done < <(find "$HOME" -maxdepth 1 \( -name '.zshenv.bak' -o -name '.zshenv.bak.[0-9]*' \) -print0)

  echo
  success "cleaned $cleaned backup(s)"
  exit 0
fi

# ── Banner ────────────────────────────────────────────────────
echo
echo "${CYAN} ____   ___ _____ _____ ___ _     _____ ____  ${RESET}"
echo "${CYAN}|  _ \ / _ \_   _|  ___|_ _| |   | ____/ ___| ${RESET}"
echo "${CYAN}| | | | | | || | | |_   | || |   |  _| \___ \ ${RESET}"
echo "${CYAN}| |_| | |_| || | |  _|  | || |___| |___ ___) |${RESET}"
echo "${CYAN}|____/ \___/ |_| |_|   |___|_____|_____|____/ ${RESET}"
echo
echo "${CYAN} ___ _   _ ____ _____  _    _     _     _____ ____  ${RESET}"
echo "${CYAN}|_ _| \ | / ___|_   _|/ \  | |   | |   | ____|  _ \ ${RESET}"
echo "${CYAN} | ||  \| \___ \ | | / _ \ | |   | |   |  _| | |_) |${RESET}"
echo "${CYAN} | || |\  |___) || |/ ___ \| |___| |___| |___|  _ < ${RESET}"
echo "${CYAN}|___|_| \_|____/ |_/_/   \_\_____|_____|_____|_| \_\\${RESET}"
echo

# ── Helpers ───────────────────────────────────────────────────
backup() {
  local target="$1"
  local backup_dir="${target}.bak"

  if [ -e "$backup_dir" ]; then
    local n=1
    while [ -e "${backup_dir}.${n}" ]; do
      n=$((n + 1))
    done
    backup_dir="${backup_dir}.${n}"
  fi

  mv "$target" "$backup_dir"
  echo "  → backed up to $backup_dir"
}

sudo_backup() {
  local target="$1"
  local backup_dir="${target}.bak"

  if [ -e "$backup_dir" ]; then
    local n=1
    while [ -e "${backup_dir}.${n}" ]; do
      n=$((n + 1))
    done
    backup_dir="${backup_dir}.${n}"
  fi

  sudo cp "$target" "$backup_dir"
  echo "  → backed up to $backup_dir"
}

# ── Install ───────────────────────────────────────────────────
errors=0
total=0
installed=0
skipped=0

for name in "${!TARGET[@]}"; do
  total=$((total + 1))
  target="${TARGET[$name]}"
  type="${TYPE[$name]}"
  platform="${PLATFORM[$name]:-}"
  source="$DOTFILES_DIR/$name"

  printf "  [${BOLD}%s${RESET}] " "$name"

  if [ -n "$platform" ] && [ "$(uname -s)" != "$platform" ]; then
    info "skipped (requires $platform)"
    skipped=$((skipped + 1))
    continue
  fi

  if [ ! -e "$source" ]; then
    error "ERROR: source $source not found"
    errors=$((errors + 1))
    continue
  fi

  case "$type" in
    symlink)
      if [ -L "$target" ] && [ "$(readlink "$target")" = "$source" ]; then
        success "already linked"
        skipped=$((skipped + 1))
        continue
      fi

      if [ -e "$target" ] || [ -L "$target" ]; then
        warn "exists"
        backup "$target"
      fi

      ln -s "$source" "$target"
      success "linked → $target"
      installed=$((installed + 1))
      ;;

    files)
      file_count=0
      while IFS= read -r -d '' file; do
        rel="${file#$source/}"
        file_target="$target/$rel"
        file_target_dir="$(dirname "$file_target")"

        if [ -L "$file_target" ] && [ "$(readlink "$file_target")" = "$file" ]; then
          continue
        fi

        mkdir -p "$file_target_dir"

        if [ -e "$file_target" ] || [ -L "$file_target" ]; then
          warn "exists"
          backup "$file_target"
        fi

        ln -s "$file" "$file_target"
        file_count=$((file_count + 1))
      done < <(find "$source" -type f -print0)

      if [ "$file_count" -gt 0 ]; then
        success "linked $file_count file(s) → $target"
        installed=$((installed + 1))
      else
        success "up to date"
        skipped=$((skipped + 1))
      fi
      ;;

    copy)
      file_count=0
      while IFS= read -r -d '' file; do
        rel="${file#$source/}"
        file_target="$target/$rel"
        if [ -f "$file_target" ]; then
          src_hash=$(sha256sum "$file" | cut -d' ' -f1)
          tgt_hash=$(sha256sum "$file_target" 2>/dev/null | cut -d' ' -f1 || echo "")
          if [ "$src_hash" = "$tgt_hash" ]; then
            continue
          fi
          sudo_backup "$file_target"
        fi

        sudo install -Dm 644 "$file" "$file_target"
        file_count=$((file_count + 1))
      done < <(find "$source" -type f -print0)

      if [ "$file_count" -gt 0 ]; then
        success "copied $file_count file(s) → $target"
        installed=$((installed + 1))
      else
        success "up to date"
        skipped=$((skipped + 1))
      fi
      ;;
  esac
done

# ── Extra symlinks ──────────────────────────────────────────────
# .zshenv must live at $HOME (ZDOTDIR not yet set when zsh reads it)
zshenv_target="$HOME/.zshenv"
zshenv_source="$DOTFILES_DIR/zsh/.zshenv"
if [ -L "$zshenv_target" ] && [ "$(readlink "$zshenv_target")" = "$zshenv_source" ]; then
  success "zshenv already linked"
else
  if [ -e "$zshenv_target" ] || [ -L "$zshenv_target" ]; then
    warn "zshenv exists"
    backup "$zshenv_target"
  fi
  ln -s "$zshenv_source" "$zshenv_target"
  success "zshenv linked → $zshenv_target"
fi

# ── Summary ───────────────────────────────────────────────────
echo
echo -e "${BOLD}Done:${RESET} ${installed} installed, ${skipped} skipped, ${errors} errors"
echo
exit "$errors"
