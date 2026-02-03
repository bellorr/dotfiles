# Managed by chezmoi - Edit with: chezmoi edit ~/.zsh/transient.zsh

#### Transient Prompt ####
autoload -Uz add-zsh-hook
add-zsh-hook precmd transient-prompt-precmd

TRANSIENT_PROMPT="${PROMPT// prompt / prompt --profile transient }"

function transient-prompt-precmd {
    # Fix ctrl+c behavior
    TRAPINT() { transient-prompt; return $(( 128 + $1 )) }

    # Save transient prompt
    SAVED_PROMPT="$(eval "printf '%s' \"${TRANSIENT_PROMPT}\"")"
}

autoload -Uz add-zle-hook-widget
add-zle-hook-widget zle-line-finish transient-prompt

function transient-prompt() {
    # Add a newline to prevent overwriting the last line of output
    print -n '\n'
    # Use saved transient prompt
    PROMPT="$SAVED_PROMPT" zle .reset-prompt
}
