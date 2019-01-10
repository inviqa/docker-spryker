FROM php:7.2-fpm-alpine

RUN apk --update add \
    # package dependencies \
    bash \
    freetype \
    icu \
    iproute2 \
    libjpeg-turbo \
    libpng libxml2 \
    libxslt \
    shadow \
    supervisor \
    gmp-dev \
    postgresql-dev \
    graphviz \
    # package dependencies only needed for the duration of the build \
    autoconf \
    freetype-dev \
    g++ \
    icu-dev \
    libjpeg-turbo-dev \
    libpng-dev \
    libxml2-dev \
    libxslt-dev \
    make \
    libressl-dev \
    bzip2-dev \
    libedit-dev \
    # php extensions \
    && docker-php-ext-configure gd --with-gd --with-freetype-dir=/usr/include/ --with-png-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install \
    bcmath      \
    bz2         \
    gd          \
    gmp         \
    iconv       \
    intl        \
    mbstring    \
    mysqli      \
    opcache     \
    pdo         \
    pdo_mysql   \
    pdo_pgsql   \
    pgsql       \
    readline    \
    soap        \
    sockets     \
    xmlrpc      \
    xsl         \
    zip         \
    && pecl install xdebug && docker-php-ext-enable xdebug \
    # Install PHP redis extension
    && pecl install -o -f redis \
    && rm -rf /tmp/pear \
    && echo "extension=redis.so" > $PHP_INI_DIR/conf.d/docker-php-ext-redis.ini \
    # clean \
    && apk del \
    autoconf g++ make freetype-dev libjpeg-turbo-dev libpng-dev libressl-dev libxml2-dev libmcrypt-dev libxslt-dev icu-dev bzip2-dev libedit-dev \
    && rm -rf /var/cache/apk/*

WORKDIR /app