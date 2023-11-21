FROM phpdockerio/php:8.2-fpm

ENV LC_ALL=C.UTF-8
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US.UTF-8
ENV PATH="/app/vendor/bin/:/usr/local/bin/:${PATH}"

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN apt-get update \
  && curl -SL https://github.com/theseer/phpdox/releases/download/0.12.0/phpdox-0.12.0.phar --silent -o phpdox-0.12.0.phar \
  && mv phpdox-0.12.0.phar /usr/local/bin/phpdox \
  && chmod +x /usr/local/bin/phpdox \
  && apt-get -y --no-install-recommends install git unzip zip \
  && apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/* \
  && useradd -ms /bin/bash phpman \
  && mkdir -p /app/vendor \
  && chown -R phpman:phpman /app

WORKDIR /app

USER phpman

COPY composer.json composer.lock ./
RUN composer install