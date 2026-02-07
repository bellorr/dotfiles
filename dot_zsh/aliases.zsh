# Managed by chezmoi - Edit with: chezmoi edit ~/.zsh/aliases.zsh

alias c='clear'
alias h='history'
alias mkdir='mkdir -p'
alias mv='mv -vi'
alias cp='cp -vi'
alias tree='tree -C'
alias ping='ping -c 5'
alias df='df -H'
alias pbc='pbcopy'
alias vim='nvim'
alias gpgl='gpg --list-keys'

alias reboot='sudo /sbin/reboot'
alias rfinder='killall Finder'
alias rdock='killall Dock'

#alias cat='bat --paging=never'
alias gdu='gdu-go'
alias disk='gdu'
#alias grep='rg'
alias top='btop'
alias wget='wget2'

alias dnslookup="dig +noall +answer"

alias ga='git add'
alias gs='git status'
alias gc='git commit'

alias ls='eza --group-directories-first --icons'
alias ll='eza --group-directories-first --icons -lh'
alias la='eza --group-directories-first --icons -a'
alias lla='eza --group-directories-first --icons -lah'
alias lsa='eza --group-directories-first --icons -lah'

alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .2='cd ../../'
alias .3='cd ../../../'
alias .4='cd ../../../../'

alias sc='source $HOME/.zshrc'
alias zshrc='vim ~/.zshrc'
alias sship='vim ~/.config/starship.toml'
alias aliases='vim ~/.zsh/aliases.zsh'

# Share current dir
alias pshare='python3 -m http.server 2121'

# Stealth (very slow) nmap
alias snmap='nmap -f -T2 --data-length 8 --randomize-hosts -ttl 58'

# combined
alias ip='echo "Local ips:" && ifconfig | grep "inet " | awk '\''{printf "\t%s\n", $2}'\'' && echo "External ip:" && curl -s ipinfo.io/ip | awk '\''{printf "\t%s\n", $0}'\'';'

## Kubectl
alias k=kubectl
alias kubectl=kubecolor
alias kx=kubectx
alias kn=kubens
alias kgp="kubectl get pods -o wide"

#Test
#
