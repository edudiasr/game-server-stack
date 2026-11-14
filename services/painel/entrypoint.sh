#!/bin/sh
set -e
cd /var/www/painel

# o MySQL pode demorar um pouco mesmo depois do healthcheck; tenta algumas vezes
for i in 1 2 3 4 5 6 7 8 9 10; do
  if bin/console migrar; then break; fi
  echo "banco ainda não aceita conexão, tentando de novo ($i)"
  sleep 3
done

# demonstração: só no banco vazio (a demo se recusa a rodar se já existe usuário)
if [ "${PAINEL_DEMO:-0}" = "1" ]; then
  bin/console demo || true
fi

exec docker-php-entrypoint "$@"
