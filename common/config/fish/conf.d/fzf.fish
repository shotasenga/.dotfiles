if ! type -q fzf
    echo "`fzf` is not installed"
end

set -x FZF_DEFAULT_OPTS --layout=reverse --border
set -x FZF_LIST_ALL 'fd --hidden --exclude ".git" --follow'
set -x FZF_LIST_FILE "$FZF_LIST_ALL --type f"
set -x FZF_LIST_DIR "$FZF_LIST_ALL --type d"
set -x FZF_FILE_COMMAND vim emacs less
set -x FZF_DIR_COMMAND cd
