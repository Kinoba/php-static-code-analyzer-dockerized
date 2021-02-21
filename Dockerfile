FROM phpdockerio/php74-fpm:latest

ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV PATH="/home/phpman/.config/composer/vendor/bin/:/usr/share/dependency-check/bin:${PATH}"

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN useradd -ms /bin/bash phpman \
  && curl -SL https://github.com/theseer/phpdox/releases/download/0.12.0/phpdox-0.12.0.phar --silent -o phpdox-0.12.0.phar \
  && mv phpdox-0.12.0.phar /usr/local/bin/phpdox \
  && chmod +x /usr/local/bin/phpdox \
  && curl -L https://github.com/jeremylong/DependencyCheck/releases/download/v6.0.2/dependency-check-6.0.2-release.zip --output dependency-check-6.0.2-release.zip \
  && unzip dependency-check-6.0.2-release.zip \
  && mv dependency-check /usr/share/ \
  && curl -L https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.19.tar.gz | tar xz \
  && mv mysql-connector-java-8.0.19 /var/lib/mysql/

USER phpman

RUN composer global require \
    friendsoftwig/twigcs \
    pdepend/pdepend \
    phploc/phploc \
    phpmd/phpmd \
    phpstan/extension-installer \
    phpstan/phpstan \
    phpstan/phpstan-symfony \
    sebastian/phpcpd \
    squizlabs/php_codesniffer

WORKDIR /app