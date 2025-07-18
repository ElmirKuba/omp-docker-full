/** �������� �������� ������ */
enum PLAYER_STATUSES {
  INVALID = 0, // ���������� ������
  JOINING_TO_GAME = 1 // �������������� � ����
}

/* ������� ������ */
new PLAYER_STATUS[PLAYER_STATUSES];

/* �������� ����� ������ ������ */
enum playerData {
	playerStatus, // ������ ������ � ��������� ������ �������
	id[PL_UUID_V4_WITH_UNIXTIME_LENGTH + 1], // ������������� �������� ������ uuid_v4 + unixtime
	nickName[MAX_PLAYER_NAME + 1], // ��� ������ (����� �������� ������)
	password[PL_PASSWORD_MAX_LENGTH + 1], // �������������� ������ �������� ������
}

new pData[MAX_PLAYERS][playerData]; // ������ ������ �� ������
new pPlayerNULL[playerData]; // ������ ��� ��������� ������ ������


