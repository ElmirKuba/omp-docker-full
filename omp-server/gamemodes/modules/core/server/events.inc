/** Жизненный цикл запуска игрового сервера */
public OnGameModeInit() {
	SetGameModeText(SERVER_MACROS_GAMEMODE_NAME);
  SendRconCommand("name "SERVER_MACROS_HOSTNAME);
  SendRconCommand("game.map "SERVER_MACROS_MAPNAME);
  SendRconCommand("language "SERVER_MACROS_LANGUAGE);

  ConnectMySQL_OnGameModeInit();

  createServerTextDraws();
}

/** Жизненный цикл остановки игрового сервера */
public OnGameModeExit() {
  ConnectMySQL_OnGameModeExit();

  destroyServerTextDraws();
}
