#!/bin/bash

echo "Запускатор для Open MultiPlayer сервера в режиме разработки"

chmod -R 777 omp-server/bans.json || echo "omp-server/bans.json не найден или недоступен"
chmod -R 777 omp-server/config.json || echo "omp-server/config.json не найден или недоступен"










# Обновлятор конфиг-файлов ________________________________________
if [ "$OMP_ENABLE_CONFIG_UPDATER" = "true" ]; then
    echo "Выполняем обновление конфиг-файлов"

    chmod +x unix-scripts/config_updater.sh
    source unix-scripts/config_updater.sh || {
        echo "Ошибка выполнения config_updater.sh"
        exit 1
    }
else
    echo "Обновлятор конфиг-файлов отключен, по необходимости включите OMP_ENABLE_CONFIG_UPDATER указав true в .env файле."
fi
# Обновлятор конфиг-файлов ________________________________________










# OpenMP сервера стартер ________________________________________
if ! command -v nodemon &> /dev/null; then
    echo "nodemon не установлен. Установите nodemon перед запуском этого скрипта."
    exit 1
fi

chmod +x unix-scripts/omp_server_starter.sh

nodemon
# OpenMP сервера стартер ________________________________________