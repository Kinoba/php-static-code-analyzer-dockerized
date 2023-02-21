# Php static code analyzer

## Usage

```
docker run --rm -v $(pwd):/app kinoba/php-static-code-analyzer [static tool]
```

### Available tools

For now this image is able to run:

- Twigcs
- phpdox
- dependency-check
- phpstan
  - phpstan-symfony
  - phpstan-doctrine
- phploc
- phpmd
- phpcs
- pdepend

## Contribute

```bash
DOCKER_DEFAULT_PLATFORM=linux/amd64 docker build . -t kinoba/php-static-code-analyzer
docker push kinoba/php-static-code-analyzer
```

## TODO

