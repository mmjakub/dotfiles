#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$HOME/dotfiles"

# ── Registry ──────────────────────────────────────────────────
# Add new dotfiles here: dir name -> target path
declare -A REGISTRY=(
  ["nvim"]="$HOME/.config/nvim"
  ["tmux"]="$HOME/.config/tmux"
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

# ── Install ───────────────────────────────────────────────────
errors=0
total=0
installed=0
skipped=0

for name in "${!REGISTRY[@]}"; do
  total=$((total + 1))
  source="$DOTFILES_DIR/$name"
  target="${REGISTRY[$name]}"

  printf "  [${BOLD}%s${RESET}] " "$name"

  if [ ! -e "$source" ]; then
    error "ERROR: source $source not found"
    errors=$((errors + 1))
    continue
  fi

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
done

# ── Summary ───────────────────────────────────────────────────
echo
echo -e "${BOLD}Done:${RESET} ${installed} installed, ${skipped} skipped, ${errors} errors"
echo
exit "$errors"
