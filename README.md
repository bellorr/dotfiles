# Chezmoi Dotfiles Setup

This repository manages dotfiles across multiple machines using Chezmoi templating.

## Machine Setup

### Personal Laptop (Current Machine)
Already configured! Machine type: `personal`

### Work Laptop Setup

When setting up on your work laptop:

1. Install and initialize chezmoi:
   ```bash
   chezmoi init https://github.com/YOUR_USERNAME/YOUR_REPO.git
   ```

2. Create/edit `~/.config/chezmoi/chezmoi.toml`:
   ```toml
   [git]
       autoAdd = true
       autoCommit = true
       autoPush = true

   [diff]
       pager = "less -R"

   [edit]
       apply = true

   [data]
       machine_type = "work"  # <-- Set to "work" here
   ```

3. Apply the configuration:
   ```bash
   chezmoi apply
   ```

## How Templating Works

### Template Syntax

Files with `.tmpl` suffix use Go templates with Chezmoi data:

- `{{ .chezmoi.homeDir }}` - Current user's home directory
- `{{ .chezmoi.username }}` - Current username
- `{{ .machine_type }}` - Custom variable from config
- `{{- if eq .machine_type "work" }}...{{- end }}` - Conditional sections

### Current Templates

- **`dot_zsh/integrations.zsh.tmpl`**: Work-specific shell integrations
  - On work machine: Loads tunnel-goat and kubejumper
  - On personal machine: Empty (header only)

### Available Variables

From `~/.config/chezmoi/chezmoi.toml` `[data]` section:
- `.machine_type` - "personal" or "work"

Built-in Chezmoi variables:
- `.chezmoi.homeDir` - Home directory path
- `.chezmoi.username` - Current username
- `.chezmoi.hostname` - Machine hostname
- `.chezmoi.os` - Operating system

## Common Templating Patterns

### Conditional Content by Machine Type

```bash
{{- if eq .machine_type "work" }}
# Work-specific configuration
export WORK_VAR="value"
{{- else }}
# Personal configuration
export PERSONAL_VAR="value"
{{- end }}
```

### Using Dynamic Home Directory

```bash
# Instead of hardcoded paths like /Users/nrebello
source "{{ .chezmoi.homeDir }}/.config/tool/config"
```

### Machine-Specific Files

Two approaches:

1. **Templates with conditionals** (current approach)
   - Single file with `{{- if }}` blocks
   - Pro: All logic in one place
   - Con: File exists on all machines

2. **Separate files with `.chezmoiignore`**
   - Create `file.work` and `file.personal`
   - Use `.chezmoiignore` to exclude based on machine
   - Pro: Cleaner separation
   - Con: More files to manage

## Best Practices

1. **Never commit secrets** - Use `~/.config/chezmoi/chezmoi.toml` for machine-specific data
2. **Test templates** - Run `chezmoi execute-template < file.tmpl` to test
3. **Preview changes** - Use `chezmoi diff` before `chezmoi apply`
4. **Use built-in variables** - Prefer `.chezmoi.homeDir` over hardcoded paths
5. **Keep it simple** - Only template what needs to differ between machines

## Useful Commands

```bash
# Preview changes
chezmoi diff

# Apply changes
chezmoi apply

# Edit a file (auto-applies on save)
chezmoi edit ~/.zshrc

# Add a new file
chezmoi add ~/.config/newfile

# See current data/variables
chezmoi data

# Test a template
chezmoi execute-template < dot_file.tmpl

# Check what chezmoi manages
chezmoi managed
```

## Next Steps

Consider templating these files based on your needs:

- **Git config** - Different emails for work/personal
- **SSH config** - Different hosts and keys
- **Shell aliases** - Work-specific commands
- **Tool configs** - Different settings per environment

## File Naming Convention

- `dot_filename` → `.filename`
- `dot_config/tool/config` → `.config/tool/config`
- `filename.tmpl` → Processed as template, `.tmpl` removed
- `private_filename` → Permissions set to 600
- `executable_filename` → Permissions set to 755
