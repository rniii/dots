setopt autocd promptsubst interactivecomments

# - completion ------------------------------------------------------------ {{{1
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-/]=* r:|=*'
zstyle ':completion:*' rehash true

autoload -Uz compinit
compinit

# - input ----------------------------------------------------------------- {{{1
bindkey -e

bindkey "^[[1;5D" backward-word       # Ctrl+Left
bindkey "^[[1;5C" forward-word        # Ctrl+Right
bindkey "^[[A"    up-line-or-search   # Up
bindkey "^[[B"    down-line-or-search # Down

ctrl-z-fg() { BUFFER="fg"; zle accept-line }

zle -N ctrl-z-fg; bindkey "^Z" ctrl-z-fg

autoload -U url-quote-magic;       zle -N self-insert url-quote-magic
autoload -U bracketed-paste-magic; zle -N bracketed-paste bracketed-paste-magic

# - prompt ---------------------------------------------------------------- {{{1
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '*'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' formats '(%b%u%c) '
zstyle ':vcs_info:*' actionformats '(%a %b%u%c) '
zstyle ':vcs_info:*' branchformat '%b'

autoload -Uz vcs_info

set_title() { printf "\e]2;%s\a" "$1" }

precmd() { set_title "$(print -Pn "zsh (%~)")"; vcs_info }
preexec() { set_title "$1" }

PS1='%F{#fbe8f5}${vcs_info_msg_0_}%F{#ee95d2}%n %F{#f5c0e4}%1~ %(?.%F{#fbe8f5}%#.%F{red}!) %f'
RPS1='%(?..%F{8}%? :<)'

PS2='%F{0}${vcs_info_msg_0_}%n %F{8}%1~ \ %f'

# - commands -------------------------------------------------------------- {{{1
export BAT_THEME=ansi
export BAT_STYLE=header,numbers,changes

[ -n "$SSH_CONNECTION" ] &&
export COLORTERM=truecolor

alias ls="ls --color=auto -vh --group-directories-first"

alias dots="git --git-dir ~/.notgit --work-tree ~"
alias lazydots="lazygit --git-dir ~/.notgit --work-tree ~"

alias cat="bat -pp"
alias objdump="objdump -M intel"

alias ssh="TERM=xterm-256color ssh"

alias fuck="systemctl --user restart wireplumber"

eval "$(dircolors)"
eval "$(zoxide init zsh)"

local last_path="$(realpath /proc/${$(pidof zsh)[3]}/cwd)"
if [[ -d "$last_path" ]] { cd "$last_path" }
