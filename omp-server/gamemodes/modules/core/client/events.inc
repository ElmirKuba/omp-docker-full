/* ������������� ������ � ���� */
public OnPlayerConnect(playerid) {
  ACC_OnPlayerConnect(playerid);
	return 1;
}

/* ����������� ������� ������ ����� */
public OnPlayerRequestClass(playerid, classid) {
  ACC_OnPlayerRequestClass(playerid);
	return 1;
}

/* ����� ����� ����������� */
public OnPlayerSpawn(playerid) {
  ACC_OnPlayerSpawn(playerid);
	return 1;
}