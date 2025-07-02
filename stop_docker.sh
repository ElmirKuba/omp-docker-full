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

LOG_TMP="/tmp/omp_stop_logs.tmp"
> "$LOG_TMP"
echo "📝 Начинаем вывод логов контейнера service_omp_server_prod в фоне"
docker logs -f service_omp_server_prod >> "$LOG_TMP" 2>&1 &
LOG_PID=$!

echo
echo "⏳ Ждём 15 секунд, выводим логи и обратный отсчёт..."
for i in $(seq 15 -1 1); do
  # Счётчик
  printf "\rОсталось %2d сек… " "$i"
  # Вывод новых строк логов
  tail -n +1 "$LOG_TMP"
  # Очищаем временный лог-файл, чтобы не дублировать
  > "$LOG_TMP"
  sleep 1
done

kill "$LOG_PID" >/dev/null 2>&1 || true
wait "$LOG_PID" 2>/dev/null || true

echo -e "\n✅ Таймер завершён, логи остановлены."

echo "🔽 Останавливаем контейнеры через docker compose down"
docker compose down

echo "✅ Все контейнеры остановлены."

