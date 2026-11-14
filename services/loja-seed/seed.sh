#!/bin/bash
# Produtos, cupons e clientes de exemplo da loja. As tabelas são criadas pela própria API
# (migrations na subida), então espera elas existirem; e só carrega com a loja vazia.
set -u
export MYSQL_PWD="$STORE_DB_PASS"  # pela variável o cliente não avisa de senha na linha de comando
q() { mysql -h mysql -ugamestore gamestore -N -e "$1" 2>/dev/null; }

for i in $(seq 1 60); do
  count=$(q "SELECT COUNT(*) FROM products") && break
  sleep 2
done
if [ -z "${count:-}" ]; then
  echo "a tabela products não apareceu; a loja subiu?" >&2
  exit 1
fi
if [ "$count" != "0" ]; then
  echo "loja já tem $count produto(s), seed ignorado"
  exit 0
fi
# o seed separa comandos com "-- @@" (formato do migrator da loja); pro cliente mysql basta tirar
grep -v '^-- @@' /seed.sql | mysql -h mysql -ugamestore gamestore
echo "seed da loja carregado"
