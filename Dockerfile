  FROM pjvleeuwen/php-composer:7.1.5-apache
     # DRUPAL requirements:
   RUN apt-get update && \
       `# apache mod_rewrite` \
       a2enmod rewrite && \
       `# PHP intl` \
       apt-get install -y zlib1g-dev libicu-dev g++ && \
       docker-php-ext-configure intl && \
       docker-php-ext-install intl && \
       apt-get purge -y zlib1g-dev g++ && \
       `# PHP gd` \
       apt-get install -y libfreetype6-dev && \
       docker-php-ext-install -j$(nproc) iconv && \
       docker-php-ext-configure gd --with-freetype-dir=/usr/include/ && \
       docker-php-ext-install -j$(nproc) gd && \
       `# PHP opcache` \
       docker-php-ext-enable opcache && \
       `# cleanup` \
       apt-get autoremove -y && \
       rm -rf /var/lib/apt/lists/*
  COPY php.ini /usr/local/etc/php/

