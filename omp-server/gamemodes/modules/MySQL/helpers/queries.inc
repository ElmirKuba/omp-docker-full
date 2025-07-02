
stock sqlFindAccountFromAccounts(playerid, const eventExecuteCallback[] = "") {
  new fmtSqlQuery[] = "SELECT * FROM `accounts` WHERE `nickname` = '%s'";
  new stringSqlQuery[sizeof (fmtSqlQuery) + MAX_PLAYER_NAME + 1];
  format(stringSqlQuery, sizeof (stringSqlQuery), fmtSqlQuery, pData[playerid][nickName]);
  mysql_tquery(mySQLConnectHandle, stringSqlQuery, eventExecuteCallback, "i", playerid);
}