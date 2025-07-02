main(){}

#include <open.mp> // Стандартные возможности Open MultiPlayer
#include <a_mysql> // Для работы с СуБД MySQL
#include <PawnINI> // Для работы с файлами
#include <uuid> // UUID (универсальный уникальный идентификатор) - это стандартизированная реализация генерации уникальных последовательностей байтов.

#define SERVER_CONST_DIALOG_ID_REGISTER          1 // ID диалога ввода пароля при регистрации
#define SERVER_CONST_DIALOG_ID_LOGIN             2 // ID диалога ввода пароля при авторизации

// #define PLAYER_CONST_UUID_V4_WITH_UNIXTIME_LENGTH 47 // Количество символов в uuid v4 + unittime (without ms)
// #define PLAYER_CONST_PASSWORD_MIN_LENGTH          3 // Количество символов в пароле игрока минимум
// #define PLAYER_CONST_PASSWORD_MAX_LENGTH          32 // Количество символов в пароле игрока максимум

// #define PLAYER_CONST_INVALID                      0 // Статус игрока: Инвалидный статус
// #define PLAYER_CONST_JOINING_TO_GAME              1 // Статус игрока: Присоединяется к игре

// /** Описание состава конфигурации подклюения к базе данных */
// enum mysqlConnectConfig {
//   hostname[255], // Адрес подключения к СуБД MySQL
//   username[32],  // Имя пользователя подключения к СуБД MySQL
//   database[64],  // Название базы данных для подключения к СуБД MySQL
//   password[32],  // Пароль пользователя подключения к СуБД MySQL
// };
// /** Конфигурация подклюения к базе данных */
// new mysqlConnConf[mysqlConnectConfig];
// /** ХЗ что за структура данных, с 2015 не писал на pawn */
// new const mysqlConnectConfigIniStruct[][e_ini_struct_info] = {
//   {'s', mysqlConnectConfig:hostname, 255, 0, 8, "hostname"},
//   {'s', mysqlConnectConfig:username, 32,  0, 8, "username"},
//   {'s', mysqlConnectConfig:database, 64,  0, 8, "database"},
//   {'s', mysqlConnectConfig:password, 32,  0, 8, "password"}
// };

// new MySQL: mySQLConnectHandle; // Идентификатор активного подключения к СуБД MySQL



// /** Жизненный цикл запуска игрового сервера */
// public OnGameModeInit()
// {
// 	SetGameModeText("My first open.mp gamemode!");

// 	connectToMySQL();
// 	return 1;
// }

/* Генерация uuid_v4 + unixtime */
stock uuidV4WithUnixTimeGenerate(output[PLAYER_CONST_UUID_V4_WITH_UNIXTIME_LENGTH + 1])
{
  new uuid[UUID_LEN];
  UUID(uuid, UUID_LEN);

  new unixtime = gettime();

  new fmtString[] = "%s_%d";
  format(output, sizeof (output), fmtString, uuid, unixtime);
}

// /** Подключение к СуБД MySQL */
// stock connectToMySQL() {
// 	// TODO: ElmirKuba 2025-06-28: Реализовать возможность редактирования данных подключения на горячую при запущенном сервер из игры и в будущем на веб морде сайта передав данные через web-sockets
// 	// INI_saveWhole_NoSections("mysql_config.txt", mysqlConnConf, sizeof(mysqlConnConf), mysqlConnectConfigIniStruct, sizeof(mysqlConnectConfigIniStruct), "mysql_ini"); // Описать момент записи, когда будет нужен

