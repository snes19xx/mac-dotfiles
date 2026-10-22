export PATH="$HOME/.local/bin:$PATH"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/snes/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/snes/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/snes/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/snes/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
export MAMBA_EXE='/Users/snes/miniforge3/bin/mamba';
export MAMBA_ROOT_PREFIX='/Users/snes/miniforge3';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias mamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

alias ls='ls -G'
alias grep='grep --color=auto'

# yazi file manager: `y` opens it and cd's to the folder I was in when I quit
function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  IFS= read -r -d '' cwd < "$tmp"
  [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
  rm -f -- "$tmp"
}

# zoxide: `z part-of-a-folder-name` jumps to folders I've visited
command -v zoxide >/dev/null && eval "$(zoxide init zsh)"

# Prompt (keep last)
command -v starship >/dev/null && eval "$(starship init zsh)"
