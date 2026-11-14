#!/bin/bash
# Roda uma vez, na primeira subida do MySQL (volume vazio): um banco e um usuário por serviço,
# cada usuário só enxerga o próprio banco.
set -euo pipefail

mysql -uroot -p"$MYSQL_ROOT_PASSWORD" <<SQL
CREATE DATABASE IF NOT EXISTS painel CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'painel'@'%' IDENTIFIED BY '${PAINEL_DB_PASS}';
GRANT ALL ON painel.* TO 'painel'@'%';

CREATE DATABASE IF NOT EXISTS gamestore CHARACTER SET utf8mb4;
CREATE USER IF NOT EXISTS 'gamestore'@'%' IDENTIFIED BY '${STORE_DB_PASS}';
GRANT ALL ON gamestore.* TO 'gamestore'@'%';
SQL
