# Beep
# ------------------------------
unsetopt beep

# Navigation
# ------------------------------
setopt AUTO_CD
setopt CD_SILENT

setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

setopt CDABLE_VARS
setopt EXTENDED_GLOB


# History
# ------------------------------
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$ZDOTDIR/.histfile"
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS


# Key bindings (emacs)
# ------------------------------
bindkey -e
bindkey \^U backward-kill-line
autoload -U select-word-style
select-word-style bash


# Completion
# ------------------------------
autoload -U compinit && compinit -u
zstyle ':completion:*' menu select
# Auto complete with case insenstivity
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.


# fzf
# ------------------------------
# TOOD: support osx $(brew --prefix)/opt/fzf/install ?
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

export FZF_DEFAULT_OPTS='--layout=reverse --border'
export FZF_DEFAULT_COMMAND='fd --type f --hidden --exclude ".git" --follow'
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_ALT_C_COMMAND='fd --type d --hidden --exclude ".git" --follow'
export FZF_COMPLETION_TRIGGER='..'

_fzf_compgen_path() {
    eval "$FZF_DEFAULT_COMMAND $1"
}

_fzf_compgen_dir() {
    eval "$FZF_ALT_C_COMMAND $1"
}

_fzf_complete_git() {
    if [[ $1 == 'git worktree'* ]]; then
        _fzf_complete +m --prompt="git worktree>" --preview 'echo {} | awk "{print \$2}" | xargs -r git show' -- "$@" < <(
            git worktree list
        )
    elif [[ $1 == 'git show'* ]]; then
        _fzf_complete +m --prompt="git log>" --preview 'echo {} | awk "{print \$1}" | xargs -r git show' -- "$@" < <(
            git log --pretty=oneline
        )
    else
        _fzf_complete +m --prompt="git branch>" --preview 'git show {}' -- "$@" < <(
            git branch --format='%(refname:short)'
        )
    fi
}

_fzf_complete_git_post() {
    awk '{print $1}'
}

_fzf_complete_man() {
    _fzf_complete +m --prompt="man>" --preview 'echo {} | tr -d "()" | awk "{print \$2 \" \" \$1}"| xargs -r man' -- "$@" < <(
        man -k .
    )
}

_fzf_complete_man_post() {
    tr -d "()" | awk "{print \$2 \" \" \$1}"
}

_fzf_search_file() {
    [[ -n $1 ]] && cd $1
    RG_DEFAULT_COMMAND="rg -i -l --hidden --no-ignore-vcs"

    local n=$(
        FZF_DEFAULT_COMMAND="rg --files" fzf \
                           -m \
                           -e \
                           --ansi \
                           --phony \
                           --reverse \
                           --bind "ctrl-a:select-all" \
                           --bind "f12:execute-silent:(subl -b {})" \
                           --bind "change:reload:$RG_DEFAULT_COMMAND {q} || true" \
                           --preview "rg -i --pretty --context 2 {q} {}" | cut -d":" -f1,2
          )

    RBUFFER=$n
}

zle -N _fzf_search_file

stty stop undef
stty start undef

bindkey '^T' transpose-chars
bindkey '^s' fzf-file-widget
bindkey '^[S' _fzf_search_file
bindkey '^[s' _fzf_search_file


# fasd
# ------------------------------
eval "$(fasd --init zsh-hook)"

# Edit a file
# e [word] [word2] [..wrordn]
e() {
    local file
    if [ -z $1 ]; then
        file=$(fasd -Rfl | fzf -1 -0 --no-sort +m) && $EDITOR "${file}" || return 1
    else
        file=$(fasd -Rfl | fzf -q "$*" -1 -0 --no-sort +m) && $EDITOR "${file}" || return 1
    fi
}

# Jump to a directory
# j [word] [word2] [..wrordn]
j() {
    local dir
    if [ -z $1 ]; then
        dir=$(fasd -Rdl | fzf -1 -0 --no-sort +m) && cd "${dir}" || return 1
    else
        dir=$(fasd -Rdl | fzf -q "$*" -1 -0 --no-sort +m) && cd "${dir}" || return 1
    fi
}


# Aliases
# ------------------------------
alias ls="ls --color=always -F"
alias ll="ls -l"
alias less="less -R"
alias history="history 0"
alias emacs="emacsclient -n"
if ! command -v pbcopy > /dev/null; then
    alias pbcopy="xclip -sel clip"
    alias pbpaste="xclip -sel clip -o"
fi
if ! command -v open > /dev/null; then
    alias open="xdg-open"
fi

# Prompt & styles
# ------------------------------
eval "$(starship init zsh)"

# https://github.com/zsh-users/zsh-autosuggestions
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# https://github.com/zsh-users/zsh-syntax-highlighting
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# https://github.com/kevinywlui/zlong_alert.zsh
source $ZDOTDIR/plugins/zlong_alert.zsh/zlong_alert.zsh
export zlong_ignore_cmds="vim ssh less git tmux watch"
