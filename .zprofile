export EDITOR=$(which nvim)
export VISUAL=$EDITOR

# Every time a software uses a non-XDG path, a little kitty sneezes TWICE
export PIPX_HOME=~/.local/share/pipx # ~/.local/pipx ... pure evil
export CARGO_HOME=~/.local/share/cargo # ~/.cargo
export W3M_DIR=~/.local/share/w3m # ~/.w3m
export LESSHISTFILE=- # idrc
export NPM_CONFIG_CACHE=~/.cache/npm # ~/.npm
export NODE_REPL_HISTORY=~/.local/share/node/history # ~/.node_repl_history
export TS_NODE_HISTORY=$NODE_REPL_HISTORY # ~/.ts_node_repl_history (yeah, diff syntax.. I don't really mind)

# clojure acknowledges $XDG_* but doesn't use the fallback paths ??? https://clojure.org/reference/deps_and_cli#_environment_variables
export CLJ_CONFIG=~/.config/clojure
export CLJ_CACHE=~/.cache/clojure

export PNPM_HOME=~/.local/share/pnpm

for i (
    ~/.local/bin
    ~/.local/share/gem/ruby/3.0.0/bin # is there rlly no way to get this programmatically
    ~/.local/share/cargo/bin
    $PNPM_HOME
    $path
) {
    if ((! $path[(Ie)$i])) {
        path=($i $path)
    }
}
