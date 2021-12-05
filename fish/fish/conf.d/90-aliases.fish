alias less='less -R'
alias youtube-dl="youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best'"
alias pstree="pstree -g 2"

alias vi="nvim"

switch (uname)
    case Linux
        alias del='gio trash'
        alias pbcopy='xsel -i -p; and xsel -o -p | xsel -i -b'
        alias pbpaste='xsel -o'
    case Darwin
        alias del=rmtrash
        alias cliptmux="tmux showb|pbcopy"
        alias chrome="/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome"
        alias sourcetree='open -a sourcetree'
end

if type -q plocate
    alias locate=plocate
end
