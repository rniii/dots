export EDITOR=$(which nvim)
export VISUAL=$EDITOR

# malware
export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Every time a software uses a non-XDG path, a little kitty sneezes TWICE
export PIPX_HOME=~/.local/share/pipx # ~/.local/pipx ... pure evil
export CARGO_HOME=~/.local/share/cargo # ~/.cargo
export W3M_DIR=~/.local/share/w3m # ~/.w3m
export LESSHISTFILE=- # who cares
export NPM_CONFIG_CACHE=~/.cache/npm # ~/.npm
export NODE_REPL_HISTORY=~/.local/share/node/history # ~/.node_repl_history
export TS_NODE_HISTORY=$NODE_REPL_HISTORY
export GHCUP_USE_XDG_DIRS=y # WHAT THE UFKC
export STACK_XDG=y # WHAT
# clojure acknowledges $XDG_* but doesn't use the fallback paths ??? https://clojure.org/reference/deps_and_cli#_environment_variables
export CLJ_CONFIG=~/.config/clojure
export CLJ_CACHE=~/.cache/clojure

export PNPM_HOME=~/.local/share/pnpm

export GEM_HOME="$(gem env user_gemhome)"

for i (
    ~/.local/bin
    ~/.local/share/cargo/bin
    ~/.dotnet/tools
    $PNPM_HOME
    $GEM_HOME/bin
    $path
) {
    if ((! $path[(Ie)$i])) {
        path=($i $path)
    }
}

eval "$(opam env)"
