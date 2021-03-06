FROM alpine:3.12

RUN apk add --no-cache --update \
    rsync curl \
    apache2 apache2-utils \
    php7-apache2 \
    php7-cli \
    php7-posix \
    php7-apcu \
    php7-phar \
    php7-zlib \
    php7-zip \
    php7-bz2 \
    php7-ctype \
    php7-curl \
    php7-pdo_mysql \
    php7-pdo_pgsql \
    php7-mysqli \
    php7-pgsql \
    php7-redis \
    php7-json \
    php7-mcrypt \
    php7-xml \
    php7-dom \
    php7-iconv \
    php7-session \
    php7-intl \
    php7-gd \
    php7-pecl-imagick \
    php7-fileinfo \
    php7-mbstring \
    php7-opcache \
    php7-tokenizer \
    php7-simplexml \
    php7-xmlreader \
    php7-xmlwriter \
    php7-gmp \
    php7-bcmath \
    # for azcopy:
    libc6-compat && \
    curl -SLo /tmp/azcopy.tar.gz "https://azcopyvnext.azureedge.net/release20201106/azcopy_linux_amd64_10.7.0.tar.gz" && \
    tar -xf /tmp/azcopy.tar.gz --strip-components=1 -C /usr/bin && \
    chmod +x /usr/bin/azcopy && rm -f /tmp/azcopy.tar.gz


ADD ./httpd.conf /etc/apache2/httpd.conf
ADD ./php.ini /etc/php7/conf.d/03_prison.ini

RUN mkdir -p /srv/www

ADD ./prison-update-source /usr/bin/prison-update-source
ADD ./prison-start /usr/bin/prison-start
RUN chmod +x /usr/bin/prison-update-source /usr/bin/prison-start

CMD ["/usr/bin/prison-start"]
