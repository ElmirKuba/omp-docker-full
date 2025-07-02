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

echo "✅ Контейнеры в $DEPLOY_ENV остановлены."
