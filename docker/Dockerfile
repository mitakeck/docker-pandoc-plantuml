FROM alpine as dl-pandoc
WORKDIR /work
RUN apk update && apk add jq wget unzip
RUN wget https://api.github.com/repos/jgm/pandoc/releases/latest -O - | jq -r '.assets[] | select(.name | index("amd64.deb")) | .browser_download_url' | wget -i - --quiet -O pandoc.deb

FROM alpine as dl-wkhtmltopdf
WORKDIR /work
RUN apk update && apk add jq wget unzip
RUN wget https://api.github.com/repos/wkhtmltopdf/wkhtmltopdf/releases/latest -O - | jq -r '.assets[] | select(.name | index("stretch_amd64.deb")) | .browser_download_url' | wget -i - --quiet -O wkhtmltopdf.deb

FROM alpine as dl-plantuml
WORKDIR /work
RUN apk update && apk add jq wget unzip
RUN wget "https://downloads.sourceforge.net/project/plantuml/plantuml.jar?r=http%3A%2F%2Fplantuml.com%2Fstarting&ts=1538667739&use_mirror=jaist" -O plantuml.jar 

FROM alpine as dl-notofont
WORKDIR /work
RUN apk update && apk add jq wget unzip
RUN wget https://noto-website.storage.googleapis.com/pkgs/Noto-unhinted.zip \
  && unzip -d NotoSansJapanese Noto-unhinted.zip \
  && rm Noto-unhinted.zip

FROM alpine as dl-pip
WORKDIR /work
RUN apk update && apk add jq wget 
RUN wget https://bootstrap.pypa.io/get-pip.py

FROM debian:stretch
RUN mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get install -y \
  gcc \
  python3 \
  graphviz \
  default-jdk \
  libfontconfig \
  fontconfig \ 
  fonts-ipafont \
  task-japanese \
  libssl1.0-dev \
  libxrender1 \
  libxtst6 \
  libjpeg62-turbo \
  make \
  openssh-client \
  rsync \
  locales \
  xz-utils \
  xfonts-75dpi \
  xfonts-base \
  && rm -rf /var/lib/apt/lists/*

COPY --from=dl-pandoc /work /root
RUN dpkg -i /root/pandoc.deb\
  && rm /root/pandoc.deb

COPY --from=dl-wkhtmltopdf /work /root
RUN dpkg -i /root/wkhtmltopdf.deb \
  && rm -rf /root/wkhtmltopdf.deb

COPY --from=dl-plantuml /work /root
RUN cp /root/plantuml.jar /usr/local/bin

RUN echo "#!/bin/bash\n\
  export LANG=ja_JP.UTF-8; \n\
  /usr/bin/java -Djava.io.tmpdir=/var/tmp -Djava.awt.headless=true -jar /usr/local/bin/plantuml.jar -charset UTF-8 \${@}\n\
  " >> /usr/bin/plantuml \
  && chmod +x /usr/bin/plantuml

COPY --from=dl-pip /work /root
COPY pandoc-plantuml.py /root
RUN python3 /root/get-pip.py \
  && pip install pandocfilters \
  && rm /root/get-pip.py \
  && ln -s /usr/bin/python3 /usr/bin/python

COPY --from=dl-notofont /work/NotoSansJapanese /usr/share/fonts/opentype/NotoSansJapanese
RUN fc-cache -fv

RUN echo "ja_JP.UTF-8 UTF-8" > /etc/locale.gen \
  && locale-gen ja_JP.UTF-8
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:en
ENV LC_ALL ja_JP.UTF-8

WORKDIR /source
ENTRYPOINT [""]