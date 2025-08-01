FROM debian:bookworm-slim

ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt update && apt install -y \
    xfce4 xfce4-goodies \
    x11vnc xvfb supervisor wget unzip python3 git curl dbus-x11 \
    && rm -rf /var/lib/apt/lists/*

# Install Brave using Brave's official script
RUN curl -fsS https://dl.brave.com/install.sh | bash

# Install noVNC and websockify
RUN mkdir -p /opt/novnc && \
    wget https://github.com/novnc/noVNC/archive/refs/heads/master.zip -O /tmp/novnc.zip && \
    unzip /tmp/novnc.zip -d /opt/ && \
    mv /opt/noVNC-master/* /opt/novnc/ && \
    rm -rf /opt/noVNC-master && \
    git clone https://github.com/novnc/websockify /opt/novnc/utils/websockify && \
    chmod +x /opt/novnc/utils/websockify/run

# Set VNC password (empty for demo purposes)
RUN mkdir -p /root/.vnc && \
    x11vnc -storepasswd "" /root/.vnc/passwd

# Create Brave Safe Launcher
RUN echo '#!/bin/bash\n\
brave-browser --user-data-dir=/tmp/brave-profile --no-sandbox --disable-gpu --disable-software-rasterizer --disable-dev-shm-usage --disable-accelerated-2d-canvas --no-zygote --disable-crash-reporter' \
> /usr/local/bin/brave-safe && \
chmod +x /usr/local/bin/brave-safe

# Create XFCE Desktop Shortcut
RUN mkdir -p /root/Desktop && \
echo '[Desktop Entry]\n\
Version=1.0\n\
Type=Application\n\
Name=Brave (Safe Mode)\n\
Comment=Run Brave Browser with container-safe flags\n\
Exec=/usr/local/bin/brave-safe\n\
Icon=brave-browser\n\
Terminal=false' > /root/Desktop/BraveSafe.desktop && \
chmod +x /root/Desktop/BraveSafe.desktop

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 6080

CMD ["/usr/bin/supervisord"]
