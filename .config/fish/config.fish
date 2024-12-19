set -U fish_greeting

set fish_color_command      normal
set fish_color_param        normal
set fish_color_valid_path   normal
set fish_color_keyword      magenta
set fish_color_quote        green
set fish_color_operator     cyan
set fish_color_end          cyan
set fish_color_escape       brwhite
set fish_color_comment      brblack

set __fish_ls_command ls
set __fish_ls_color_opt --color=auto

set __fish_git_prompt_show_informative_status 1
set __fish_git_prompt_hide_stagedstate 1
set __fish_git_prompt_hide_dirtystate 1
set __fish_git_prompt_char_cleanstate ''
set __fish_git_prompt_char_stagedstate '*'
set __fish_git_prompt_char_dirtystate '!'
set __fish_git_prompt_char_stateseparator
set __fish_git_prompt_status_order dirtystate stagedstate stashstate

function fish_prompt
  set -l dir (string replace -r '^'$HOME'($|/)' '~$1' $PWD)
  set -l dir (basename $dir)

  echo -s \
    (set_color FBE8F5) (fish_vcs_prompt "(%s) ") \
    (set_color EE95D2) "$USER " \
    (set_color F5C0E4) "$dir " \
    (set_color FBE8F5) "% " \
    (set_color normal)
end

function fish_right_prompt
  set -l exit $status
  test $exit != 0
  and echo -s (set_color brblack) "$exit :<" (set_color normal)
end

function fish_title
  if set --query argv[1]
    echo $argv
  else
    echo fish \((prompt_pwd -d 0)\)
  end
end

if status is-interactive
  # drop back to last directory
  if set -l lastpid (pidof /bin/fish | string split " ")[3]; and test -n $lastpid
    cd (realpath /proc/$lastpid/cwd 2>/dev/null)
  end

  # ctrl-z to fg
  bind \cz 'fg 2>/dev/null; commandline -f repaint'

  alias dots="git --git-dir ~/.notgit --work-tree ~"
  alias lazydots="lazygit --git-dir ~/.notgit --work-tree ~"

  alias bat="command bat --theme=ansi --style=header,numbers,changes"
  alias cat="command bat -pp"

  alias ssh="TERM=xterm-256color command ssh"

  eval "$(dircolors --csh)"
  eval "$(zoxide init fish)"
end

if status is-login
  set -gx EDITOR $(which nvim)
  set -gx VISUAL $EDITOR

  # virus
  set -gx DOTNET_CLI_TELEMETRY_OPTOUT 1

  set -gx PNPM_HOME           ~/.local/share/pnpm
  set -gx PIPX_HOME           ~/.local/share/pipx
  set -gx CARGO_HOME          ~/.local/share/cargo
  set -gx W3M_DIR             ~/.local/share/w3m
  set -gx CLJ_CONFIG          ~/.config/clojure
  set -gx CLJ_CACHE           ~/.cache/clojure
  set -gx NPM_CONFIG_CACHE    ~/.cache/npm
  set -gx NODE_REPL_HISTORY   ~/.local/share/node/history
  set -gx TS_NODE_HISTORY     $NODE_REPL_HISTORY
  set -gx LESSHISTFILE        -
  set -gx GHCUP_USE_XDG_DIRS  y
  set -gx STACK_XDG           y
  set -gx GEM_HOME            (gem env user_gemhome)

  fish_add_path ~/.local/bin ~/.local/share/cargo/bin ~/.dotnet/tools
  fish_add_path $PNPM_HOME $GEM_HOME/bin

  eval "$(opam env)"
end

if status is-login; and not set --query DISPLAY; and test (tty) = /dev/tty1
  exec startx
end