// 	/*
// 	! Читаем файл конфигурации для получения сервером актуальных данных которые требуются чтобы подключиться к СуБД MySQL.
// 	? Зачем? Основная площадка запуска сервера это контейнер в Docker.
// 	Скрипты выполняемые в контейнере обновят файл "mysql_config.txt" до запуска игрового сервера, а он уже в свою очередь прочитает их оттуда, так как не умеет работать с переменными среды Linux.
// 	Данные в скрипты, которые редактируют файл "mysql_config.txt" попадают из ".env" файла в корне проекта.
// 	*/
// 	INI_readWhole_NoSections("mysql_config.txt", mysqlConnConf, sizeof(mysqlConnConf), mysqlConnectConfigIniStruct, sizeof(mysqlConnectConfigIniStruct), "mysql_ini", false);

// 	new MySQLOpt: optionId = mysql_init_options();

// 	mysql_set_option(optionId, AUTO_RECONNECT, true);

// 	mySQLConnectHandle = mysql_connect(mysqlConnConf[hostname], mysqlConnConf[username], mysqlConnConf[password], mysqlConnConf[database], optionId);
//   mysql_set_charset("cp1251");
//   mysql_query(mySQLConnectHandle, !"SET CHARACTER SET 'utf8'", false);
//   mysql_query(mySQLConnectHandle, !"SET NAMES 'utf8'", false); 
//   mysql_query(mySQLConnectHandle, !"SET character_set_client = 'cp1251'", false); 
//   mysql_query(mySQLConnectHandle, !"SET character_set_connection = 'cp1251'", false); 
//   mysql_query(mySQLConnectHandle, !"SET character_set_results = 'cp1251'", false); 
//   mysql_query(mySQLConnectHandle, !"SET SESSION collation_connection = 'utf8_general_ci'", false); 
	
// 	printf(" ");
// 	printf("-----------------------------------------------------------------------------------------------------------------------------------------------------------");
// 	printf("|  My first open.mp gamemode!                                                                                                                             |");
// 	printf("|                                                                                                                                                         |");
// 	printf("| MySQL:                                                                                                                                                  |");
// 	switch(mysql_errno())
// 	{
// 		case 0: print(!"| [Info] [DataBase] Connect to DB - Success!                                                                                                              |");
// 		case 1044:    print(!"| [Error] [DataBase] #1044 - Error connecting to the database! [The user has been denied access to the database]                                          |");
// 		case 1045: print(!"| [Error] [DataBase] #1045 - Error connecting to the database! [[User denied access (Incorrect password)]                                                 |");
// 		case 1049: print(!"| [Error] [DataBase] #1049 - Error connecting to the database! [Unknown DATABASE]                                                                         |");
// 		case 2003: print(!"| [Error] [DataBase] #2003 - Error connecting to the database! [Unable to connect to MySQL server]                                                        |");
// 		case 2005: print(!" [Error] [DataBase] #2005 - Error connecting to the database! [Unknown server]                                                                            |");
// 		default: printf("| [Error] [DataBase] #%d - Error connecting to the database! [Unknown error]", mysql_errno());
// 	}
// 	printf("-----------------------------------------------------------------------------------------------------------------------------------------------------------");
// 	printf(" ");

// 	return 1;
// }


// public OnGameModeExit()
// {
//     mysql_close(mySQLConnectHandle);
// 	return 1;
// }

// public OnPlayerConnect(playerid)
// {
//   pData[playerid] = pPlayerNULL;

//   pData[playerid][playerStatus] = PLAYER_CONST_JOINING_TO_GAME;
// 	return 1;
// }

public OnPlayerDisconnect(playerid, reason)
{
  saveAccount(playerid);
	return 1;
}

