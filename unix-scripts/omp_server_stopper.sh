#!/bin/bash

current_pid=$$
running=$(pgrep -f "./omp-server" | grep -v "$current_pid")

if [[ -n "$running" ]]; then
  echo "Найдены процессы omp-server: $running"

  # Шаг 1: мягкий SIGTERM
  echo "$running" | xargs kill -15
  echo "Отослали SIGTERM, ждём завершения..."

  # Ждём, пока не уйдут
  while pgrep -f "./omp-server" | grep -v "$current_pid" > /dev/null; do
    sleep 1
  done

  echo "Процессы omp-server завершились корректно."
else
  echo "Процессы omp-server не найдены. Пропускаем."
fi
