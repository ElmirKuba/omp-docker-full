#include "../helpers/connect.inc"

/** ��������� ���� ������� �������� ������� */
forward ConnectMySQL_OnGameModeInit();
public ConnectMySQL_OnGameModeInit() {
  connectToMySQL();
}

/** ��������� ���� ��������� �������� ������� */
forward ConnectMySQL_OnGameModeExit();
public ConnectMySQL_OnGameModeExit() {
  mysql_close(mySQLConnectHandle);
	return 1;
}