set PATH /usr/local/bin $PATH
set PATH ~/bin $PATH
set PATH node_modules/.bin $PATH
set PATH bin $PATH

eval (python -m virtualfish)

set -g -x GIT_AUTHOR_NAME 'Erin Call'
set -g -x GIT_AUTHOR_EMAIL 'hello@erincall.com'
set -g -x GIT_COMMITTER_NAME $GIT_AUTHOR_NAME
set -g -x GIT_COMMITTER_EMAIL $GIT_AUTHOR_EMAIL

if not begin
    [ -f ~/.gpg-agent-info ]
    and kill -0 (cut -d: -f 2 ~/.gpg-agent-info) ^/dev/null
end
    gpg-agent --daemon --no-grab --write-env-file ~/.gpg-agent-info >/dev/null ^&1
end
set -g -x GPG_AGENT_INFO (cut -c 16- ~/.gpg-agent-info)
set -g -x GPG_TTY (tty)

set -g -x NOSE_REDNOSE '1'
set -g -x NOSE_REDNOSE_COLOR 'force'

alias mvimf "mvim -f -c 'au VimLeave * !open -a iTerm'"
set -g -x EDITOR vim
if [ -x (which subl) ]
    set EDITOR 'subl --wait --new-window'
end

set -g -x PAGER 'less'
set -g -x LESS '-FRX'

if [ -x (which gsed) ]
    alias sed 'gsed'
end

alias vb $EDITOR" ~/.config/fish/config.fish"
alias sb ". ~/.config/fish/config.fish"
alias read_silently "perl -MTerm::ReadKey -e 'ReadMode(q[noecho]); while (<>) {}; ReadMode(0)'"
alias now "date -u '+%Y%m%d%H%M%S'"
alias ll 'ls -l'

if [ -x (which ipconfig) ]
    alias localip "ifconfig -l | tr ' ' '\n' | xargs -I{} ipconfig getifaddr {}"
end

alias     ... 'cd ../..'
alias    .... 'cd ../../..'
alias   ..... 'cd ../../../..'
alias  ...... 'cd ../../../../..'
alias ....... 'cd ../../../../../..'

alias prettify 'pbpaste | pretty_json | pbcopy'

# GNU systems
set -g -x LS_COLORS "no=00:fi=00:di=01;36:ln=01;36:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=01;32:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:"
# BSD systems including Darwin
set -g -x LSCOLORS "Eafxcxdxbxegedabagacad"