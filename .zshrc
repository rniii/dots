setopt autocd promptsubst interactivecomments

bindkey -e

# tip: hit `Ctrl+V` plus your keybind, the escape will be written back

bindkey "^[[3~"   delete-char         # Del
bindkey "^[[H"    beginning-of-line   # Home
bindkey "^[[F"    end-of-line         # End
bindkey "^[[1;5D" backward-word       # Ctrl+Left
bindkey "^[[1;5C" forward-word        # Ctrl+Right
bindkey "^H"      backward-kill-word  # Ctrl+Backspace
bindkey "^[[A"    up-line-or-search   # Up
bindkey "^[[B"    down-line-or-search # Down

# completion stuff
zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]}' 'r:|[._-/]=* r:|=*'

autoload -Uz compinit
compinit

# useful builtin modules
autoload -U url-quote-magic
autoload -U bracketed-paste-magic
zle -N bracketed-paste bracketed-paste-magic

# prompt stuff

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' stagedstr '*'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' formats '%F{#fbe8f5}(%b%u%c) '
zstyle ':vcs_info:*' actionformats '%F{#fbe8f5}(%a %b%u%c) '
zstyle ':vcs_info:*' branchformat '%b'

autoload -Uz vcs_info

precmd () {
    vcs_info
}

PROMPT='%(?..%F{red}%?! %f)${vcs_info_msg_0_}%F{#ee95d2}%n %F{#f5c0e4}%1~ %F{#fbe8f5}%# %f'

eval $(dircolors)
alias ls="ls --color=auto"

# dotfiles management
# this is basically the same as just making your ~ a git repo, but the actual git dir is moved as to not conflict with tools
# 
# make one yourself: `git init --bare ~/.notgit`
# install on a new system: `git clone --bare ~/.notgit <url>`, `dots checkout --force` (will overwrite data!)
alias dots="git --git-dir ~/.notgit --work-tree ~"
alias lazydots="lazygit --git-dir ~/.notgit --work-tree ~"

# fancy cat(1) https://github.com/sharkdp/bat
alias bat="bat --theme=ansi --style=header,numbers,changes"
# I hate pagers ...
alias cat="bat --wrap=never --decorations=never --paging=never"

tab() {
    command tac $@ | bat --file-name $1
}
tac() {
    command tac $@ | cat --file-name $1
}

# quicker cd'ing https://github.com/ajeetdsouza/zoxide
eval "$(zoxide init zsh)"
