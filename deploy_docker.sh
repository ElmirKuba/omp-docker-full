#!/bin/bash

# chmod +x deploy_docker.sh 
# DEPLOY_ENV=dev1111 DEPLOY_BRANCH=develop  ./deploy_docker.sh 

set -e

echo "🚀 Старт деплоя: окружение = $DEPLOY_ENV, ветка = $DEPLOY_BRANCH"

# Проверим, что окружение и ветка заданы
if [[ -z "$DEPLOY_ENV" || -z "$DEPLOY_BRANCH" ]]; then
  echo "❌ DEPLOY_ENV или DEPLOY_BRANCH не заданы"
  exit 1
fi

# 0) Задаём целевое окружение в одном месте
# Можно передавать из вызывающей среды, например:
#   DEPLOY_ENV=test1111 ./deploy.sh
# или будет по-умолчанию prod7777
DEPLOY_ENV="${DEPLOY_ENV:-prod7777}"
PORT="${DEPLOY_ENV//[!0-9]/}"

check_and_create_dir() {
  local dir_path="$1"

  # Выводим сообщение о проверке
  echo -n "Проверка директории ${dir_path}: "

  if [ -d "${dir_path}" ]; then
    # Если каталог уже существует
    echo "✅ Существует (skip)."
  else
    # Если каталога нет — создаём рекурсивно
    echo "❌ Отсутствует. Создаю..."
    if mkdir -p "${dir_path}"; then
      echo "✅ ${dir_path} успешно создан."
    else
      echo "❌ Не удалось создать ${dir_path}!"
      # При необходимости можно здесь завершить скрипт с ошибкой:
      # exit 1
    fi
  fi
}

# Вызываем функцию для двух путей
check_and_create_dir "/home/deploy"
check_and_create_dir "/home/deploy/${DEPLOY_ENV}"

# Проверка и установка git
echo -n "Проверка git: "
if command -v git >/dev/null 2>&1; then
  echo "✅ Установлен (skip)."
else
  echo "❌ Отсутствует. Устанавливаем..."
  apt update
  apt install -y git
  if command -v git >/dev/null 2>&1; then
    echo "✅ git успешно установлен."
  else
    echo "❌ Не удалось установить git!"
  fi
fi

# Проверка и установка curl
echo -n "Проверка curl: "
if command -v curl >/dev/null 2>&1; then
  echo "✅ Установлен (skip)."
else
  echo "❌ Отсутствует. Устанавливаем..."
  apt update
  apt install -y curl
  if command -v curl >/dev/null 2>&1; then
    echo "✅ curl успешно установлен."
  else
    echo "❌ Не удалось установить curl!"
  fi
fi

# Функция для проверки всех условий работоспособности Docker
is_docker_fully_available() {
  # Проверка наличия бинарника docker
  if ! command -v docker >/dev/null 2>&1; then
    return 1
  fi

  # Проверка запущенности сервиса docker
  if ! systemctl is-active --quiet docker 2>/dev/null && ! service docker status >/dev/null 2>&1; then
    return 1
  fi

  # Проверка containerd
  if ! systemctl is-active --quiet containerd 2>/dev/null; then
    return 1
  fi

  # Проверка доступности docker API (через info или network ls)
  if ! docker info >/dev/null 2>&1 || ! docker network ls >/dev/null 2>&1; then
    return 1
  fi

  return 0
}

# Запускаем проверку и установку Docker
if ! is_docker_fully_available; then
  echo "❌ Docker полностью недоступен или работает некорректно."
  
  apt update
  apt upgrade -y

  cd /home/deploy/
  curl -fsSL https://get.docker.com -o get-docker.sh
  bash get-docker.sh

else
  echo "✅ Docker полностью доступен и исправен (skip)."
fi

cd "/home/deploy/${DEPLOY_ENV}"

# Если репозиторий уже склонирован — делаем pull, иначе — clone
if [ ! -d ".git" ]; then
  echo "❌ Репозиторий не найден, выполняем git clone ветки $DEPLOY_BRANCH..."
  git clone --depth=1 --branch "$DEPLOY_BRANCH" \
    git@github.com:ElmirKuba/omp-docker-full.git .
else
  echo "✅ Репозиторий уже существует, сбрасываем его в состояние $DEPLOY_BRANCH..."
  git fetch origin "$DEPLOY_BRANCH" --depth=1
  git reset --hard "origin/$DEPLOY_BRANCH"
fi

echo -n "Создание Docker-сети network_omp_server (если ещё нет): "
docker network create network_omp_server 2>/dev/null \
  && echo "✅ Успешно или уже было." \
  || echo "✅ Уже существует, продолжаем."

# Подставляем значение в .env по полному пути
ENV_FILE="/home/deploy/${DEPLOY_ENV}/.env"
echo -n "Подставляем OMP_SERVER_PORT=${PORT} в ${ENV_FILE}: "
if sed -i -E "s/^OMP_SERVER_PORT=.*/OMP_SERVER_PORT=${PORT}/" "${ENV_FILE}"; then
  echo "✅"
else
  echo "❌ Не удалось заменить OMP_SERVER_PORT в ${ENV_FILE}!"
  exit 1
fi

docker compose down

docker compose -f "/home/deploy/${DEPLOY_ENV}/docker/compose-files/docker-compose.production.yml" \
  --env-file "/home/deploy/${DEPLOY_ENV}/.env" \
  up --build -d

echo
echo "⏳ Вывод логов контейнера 'service_omp_server_prod' в течение 45 секунд..."

# Запускаем docker logs -f в фоне, перенаправляем в tmp файл
LOG_FILE="/tmp/omp_docker_logs_tmp.log"
> "$LOG_FILE" # очищаем перед использованием

# Запускаем фоновый процесс логов
docker logs -f service_omp_server_prod >> "$LOG_FILE" 2>&1 &
LOG_PID=$!

# 45-секундный таймер с выводом и логами
for i in $(seq 45 -1 1); do
  printf "\r⏳ Осталось %2d сек... " "$i"

  # Печатаем только новые строки логов
  tail -n +1 "$LOG_FILE"

  # Стираем лог-файл, чтобы не дублировать строки в следующей итерации
  > "$LOG_FILE"

  sleep 1
done

# Останавливаем фоновый процесс логов
kill "$LOG_PID" >/dev/null 2>&1 || true
wait "$LOG_PID" 2>/dev/null || true

echo -e "\n✅ Контейнер 'service_omp_server_prod' должен быть успешно запущен."