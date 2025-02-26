FROM manjarolinux/base

RUN command -v sudo || pacman -Sy --noconfirm sudo git zsh
RUN pacman -Sy --noconfirm git vim zsh xdg-user-dirs
RUN xdg-user-dirs-update

RUN useradd -m heron
RUN usermod -aG wheel heron
RUN echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
RUN echo 'heron:123' | chpasswd
USER heron

COPY --chown=heron:heron ./ /home/heron/Workbench/dotfiles

WORKDIR /home/heron/Workbench/dotfiles
