# Dotfiles

Personal dotfiles configuration with support for macOS and Linux systems.

## Quick Installation (Recommended)

### One-line Remote Installation

For the fastest setup, run this single command:

```bash
curl -fsSL https://raw.githubusercontent.com/heronsilva/dotfiles/main/bootstrap | bash
```

This will:
- Automatically detect your operating system (macOS or Linux)
- Install prerequisites (Homebrew on macOS, package managers on Linux)
- Clone the repository
- Create backups of existing dotfiles
- Install and configure everything

### Manual Installation

If you prefer to clone the repository first:

```shell
git clone https://github.com/heronsilva/dotfiles.git ~/Workbench/dotfiles
cd ~/Workbench/dotfiles
./install
```

## Platform Support

### macOS
- Automatically installs Homebrew if not present
- Installs Xcode Command Line Tools if needed
- Installs packages via Brewfile
- Configures macOS-specific applications (Finicky, etc.)

### Linux
Supports major Linux distributions:
- **Ubuntu/Debian**: Uses `apt` package manager
- **Fedora/RHEL/CentOS**: Uses `dnf`/`yum` package manager
- **Arch/Manjaro**: Uses `pacman` package manager

## What's Included

- **Shell Configuration**: Zsh with custom configuration and aliases
- **Terminal Emulators**: Alacritty and WezTerm configurations
- **Editors**: Vim, Neovim, and IdeaVim configurations
- **Development Tools**: Git configuration, tmux, mise (tool version manager)
- **CLI Tools**: bat, fzf, ripgrep, fd, htop, and many more
- **Fonts**: Nerd Fonts for better terminal experience (macOS)

## Testing with Docker

Test the dotfiles installation on different Linux distributions:

```bash
# Test on all distributions
docker compose up --build --menu=false

# Test on specific distribution
docker compose up --build --menu=false ubuntu    # Ubuntu 22.04
docker compose up --build --menu=false fedora    # Fedora 38
docker compose up --build --menu=false manjaro   # Manjaro Linux

# Test _bootstrap script
docker compose up --build --menu=false _bootstrap-test
```

### Interactive Testing

```sh
# Run interactive container for manual testing
docker compose run ubuntu /bin/bash
docker compose run fedora /bin/bash
docker compose run manjaro /bin/zsh
```

## Manual Package Installation

If you want to install packages separately:

### macOS
```bash
brew bundle --file ./home/Brewfile
```

### Linux
```bash
# Ubuntu/Debian
sudo apt update
grep -v '^#' ./home/packages-apt.txt | grep -v '^$' | xargs sudo apt install -y

# Fedora/RHEL/CentOS
grep -v '^#' ./home/packages-dnf.txt | grep -v '^$' | xargs sudo dnf install -y

# Arch/Manjaro
sudo pacman -Sy
grep -v '^#' ./home/packages-pacman.txt | grep -v '^$' | xargs sudo pacman -S --noconfirm
```

## Backup and Recovery

The installation process automatically creates backups of existing dotfiles in:
```
~/.dotfiles_backup_YYYYMMDD_HHMMSS/
```

To restore from backup:
```bash
cp -r ~/.dotfiles_backup_YYYYMMDD_HHMMSS/* ~/
```

## Customization

- Edit `install.conf.yaml` to modify dotbot configuration
- Add packages to the appropriate package files (`Brewfile`, `packages-*.txt`)
- Customize shell configuration in `home/.zsh/`
- Modify application configs in `home/.config/`

## Troubleshooting

### Prerequisites Issues
The bootstrap script handles most prerequisites automatically. If you encounter issues:

**macOS:**
- Ensure Xcode Command Line Tools are installed: `xcode-select --install`
- Manually install Homebrew if needed: `/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

**Linux:**
- Ensure your system is up to date
- Install git manually if the bootstrap fails: `sudo apt install git` (Ubuntu) or equivalent

### Permission Issues
If you encounter permission issues, ensure your user has sudo privileges or run the installation as a user with appropriate permissions.
****