// public OnPlayerRequestClass(playerid, classid)
// {
  // if (pData[playerid][playerStatus] == PLAYER_CONST_JOINING_TO_GAME) {
    // GetPlayerName(playerid, pData[playerid][nickName], MAX_PLAYER_NAME + 1);

    // new fmtString[] = "Привет %s, ты зашел к нам на сервер!";
    // new string[sizeof (fmtString) + MAX_PLAYER_NAME + 1];
    // format(string, sizeof (string), fmtString, pData[playerid][nickName]);
    // SendClientMessage(playerid, -1, string);

    // SetSpawnInfo(playerid, NO_TEAM, 177, 1958.33, 1343.12, 15.36, 269.15, WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);

    // SpawnPlayer(playerid);

    // new fmtSqlQuery[] = "SELECT * FROM `accounts` WHERE `nickname` = '%s'";
    // new stringSqlQuery[sizeof (fmtSqlQuery) + MAX_PLAYER_NAME + 1];
    // format(stringSqlQuery, sizeof (stringSqlQuery), fmtSqlQuery, pData[playerid][nickName]);
    // mysql_tquery(mySQLConnectHandle, stringSqlQuery, "findPlayerAccount","i", playerid);
  // }
	// return 1;
// }

/* Результаты поиска аккаунта при входе в игру */
forward findPlayerAccount(playerid);
public findPlayerAccount(playerid) {
  new rows;
  cache_get_row_count(rows);

  if(!rows) {
    SendClientMessage(playerid, -1, "Регистрация нового пользователя");

    initProcessRegistrAccount(playerid);
  } else {
    SendClientMessage(playerid, -1, "Авторизация");

    initProcessAuthAccount(playerid);
  }
}

/* Начало процесса регистрации аккаунта */
stock initProcessRegistrAccount(playerid) {
  dlgPasswordEntryDuringReg(playerid);
}

/* Диалог ввода пароля при регистрации аккаунта */
stock dlgPasswordEntryDuringReg(playerid) {
  ShowPlayerDialog(playerid, SERVER_CONST_DIALOG_ID_REGISTER, DIALOG_STYLE_INPUT, "Регистрация нового аккаунта", "Введите пароль для регистрации нового аккаунта:", "Регистрация", "");
}

/* Завершить процесс создания аккаунта */
stock complProcRegistrAcc(playerid) {
  new uuidV4WithUnixTime[PLAYER_CONST_UUID_V4_WITH_UNIXTIME_LENGTH + 1];
  uuidV4WithUnixTimeGenerate(uuidV4WithUnixTime);
  format(pData[playerid][id], PLAYER_CONST_UUID_V4_WITH_UNIXTIME_LENGTH + 1, "%s", uuidV4WithUnixTime);

  new fmtSqlQuery[] = "INSERT INTO `accounts` \
  (`id`, \
    `nickname`, \
    `password` \
  ) VALUES ('%s', \
            '%s', \
            '%s' \
  )";
  new stringSqlQuery[
    sizeof (fmtSqlQuery) +
    PLAYER_CONST_UUID_V4_WITH_UNIXTIME_LENGTH +
    MAX_PLAYER_NAME + 
    PLAYER_CONST_PASSWORD_MAX_LENGTH +
    1
  ];
  format(stringSqlQuery, sizeof (stringSqlQuery), fmtSqlQuery, 
    pData[playerid][id],
    pData[playerid][nickName],
    pData[playerid][password]
  );
  mysql_tquery(mySQLConnectHandle, stringSqlQuery, "UploadPlayerAccountNumber", "i", playerid);
}

/* Результат успешной регистрации аккаунта игрока */
forward UploadPlayerAccountNumber(playerid);
public UploadPlayerAccountNumber(playerid) {
  new fmtString[] = "Аккаунт %s зарегистрирован на сервере!";
  new string[sizeof (fmtString) + MAX_PLAYER_NAME + 1];
  format(string, sizeof (string), fmtString, pData[playerid][nickName]);
  SendClientMessage(playerid, -1, string);
}

/* Сохранение аккаунта игрока */
stock saveAccount(playerid) {
    new fmtSqlQuery[] = "UPDATE `accounts` SET \
                        `nickname` = '%s', \
                        `password` = '%s' \
                        WHERE `id` = '%s' \
                        ";
    new stringSqlQuery[
      sizeof (fmtSqlQuery) +
      MAX_PLAYER_NAME + 
      PLAYER_CONST_PASSWORD_MAX_LENGTH +
      PLAYER_CONST_UUID_V4_WITH_UNIXTIME_LENGTH +
      1
    ];
    format(stringSqlQuery, sizeof (stringSqlQuery), fmtSqlQuery,
      pData[playerid][nickName],
      pData[playerid][password],
      pData[playerid][id]
    );
    mysql_tquery(mySQLConnectHandle, stringSqlQuery, "", "");
}

