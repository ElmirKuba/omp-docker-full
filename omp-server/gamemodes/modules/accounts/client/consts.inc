/** Описание статусов игрока */
enum PLAYER_STATUSES {
  INVALID = 0, // Инвалидный статус
  JOINING_TO_GAME = 1 // Присоединяется к игре
}

/* Статусы игрока */
new PLAYER_STATUS[PLAYER_STATUSES];

/* Описание полей данных игрока */
enum playerData {
	playerStatus, // Статус игрока в настоящий момент времени
	id[PL_UUID_V4_WITH_UNIXTIME_LENGTH + 1], // Идентификатор аккаунта игрока uuid_v4 + unixtime
	nickName[MAX_PLAYER_NAME + 1], // Ник игрока (логин аккаунта игрока)
	password[PL_PASSWORD_MAX_LENGTH + 1], // Захешированный пароль аккаунта игрока
}

new pData[MAX_PLAYERS][playerData]; // Данные игрока по слотно
new pPlayerNULL[playerData]; // Данные для обнуления данных игрока


