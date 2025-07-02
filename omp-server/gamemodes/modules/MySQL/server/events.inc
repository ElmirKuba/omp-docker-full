#include "../helpers/connect.inc"

/** Жизненный цикл запуска игрового сервера */
forward ConnectMySQL_OnGameModeInit();
public ConnectMySQL_OnGameModeInit() {
  connectToMySQL();
}

/** Жизненный цикл остановки игрового сервера */
forward ConnectMySQL_OnGameModeExit();
public ConnectMySQL_OnGameModeExit() {
  mysql_close(mySQLConnectHandle);
	return 1;
}