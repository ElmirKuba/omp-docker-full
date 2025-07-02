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

echo "▶️  В контейнере service_omp_server_prod выполняем стоппер..."
docker exec service_omp_server_prod bash -c 'bash unix-scripts/omp_server_stopper.sh'

echo
echo "⏳ Вывод логов сервера 'service_omp_server_prod' в реальном времени (15 секунд)..."
timeout 15s docker logs -f service_omp_server_prod || true

echo
echo "🔽 Останавливаем контейнеры через docker compose down"
docker compose down

echo "✅ Контейнеры в $DEPLOY_ENV остановлены."