export PATH="$PATH:$HOME/.local/bin:$HOME/.cabal/bin:$HOME/.ghcup/bin"

alias ll="ls -l --color=auto --group-directories-first"
alias ls="ls --color=auto --group-directories-first"

# Initially, this is set as 'st-256color', but many programs (such as vim)
# don't recognize the terminal, displaying in black & white.
export TERM=xterm-256color

export VISUAL=vim
export EDITOR=vim
export BROWSER=firefox

# Pager should be less, and no history file.
export PAGER=less
export LESSHISTFILE='-'

# Setup some XDG variables.
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
if [ -z $XDG_RUNTIME_DIR ]; then
  export XDG_RUNTIME_DIR="/tmp/"`id --user`"-runtime-dir"
  if [ ! -d $XDG_RUNTIME_DIR ]; then
    mkdir -p $XDG_RUNTIME_DIR
    chmod 0700 $XDG_RUNTIME_DIR
  fi
fi

source $XDG_CONFIG_HOME/xdg/user-dirs.dirs

# N is a version manager for Node and NPM. Setting the path prefix to this
# prevents permission errors when installing stuff globally.
export N_PREFIX="$HOME/.n"
export PATH="$PATH:/$N_PREFIX/bin"

# Simple prompt: CWD in mangenta. Continuation is empty.
export PS1="\[\033[36m\]\w\[\033[m\] "
export PS2=""

# Tab autocompletion for haskell-stack
eval "$(stack --bash-completion-script stack)"
