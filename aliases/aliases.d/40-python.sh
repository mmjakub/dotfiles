alias py=python
alias pym='python -m'
alias ipy=ipython
alias pyc=' inotifywait -e modify -m -r --include ".*\\.py$" --format "%w%f" . | while read -r fname; do py -m py_compile "$fname" && clear; done'
alias pyt=' inotifywait -e modify -m -r --include ".*\\.py$" --format "%w%f" . | while read -r fname; do clear; mypy "$fname"; done'
alias pyw='inotifywait -e modify -m -r --include ".*\\.py$" --format "%w%f" .'
