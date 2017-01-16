FROM ruby:2.2.4

MAINTAINER yamaguchi@vic.co.jp

WORKDIR /tmp

ENV GEOS_VER 3.5.1
ENV PROJ_VER 4.9.3

RUN curl http://download.osgeo.org/geos/geos-${GEOS_VER}.tar.bz2 | tar jxf - \
 && cd geos-${GEOS_VER} \
 && ./configure \
 && make \
 && make install \
 && cd .. \
 && rm -rf geos-${GEOS_VER}
 
RUN curl http://download.osgeo.org/proj/proj-${PROJ_VER}.tar.gz | tar zxf - \
 && cd proj-${PROJ_VER} \
 && ./configure \
 && make \
 && make install \
 && cd .. \
 && rm -rf proj-${PROJ_VER}

RUN apt-get update \
 && apt-get install -y \
        postgresql-client \
        nodejs \
        npm \
        gfortran \
        --no-install-recommends \
 && rm -rf /var/lib/apt/lists/* \
 && update-alternatives --install /usr/bin/node node /usr/bin/nodejs 10 \
 && npm install -g bower \
 && npm cache clean \
 && echo '{ "allow_root": true }' > /root/.bowerrc

WORKDIR /
CMD ["/bin/bash"]
