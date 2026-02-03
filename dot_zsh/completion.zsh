# Managed by chezmoi - Edit with: chezmoi edit ~/.zsh/completion.zsh

#### Completion Engine ####

# Homebrew completions (must be before compinit)
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' menu select

compdef kubecolor=kubectl
