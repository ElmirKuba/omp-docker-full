/* ���������� ������ �������� ��� ����� � ���� */
forward findPlayerAccount(playerid);
public findPlayerAccount(playerid) {
  new rows;
  cache_get_row_count(rows);

  if(!rows) {
    new fmtString[] = "������ %s, ���� ������� �� ��������������� �� �������!";
    new string[sizeof (fmtString) + MAX_PLAYER_NAME + 1];
    format(string, sizeof (string), fmtString, pData[playerid][nickName]);
    SendClientMessage(playerid, -1, string);

  } else {
    new fmtString[] = "������ %s, ���� ������� ��������������� �� �������!";
    new string[sizeof (fmtString) + MAX_PLAYER_NAME + 1];
    format(string, sizeof (string), fmtString, pData[playerid][nickName]);
    SendClientMessage(playerid, -1, string);

  }
}