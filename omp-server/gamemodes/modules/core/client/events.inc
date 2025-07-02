/* Присоединение игрока к игре */
public OnPlayerConnect(playerid) {
  ACC_OnPlayerConnect(playerid);
	return 1;
}

/* Стандартное событие выбора скина */
public OnPlayerRequestClass(playerid, classid) {
  ACC_OnPlayerRequestClass(playerid);
	return 1;
}

/* Когда игрок заспавнился */
public OnPlayerSpawn(playerid) {
  ACC_OnPlayerSpawn(playerid);
	return 1;
}