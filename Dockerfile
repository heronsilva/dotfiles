FROM manjarolinux/base

# Install basic packages and setup sudo
RUN pacman -Sy --noconfirm sudo git zsh vim curl wget base-devel python python-pip
RUN pacman -Scc --noconfirm

# Create user and setup sudo
RUN useradd -m heron
RUN usermod -aG wheel heron
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN echo 'heron:123' | chpasswd

# Switch to user
USER heron

# Create necessary directories
RUN mkdir -p /home/heron/Workbench
RUN mkdir -p /home/heron/.local/bin

# Copy dotfiles
COPY --chown=heron:heron ./ /home/heron/Workbench/dotfiles

WORKDIR /home/heron/Workbench/dotfiles

# Make scripts executable
RUN chmod +x ./install ./_bootstrap

# Test the installation
RUN ./install

# Set default shell to zsh if available
RUN if [ -f /home/heron/.zshrc ]; then echo "Dotfiles installation completed successfully"; fi

# Default command
CMD ["/bin/zsh"]
