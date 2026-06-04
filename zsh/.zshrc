# Must be before p10k instant prompt block
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# Powerlevel10k instant prompt initialization
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# oh-my-zsh
export ZSH="/Users/mzbali/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
source $ZSH/oh-my-zsh.sh

# History
HIST_STAMPS="dd.mm.yyyy"
DISABLE_UPDATE_PROMPT="true"

# PATH
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:/sbin:/usr/sbin:$PATH
export PATH="$PATH:/Applications/Docker.app/Contents/Resources/bin/"
export PATH="$PATH:/Users/mzbali/.spicetify"
export PATH="$HOME/Library/pnpm/bin:$PATH"


# Aliases
alias vim="nvim"
alias zrc="nvim ~/.zshrc"
alias b="btop"
alias c="clear"
alias q="exit"
alias ls='eza --color=always --group-directories-first --icons'
alias la='eza -al --color=always --group-directories-first --icons --git'
alias ll='eza -l --color=always --group-directories-first --icons --git'
alias tree='eza --tree --color=always --group-directories-first --icons'
alias spotx='bash <(curl -sSL https://spotx-official.github.io/run.sh)'
alias pn=pnpm
alias pnpx='pnpm dlx'
alias tc="npx ts-node"
alias k='kubectl'

# Key bindings
bindkey -s '^f' "tmux-sessioniser\n"

# p10k configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fnm env on cd command
eval "$(fnm env --use-on-cd --shell zsh)"

# dotnet telemetry
export DOTNET_CLI_TELEMETRY_OPTOUT=1
