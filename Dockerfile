FROM menci/archlinuxarm

RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm \
  i3status \
  i3-wm \
  dmenu \
  # obs-studio \
  sudo \
  yt-dlp \
  ffmpeg \
  vlc \
  git \
  net-tools \
  python3 \
  rxvt-unicode \
  supervisor \
  ttf-dejavu \
  x11vnc \
  xorg-server \
  xorg-apps \
  xorg-server-xvfb \
  xorg-xinit

# Install VNC. Requires net-tools, python and python-numpy
RUN git clone --branch v1.2.0 --single-branch https://github.com/novnc/noVNC.git /opt/noVNC
RUN git clone --branch v0.9.0 --single-branch https://github.com/novnc/websockify.git /opt/noVNC/utils/websockify
RUN ln -s /opt/noVNC/vnc.html /opt/noVNC/index.html

RUN export DISPLAY=:0.0

COPY supervisord.conf /etc/

EXPOSE 8083

RUN useradd -rm -d /home/user -s /bin/bash -g root -G sudo -u 1001 user 
USER user
WORKDIR /home/user

RUN git clone https://aur.archlinux.org/yay.git \
  cd yay \
  makepkg -si --noconfirm \
  cd .. \
  rm -rf yay

CMD ["/usr/bin/supervisord"]
