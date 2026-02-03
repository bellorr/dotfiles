# Chezmoi Template Examples

## Common Template Patterns for Personal vs Work Setup

### 1. Git Config Template

**File**: `dot_gitconfig.tmpl`

```toml
[user]
    name = Your Name
{{- if eq .machine_type "work" }}
    email = you@company.com
{{- else }}
    email = you@personal.com
{{- end }}

[core]
    editor = nvim

{{- if eq .machine_type "work" }}
[url "git@github.com-work:"]
    insteadOf = git@github.com:
{{- end }}
```

### 2. SSH Config with Conditional Hosts

**File**: `private_dot_ssh/config.tmpl`

```ssh
# Personal hosts (always included)
Host personal-server
    HostName example.com
    User youruser
    IdentityFile ~/.ssh/personal_key

{{- if eq .machine_type "work" }}
# Work-specific hosts
Host work-*.company.com
    User {{ .chezmoi.username }}
    IdentityFile ~/.ssh/work_key
    ProxyJump bastion.company.com
{{- end }}
```

### 3. Shell Environment Variables

**File**: `dot_zsh/vars.zsh.tmpl`

```bash
# Environment variables

{{- if eq .machine_type "work" }}
# Work environment
export AWS_PROFILE=work-profile
export KUBECONFIG=~/.kube/work-config
export VAULT_ADDR=https://vault.company.com
{{- else }}
# Personal environment
export AWS_PROFILE=personal
export KUBECONFIG=~/.kube/config
{{- end }}

# Universal variables
export EDITOR=nvim
export VISUAL=nvim
```

### 4. Work-Specific Aliases

**File**: `dot_zsh/work_aliases.zsh.tmpl`

```bash
{{- if eq .machine_type "work" }}
# Work-specific aliases
alias vpn='sudo openconnect company-vpn.com'
alias prod='kubectl --context=production'
alias staging='kubectl --context=staging'
alias work-ssh='ssh -J bastion.company.com'
{{- end }}
```

### 5. Conditional Tool Configurations

**File**: `dot_config/tool/config.toml.tmpl`

```toml
{{- if eq .machine_type "work" }}
api_endpoint = "https://api.company.com"
timeout = 30
{{- else }}
api_endpoint = "https://api.example.com"
timeout = 10
{{- end }}

theme = "dark"
```

### 6. Machine-Specific Paths

**File**: `dot_zsh/paths.zsh.tmpl`

```bash
# PATH configuration

# Common paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

{{- if eq .machine_type "work" }}
# Work-specific paths
export PATH="/opt/company/tools:$PATH"
export PATH="$HOME/work/scripts:$PATH"
{{- end }}
```

## Using Multiple Variables

Add to `~/.config/chezmoi/chezmoi.toml`:

```toml
[data]
    machine_type = "work"
    has_vpn = true
    has_docker = true
    company_name = "ACME Corp"
```

Then in templates:

```bash
{{- if .has_vpn }}
# VPN configuration
alias startvpn='...'
{{- end }}

{{- if and (eq .machine_type "work") .has_docker }}
# Work Docker setup
export DOCKER_HOST=tcp://docker.company.com:2375
{{- end }}
```

## Detecting Machine by Hostname

Instead of manually setting machine type, auto-detect:

**File**: `.chezmoi.toml.tmpl`

```toml
{{- if eq .chezmoi.hostname "work-macbook" }}
[data]
    machine_type = "work"
{{- else if eq .chezmoi.hostname "MacBookPro" }}
[data]
    machine_type = "personal"
{{- end }}
```

## Secret Management

For secrets, use external password managers:

### 1Password Example

```bash
{{- if eq .machine_type "work" }}
export API_KEY={{ onepasswordRead "op://Work/API/credential" }}
{{- end }}
```

### Environment Variables for Secrets

```bash
# Set in ~/.config/chezmoi/chezmoi.toml [data] section
{{- if .work_api_key }}
export WORK_API_KEY="{{ .work_api_key }}"
{{- end }}
```

## Useful Template Functions

- `{{ .chezmoi.homeDir }}` - Home directory
- `{{ .chezmoi.username }}` - Current user
- `{{ .chezmoi.hostname }}` - Machine hostname
- `{{ .chezmoi.os }}` - OS (darwin, linux, etc.)
- `{{ .chezmoi.arch }}` - Architecture (arm64, amd64)
- `{{ if }}...{{ else }}...{{ end }}` - Conditional
- `{{ and condition1 condition2 }}` - Logical AND
- `{{ or condition1 condition2 }}` - Logical OR
- `{{ not condition }}` - Logical NOT

## Testing Templates

```bash
# Test a template locally
chezmoi execute-template < ~/.local/share/chezmoi/dot_file.tmpl

# See what would be applied
chezmoi diff

# Apply with dry-run
chezmoi apply --dry-run --verbose
```
