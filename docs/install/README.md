# Adding a new dotfile entry

## Registry

Add entries to three associative arrays in `install.sh`:

| Array | Purpose | Example | Required |
|-------|---------|---------|----------|
| `TARGET[$name]` | Destination path on disk | `["nvim"]="$HOME/.config/nvim"` | Yes |
| `TYPE[$name]` | Install method | `["nvim"]="symlink"` | Yes |
| `PLATFORM[$name]` | OS restriction via `uname -s` | `["keyd"]="linux"` | Only if platform-specific |

Source path is always `$DOTFILES_DIR/<name>`.

## Install types

- **`files` (preferred)** — each file in source is symlinked individually
  to the target dir. The target dir stays writable by the app, so it can
  create its own files alongside yours. Use for most configs.

- **`symlink`** — the entire source dir is symlinked as one unit to the
  target path. Use when you want new files/subdirs auto-tracked. Caveat:
  the target dir becomes a symlink, so the app cannot write its own files
  there.

- **`copy`** — files are copied (via `install -Dm 644`). Use only when the
  target requires root access or lives outside `$HOME` (e.g. `/etc/keyd`).

## Platform restriction

Set `PLATFORM[$name]` to match `uname -s`. Entry is skipped on other OSes.
Common values: `linux`, `Darwin`.

## Backup behavior

Existing files are backed up before replacement:
`<target>.bak`, then `<target>.bak.1`, `.bak.2`, etc.
Run `./install.sh --clean` to purge all backups.
