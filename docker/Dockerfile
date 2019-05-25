FROM debian:stable-slim

LABEL mitakeck <mitake.ck@gmail.com>

RUN mkdir -p /usr/share/man/man1
RUN apt-get update && apt-get install -y \
  jq \
  gcc \
  python3 \
  graphviz \
  default-jdk \
  libfontconfig \
  fontconfig\ 
  libssl1.0-dev \
  libxrender1 \
  libxtst6 \
  libjpeg62-turbo \
  make \
  unzip \
  openssh-client \
  rsync \
  wget \
  xz-utils \
  xfonts-75dpi \
  xfonts-base \
  && rm -rf /var/lib/apt/lists/*

RUN wget https://api.github.com/repos/jgm/pandoc/releases/latest -O - | jq -r '.assets[] | select(.name | index("amd64.deb")) | .browser_download_url' | wget -i - --quiet -O pandoc.deb \
  && dpkg -i pandoc.deb\
  && rm pandoc.deb

RUN wget https://api.github.com/repos/wkhtmltopdf/wkhtmltopdf/releases/latest -O - | jq -r '.assets[] | select(.name | index("stretch_amd64.deb")) | .browser_download_url' | wget -i - --quiet -O wkhtmltopdf.deb \
  && dpkg -i wkhtmltopdf.deb \
  && rm -rf wkhtmltopdf.deb

RUN wget "https://downloads.sourceforge.net/project/plantuml/plantuml.jar?r=http%3A%2F%2Fplantuml.com%2Fstarting&ts=1538667739&use_mirror=jaist" -O plantuml.jar \
  && cp plantuml.jar /usr/local/bin

RUN echo -e "#\!/bin/bash\n\
export LANG=ja_JP.UTF-8\n\
/usr/bin/java -Djava.io.tmpdir=/var/tmp -Djava.awt.headless=true -jar /usr/local/bin/plantuml.jar  -charset UTF-8 \${@}\n\
" >> /usr/bin/plantuml

RUN wget https://bootstrap.pypa.io/get-pip.py -O -| python3 \
  && pip install pandoc-plantuml-filter

RUN wget https://noto-website.storage.googleapis.com/pkgs/Noto-unhinted.zip \
  && unzip -d NotoSansJapanese Noto-unhinted.zip \
  && mkdir -p /usr/share/fonts/opentype \
  && mv -fv ./NotoSansJapanese /usr/share/fonts/opentype/NotoSansJapanese \
  && rm -rfv Noto-unhinted.zip \
  && fc-cache -fv

WORKDIR /source
ENTRYPOINT [""]