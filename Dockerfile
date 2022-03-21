FROM phpdockerio/php74-fpm:latest

ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV PATH="/home/phpman/.config/composer/vendor/bin/:${PATH}"

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get update \
  && curl -SL https://github.com/theseer/phpdox/releases/download/0.12.0/phpdox-0.12.0.phar --silent -o phpdox-0.12.0.phar \
  && mv phpdox-0.12.0.phar /usr/local/bin/phpdox \
  && chmod +x /usr/local/bin/phpdox \
  && apt-get -y --no-install-recommends install git \
  && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
  && useradd -ms /bin/bash phpman \
  && mkdir -p /home/phpman/.config/composer/vendor \
  && ln -s /home/phpman/.config/composer/vendor /vendor \
  && chown -R phpman:phpman /home/phpman /vendor

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