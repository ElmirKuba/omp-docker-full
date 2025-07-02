#!/bin/bash










# OpenMP сервера стоппер ________________________________________
chmod +x unix-scripts/omp_server_stopper.sh
source unix-scripts/omp_server_stopper.sh || {
    echo "Ошибка выполнения omp_server_stopper.sh"
    exit 1
}
# OpenMP сервера стоппер ________________________________________










# Компиляция gamemodes ________________________________________
if [ "$OMP_ENABLE_COMPILATION_GAMEMODES" = "true" ]; then
    echo "Выполняем компиляцию gamemodes"

    chmod +x unix-scripts/gamemodes_compiler.sh
    source unix-scripts/gamemodes_compiler.sh || {
        echo "Ошибка выполнения gamemodes_compiler.sh"
        exit 1
    }
else
    echo "Компиляция gamemodes отключена, по необходимости включите OMP_ENABLE_COMPILATION_GAMEMODES указав true в .env файле."
fi
# Компиляция gamemodes ________________________________________










# tail -f /dev/null









# # Запуск OpenMP сервера ________________________________________
cd omp-server

./omp-server
# # Запуск OpenMP сервера ________________________________________