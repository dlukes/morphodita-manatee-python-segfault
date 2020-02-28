############################### STAGE  1 ###############################

FROM python:3.7-alpine3.11 as stage1

RUN apk add --no-cache \
  bison \
  build-base \
  curl \
  icu-dev \
  libtool \
  libxslt-dev \
  pcre-dev \
  swig

RUN mkdir -p /tmp/root

# MorphoDiTa models
ARG morphodita_models_url=https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11234/1-1836/czech-morfflex-pdt-161115.zip
RUN curl -sLo morphodita_models.zip $morphodita_models_url
RUN unzip -q morphodita_models.zip
RUN mv czech-morfflex-pdt-??????/czech-morfflex-pdt-??????.tagger /tmp/root

# NameTag models
ARG nametag_models_url=https://lindat.mff.cuni.cz/repository/xmlui/bitstream/handle/11858/00-097C-0000-0023-7D42-8/czech-cnec-140304.zip
RUN curl -sLo nametag_models.zip $nametag_models_url
RUN unzip -q nametag_models.zip
RUN mv czech-cnec-??????/czech-cnec2.0-??????.ner /tmp/root

# Python packages that require compilation (installs into /root/.local)
RUN pip install --user ufal.morphodita==1.9.2.3 ufal.nametag==1.1.2.1

# Manatee
ARG manatee_url=https://corpora.fi.muni.cz/noske/src/manatee-open/manatee-open-2.167.8.tar.gz
RUN curl -sLo manatee.tgz $manatee_url
RUN tar xzf manatee.tgz
RUN mv manatee-open-* manatee
WORKDIR /manatee
RUN ./configure --with-pcre PYTHON=/usr/local/bin/python3
RUN make
RUN make DESTDIR=/tmp install

############################### STAGE  2 ###############################

FROM python:3.7-alpine3.11

COPY --from=stage1 /tmp/usr /usr
COPY --from=stage1 /tmp/root /
COPY --from=stage1 /root/.local/ /usr/local/

# dynamic libs used by morphodita/nametag/manatee
RUN apk add --no-cache \
  libgcc \
  libltdl \
  libstdc++ \
  pcre \
  perl

COPY entrypoint.sh *.py /
ENTRYPOINT /entrypoint.sh
