export EDITOR="$(which nvim)"
export VISUAL="$EDITOR"

export LESS="FR"

# virus
export DOTNET_CLI_TELEMETRY_OPTOUT=1

export PNPM_HOME=~/.local/share/pnpm
export PIPX_HOME=~/.local/share/pipx
export CARGO_HOME=~/.local/share/cargo
export W3M_DIR=~/.local/share/w3m
export ZIG_LIB_DIR=~/.local/lib/zig
export NPM_CONFIG_CACHE=~/.cache/npm
export NODE_REPL_HISTORY=~/.local/share/node/history
export TS_NODE_HISTORY="$NODE_REPL_HISTORY"
export LESSHISTFILE=-
export GHCUP_USE_XDG_DIRS=y
export STACK_XDG=y

command -v gem &&
export GEM_HOME="$(gem env user_gemhome)"

PATH="$PATH:~/.local/bin:~/.local/share/cargo/bin:~/.dotnet/tools"
PATH="$PATH:$PNPM_HOME:$GEM_HOME/bin"

command -v opam &&
eval "$(opam env)"
