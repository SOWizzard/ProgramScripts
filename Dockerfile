FROM archlinux:base-devel

RUN pacman -Syy
RUN pacman --noconfirm --needed -S python
WORKDIR /mnt 
