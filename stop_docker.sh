#!/bin/bash
set -euo pipefail

# 1) Проверяем DEPLOY_ENV
if [[ -z "${DEPLOY_ENV:-}" ]]; then
  echo "❌ DEPLOY_ENV не задан"
  exit 1
fi

echo "🛑 Останавливаем OpenMP сервер в окружении $DEPLOY_ENV"
cd "/home/deploy/$DEPLOY_ENV"

# 2) Останавливаем сервер внутри контейнера с таймаутом
echo "▶️  Выполняем stopper в контейнере service_omp_server_prod (таймаут 15s)"
if ! timeout 15s docker exec service_omp_server_prod \
     bash -c 'bash unix-scripts/omp_server_stopper.sh'; then
  echo "⚠️ stopper не успел завершиться за 15 секунд или упал"
fi

# 3) Стримим логи  (таймаут 15s)
echo
echo "⏳ Показ логов контейнера service_omp_server_prod (15 секунд)..."
if ! timeout 15s docker logs -f service_omp_server_prod; then
  echo "✅ Таймаут логов — 15 секунд прошло"
fi

# 4) Останавливаем инфраструктуру
echo
echo "🔽 Останавливаем контейнеры через docker compose down"
docker compose down

echo "✅ Все контейнеры остановлены в $DEPLOY_ENV."
