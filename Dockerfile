FROM ubuntu:22.04

RUN apt-get update && \
    apt-get -y install \
        apache2 \
        libapache2-mod-php \
        libapache2-mod-auth-openidc \
        php-bcmath \
        php-cli \
        php-curl \
        php-mbstring \
        php-gd \
        php-mysql \
        php-json \
        php-ldap \
        php-memcached \
        php-mime-type \
        php-pgsql \
        php-tidy \
        php-intl \
        php-xmlrpc \
        php-soap \
        php-uploadprogress \
        php-zip \
        libcap2-bin && \
    setcap 'cap_net_bind_service=+ep' /usr/sbin/apache2 && \
    dpkg --purge libcap2-bin && \
    apt-get -y autoremove && \
    a2disconf other-vhosts-access-log && \
    chown -Rh www-data. /var/run/apache2 && \
    apt-get -y install --no-install-recommends imagemagick && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    a2enmod rewrite headers expires ext_filter
    
    COPY attivita/index.php /var/www/html 
    RUN rm -f /var/www/html/index.html && \
    mkdir /var/www/html/.config && \
    tar cf /var/www/html/.config/etc-apache2.tar etc/apache2 && \
    tar cf /var/www/html/.config/etc-php.tar     etc/php && \
    dpkg -l > /var/www/html/.config/dpkg-l.txt

    EXPOSE 80
    USER www-data
    CMD ["apache2","-D", "FOREGROUND"]
