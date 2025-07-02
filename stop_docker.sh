#!/bin/bash
set -euo pipefail

# ожидаем, что DEPLOY_ENV задан
if [[ -z "${DEPLOY_ENV:-}" ]]; then
  echo "❌ DEPLOY_ENV не задан"
  exit 1
fi

echo "🛑 Останавливаем OpenMP сервер в окружении $DEPLOY_ENV"

# переходим в папку окружения
cd "/home/deploy/$DEPLOY_ENV"

# выполняем остановку
docker stop service_omp_server_prod
docker stop mysql_omp_server_prod

# TODO: ElmirKuba 2025-07-03: Часть скрипта которая сделает docker ps, найдет контейнеры с names которые имеют в себе под строку "_omp_server_" в названии и сделаем с каждым из них в цикле видимо docker stop <name> или получит их CONTAINER ID и по нему сделает со всеми docker stop

echo "✅ Контейнеры в $DEPLOY_ENV остановлены."
