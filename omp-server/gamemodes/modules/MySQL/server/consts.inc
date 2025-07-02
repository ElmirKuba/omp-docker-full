/** Описание состава конфигурации подклюения к базе данных */
enum mysqlConnectConfig {
  hostname[255], // Адрес подключения к СуБД MySQL
  username[32],  // Имя пользователя подключения к СуБД MySQL
  database[64],  // Название базы данных для подключения к СуБД MySQL
  password[32],  // Пароль пользователя подключения к СуБД MySQL
};
/** Конфигурация подклюения к базе данных */
new mysqlConnConf[mysqlConnectConfig];
/** ХЗ что за структура данных, с 2015 не писал на pawn */
new const mysqlConnectConfigIniStruct[][e_ini_struct_info] = {
  {'s', mysqlConnectConfig:hostname, 255, 0, 8, "hostname"},
  {'s', mysqlConnectConfig:username, 32,  0, 8, "username"},
  {'s', mysqlConnectConfig:database, 64,  0, 8, "database"},
  {'s', mysqlConnectConfig:password, 32,  0, 8, "password"}
};

new MySQL: mySQLConnectHandle; // Идентификатор активного подключения к СуБД MySQL