/* Начало процесса авторизации аккаунта */
stock initProcessAuthAccount(playerid) {
  dlgPasswordEntryDuringAuth(playerid);
}

/* Диалог ввода пароля при авторизации аккаунта */
stock dlgPasswordEntryDuringAuth(playerid) {
	cache_get_value_name(0, "password", pData[playerid][password], PLAYER_CONST_PASSWORD_MAX_LENGTH + 1);

  ShowPlayerDialog(playerid, SERVER_CONST_DIALOG_ID_LOGIN, DIALOG_STYLE_INPUT, "Авторизация аккаунта", "Введите пароль этого аккаунта:", "Авторизация", "");
}

/* Запрос за данными аккаунта игрока, который успешно авторизовался */
stock initLoadDataSuccesAuthAccount(playerid) {
  new fmtSqlQuery[] = "SELECT * FROM `accounts` WHERE `nickname` = '%s'";
  new stringSqlQuery[sizeof (fmtSqlQuery) + MAX_PLAYER_NAME + 1];
  format(stringSqlQuery, sizeof (stringSqlQuery), fmtSqlQuery, pData[playerid][nickName]);
  mysql_tquery(mySQLConnectHandle, stringSqlQuery, "loadedDataAccount","i", playerid);
}

/* Загрузка данных в переменные игрока, который успешно авторизовался */
forward loadedDataAccount(playerid);
public loadedDataAccount(playerid) {
	cache_get_value_name(0, "id",       pData[playerid][id],       PLAYER_CONST_UUID_V4_WITH_UNIXTIME_LENGTH + 1);
	cache_get_value_name(0, "nickName", pData[playerid][nickName], MAX_PLAYER_NAME + 1);
	cache_get_value_name(0, "password", pData[playerid][password], PLAYER_CONST_PASSWORD_MAX_LENGTH + 1);
	SendClientMessage(playerid, -1, "Успешно авторизировались!");
}

// public OnPlayerSpawn(playerid)
// {
// 	return 1;
// }

public OnPlayerDeath(playerid, killerid, WEAPON:reason)
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnPlayerText(playerid, text[])
{
  // TODO: ElmirKuba 2025-96-29: Чисто для теста что аккаунт сохраняется, потом удалить
  format(pData[playerid][password], PLAYER_CONST_PASSWORD_MAX_LENGTH + 1, "%s", text);
  saveAccount(playerid);
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, KEY:newkeys, KEY:oldkeys)
{
	return 1;
}

