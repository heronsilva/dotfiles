FROM manjarolinux/base

RUN pacman -Syu --noconfirm \
    && pacman -Sy --noconfirm sudo git zsh vim curl base-devel python python-pip

RUN useradd -m heron \
    && usermod -aG wheel heron \
    && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers \
    && echo 'heron:123' | chpasswd

USER heron

COPY --chown=heron:heron ./ /home/heron/Workbench/dotfiles
WORKDIR /home/heron/Workbench/dotfiles

RUN chmod +x ./bootstrap && ./bootstrap

CMD ["/bin/zsh"]
