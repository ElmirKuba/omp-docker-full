/** Присоединение игрока к игре */
forward ACC_OnPlayerConnect(playerid);
public ACC_OnPlayerConnect(playerid) {
  pData[playerid] = pPlayerNULL;
  
  pData[playerid][playerStatus] = PLAYER_STATUS[JOINING_TO_GAME];
}

/** Стандартное событие выбора скина */
forward ACC_OnPlayerRequestClass(playerid);
public ACC_OnPlayerRequestClass(playerid) {
  if (pData[playerid][playerStatus] == PLAYER_STATUS[JOINING_TO_GAME]) {
    TextDrawShowForPlayer(playerid, sTDblackBackground)

    GetPlayerName(playerid, pData[playerid][nickName], MAX_PLAYER_NAME + 1);

    SetSpawnInfo(playerid, NO_TEAM, 177, 1958.33, 1343.12, 15.36, 269.15, WEAPON_FIST, 0, WEAPON_FIST, 0, WEAPON_FIST, 0);

    SpawnPlayer(playerid);
  }
}

/* Когда игрок заспавнился */
forward ACC_OnPlayerSpawn(playerid);
public ACC_OnPlayerSpawn(playerid) {
  if (pData[playerid][playerStatus] == PLAYER_STATUS[JOINING_TO_GAME]) {
    SetPlayerVirtualWorld(playerid, PL_INDIVIDUAL_VW(playerid));

    sqlFindAccountFromAccounts(playerid, "findPlayerAccount");
  }
	return 1;
}

