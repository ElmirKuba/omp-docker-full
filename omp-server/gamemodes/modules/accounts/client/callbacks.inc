/* Результаты поиска аккаунта при входе в игру */
forward findPlayerAccount(playerid);
public findPlayerAccount(playerid) {
  new rows;
  cache_get_row_count(rows);

  if(!rows) {
    new fmtString[] = "Привет %s, твой аккаунт не зарегистрирован на сервере!";
    new string[sizeof (fmtString) + MAX_PLAYER_NAME + 1];
    format(string, sizeof (string), fmtString, pData[playerid][nickName]);
    SendClientMessage(playerid, -1, string);

  } else {
    new fmtString[] = "Привет %s, твой аккаунт зарегистрирован на сервере!";
    new string[sizeof (fmtString) + MAX_PLAYER_NAME + 1];
    format(string, sizeof (string), fmtString, pData[playerid][nickName]);
    SendClientMessage(playerid, -1, string);

  }
}