public OnPlayerStateChange(playerid, PLAYER_STATE:newstate, PLAYER_STATE:oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerGiveDamageActor(playerid, damaged_actorid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnActorStreamIn(actorid, forplayerid)
{
	return 1;
}

public OnActorStreamOut(actorid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    new length = strlen(inputtext);

    switch (dialogid) {
      case SERVER_CONST_DIALOG_ID_REGISTER: {
        if (!response) {
          SendClientMessage(playerid, -1, "[Ошибка] Диалог ввода пароля при регистрации нельзя закрыть!");
          dlgPasswordEntryDuringReg(playerid);
          return 1;
        }

        if (!length) {
          SendClientMessage(playerid, -1, "[Ошибка] Нельзя не вводить пароль при регистрации аккаунта!");
          dlgPasswordEntryDuringReg(playerid);
          return 1;
        }

        if (length < PLAYER_CONST_PASSWORD_MIN_LENGTH || length > PLAYER_CONST_PASSWORD_MAX_LENGTH) {
          SendClientMessage(playerid, -1, "[Ошибка] Длинна пароля от "#PLAYER_CONST_PASSWORD_MIN_LENGTH" до "#PLAYER_CONST_PASSWORD_MAX_LENGTH"!");
          dlgPasswordEntryDuringReg(playerid);
          return 1;
        }

        format(pData[playerid][password], PLAYER_CONST_PASSWORD_MAX_LENGTH + 1, "%s", inputtext);

        complProcRegistrAcc(playerid);
      }

      case SERVER_CONST_DIALOG_ID_LOGIN: {
        if (!response) {
          SendClientMessage(playerid, -1, "[Ошибка] Диалог ввода пароля при авторизации нельзя закрыть!");
          dlgPasswordEntryDuringAuth(playerid);
          return 1;
        }

        if (!length) {
          SendClientMessage(playerid, -1, "[Ошибка] Нельзя не вводить пароль при авторизации аккаунта!");
          dlgPasswordEntryDuringAuth(playerid);
          return 1;
        }

          if (length < PLAYER_CONST_PASSWORD_MIN_LENGTH || length > PLAYER_CONST_PASSWORD_MAX_LENGTH) {
            SendClientMessage(playerid, -1, "[Ошибка] Длинна пароля от "#PLAYER_CONST_PASSWORD_MIN_LENGTH" до "#PLAYER_CONST_PASSWORD_MAX_LENGTH"!");
            dlgPasswordEntryDuringAuth(playerid);
            return 1;
          }

          if(strcmp(pData[playerid][password], inputtext)) {
            SendClientMessage(playerid, -1, "[Ошибка] Не правильынй пароль от аккаунта!");
            dlgPasswordEntryDuringAuth(playerid);
            return 1;
          }

          initLoadDataSuccesAuthAccount(playerid);
      }
  }
	return 1;
}

public OnPlayerEnterGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeaveGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerEnterPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerLeavePlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerClickPlayerGangZone(playerid, zoneid)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnClientCheckResponse(playerid, actionid, memaddr, retndata)
{
	return 1;
}

// public OnRconLoginAttempt(ip[], password[], success)
// {
// 	return 1;
// }

public OnPlayerFinishedDownloading(playerid, virtualworld)
{
	return 1;
}

public OnPlayerRequestDownload(playerid, DOWNLOAD_REQUEST:type, crc)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 0;
}

public OnPlayerSelectObject(playerid, SELECT_OBJECT:type, objectid, modelid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, EDIT_RESPONSE:response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	return 1;
}

public OnPlayerEditAttachedObject(playerid, EDIT_RESPONSE:response, index, modelid, boneid, Float:fOffsetX, Float:fOffsetY, Float:fOffsetZ, Float:fRotX, Float:fRotY, Float:fRotZ, Float:fScaleX, Float:fScaleY, Float:fScaleZ)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnPlayerPickUpPlayerPickup(playerid, pickupid)
{
	return 1;
}

public OnPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamIn(pickupid, playerid)
{
	return 1;
}

public OnPlayerPickupStreamOut(pickupid, playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, WEAPON:weaponid, bodypart)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, CLICK_SOURCE:source)
{
	return 1;
}

public OnPlayerWeaponShot(playerid, WEAPON:weaponid, BULLET_HIT_TYPE:hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	return 1;
}

public OnIncomingConnection(playerid, ip_address[], port)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText:playertextid)
{
	return 1;
}

public OnTrailerUpdate(playerid, vehicleid)
{
	return 1;
}

public OnVehicleSirenStateChange(playerid, vehicleid, newstate)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnEnterExitModShop(playerid, enterexit, interiorid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
	return 1;
}

public OnUnoccupiedVehicleUpdate(vehicleid, playerid, passenger_seat, Float:new_x, Float:new_y, Float:new_z, Float:vel_x, Float:vel_y, Float:vel_z)
{
	return 1;
}
