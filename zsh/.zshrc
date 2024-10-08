# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
# export ZSH="$HOME/.oh-my-zsh"

# ZSH_THEME="pmcgee"
# plugins=(git; rust; colorize; copypath)
#
# source $ZSH/oh-my-zsh.sh

export HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=10000
setopt appendhistory

autoload -Uz compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion::complete:*' gain-privileges 1
export KEYTIMEOUT=5

#My aliases
alias zshrc="nvim /home/abec/.zshrc"
alias nvimcf="nvim /home/abec/.config/nvim/lua/abec"
alias hyprcf="nvim ~/.config/hypr/"
alias tma="tmux attach -t"
tmn (){
    if [ -z "$1" ]; then
        result=${PWD##*/}
        session_name=${result:-/}
    else
        session_name="$1"
    fi
    tmux new -s "$session_name"
}
alias resource="source ~/.zshrc"
alias tms="~/Scripts/tmux-list-attach.sh"
alias gsel='~/.config/zsh/gsel.sh'
alias hydra='/opt/hydralauncher-2.0.3.AppImage'
export alias ytdlp='yt-dlp --proxy 127.0.0.1:8080'

export PATH="${PATH}:${HOME}/Scripts:${HOME}/.cargo/bin"
export EDITOR="nvim"
export HISTFILE="${HOME}/.zsh_history"

eval "$(zoxide init --cmd cd zsh)"

eval "$(fzf --zsh)"

# pnpm
export PNPM_HOME="/home/abec/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end


