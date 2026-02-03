# Managed by chezmoi - Edit with: chezmoi edit ~/.zsh/completion.zsh

#### Completion Engine ####
autoload -Uz +X compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select
compdef kubecolor=kubectl
