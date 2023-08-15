FROM archlinux:base

RUN pacman -Sy --noconfirm archlinux-keyring
RUN pacman -Syyu --noconfirm
RUN pacman -S --noconfirm \
  i3status \
  i3-wm \
  dmenu \
  obs-studio \
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

RUN useradd -m user
WORKDIR /home/user

CMD ["/usr/bin/supervisord"]
