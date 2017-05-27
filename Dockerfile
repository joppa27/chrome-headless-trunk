FROM node:6.10.2

USER root

LABEL maintainer "Alpeware <info@alpeware.com>"

ENV REV=475181

EXPOSE 9222

RUN apt-get update -qqy \
  && apt-get -qqy install libnss3 libnss3-tools libfontconfig1 wget ca-certificates apt-transport-https inotify-tools unzip \
  libpangocairo-1.0-0 libx11-xcb-dev libxcomposite-dev libxcursor1 libxdamage1 libxi6 libgconf-2-4 libxtst6 libcups2-dev \
  libxss-dev libxrandr-dev libasound2-dev libatk1.0-dev libgtk-3-dev ttf-ancient-fonts chromium-codecs-ffmpeg-extra \
  && rm -rf /var/lib/apt/lists/* /var/cache/apt/*

RUN wget -q -O chrome.zip https://commondatastorage.googleapis.com/chromium-browser-snapshots/Linux_x64/$REV/chrome-linux.zip \
  && unzip chrome.zip \
  && rm chrome.zip \
  && ln -s $PWD/chrome-linux/chrome /usr/bin/google-chrome-unstable

RUN google-chrome-unstable --version

ADD start.sh import_cert.sh /usr/bin/

#RUN mkdir /data
VOLUME /home/node/
ENV HOME=/home/node DEBUG_ADDRESS=0.0.0.0 DEBUG_PORT=9222

USER node
CMD ["/usr/bin/start.sh"]
