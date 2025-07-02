#!/bin/bash

echo "Продакшн запускатор для Open MultiPlayer сервера"

chmod -R 777 /service_omp_server_prod/omp-server/bans.json || echo "/service_omp_server_prod/omp-server/bans.json не найден или недоступен"
chmod -R 777 /service_omp_server_prod/omp-server/config.json || echo "/service_omp_server_prod/omp-server/config.json не найден или недоступен"










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










chmod +x unix-scripts/omp_server_starter.sh

bash unix-scripts/omp_server_starter.sh