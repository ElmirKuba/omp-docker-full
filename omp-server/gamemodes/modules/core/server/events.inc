/** ��������� ���� ������� �������� ������� */
public OnGameModeInit() {
	SetGameModeText(SERVER_MACROS_GAMEMODE_NAME);
  SendRconCommand("name "SERVER_MACROS_HOSTNAME);
  SendRconCommand("game.map "SERVER_MACROS_MAPNAME);
  SendRconCommand("language "SERVER_MACROS_LANGUAGE);

  ConnectMySQL_OnGameModeInit();

  createServerTextDraws();
}

/** ��������� ���� ��������� �������� ������� */
public OnGameModeExit() {
  ConnectMySQL_OnGameModeExit();

  destroyServerTextDraws();

  format(mysqlConnConf[hostname], 255, "lol kek azaza");
  format(mysqlConnConf[username], 255, "lol kek azaza");
  format(mysqlConnConf[password], 255, "lol kek azaza");
  format(mysqlConnConf[database], 255, "lol kek azaza");

	INI_saveWhole_NoSections("mysql_config.txt", mysqlConnConf, sizeof(mysqlConnConf), mysqlConnectConfigIniStruct, sizeof(mysqlConnectConfigIniStruct), "mysql_ini"); // ������� ������ ������, ����� ����� �����

  printf(SERVER_MACROS_GAMEMODE_NAME": � ��������� �������� ���� ������.");
}
