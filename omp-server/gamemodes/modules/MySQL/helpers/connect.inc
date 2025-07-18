/** ����������� � ���� MySQL */
stock connectToMySQL() {
	// TODO: ElmirKuba 2025-06-28: ����������� ����������� �������������� ������ ����������� �� ������� ��� ���������� ������ �� ���� � � ������� �� ��� ����� ����� ������� ������ ����� web-sockets
	// INI_saveWhole_NoSections("mysql_config.txt", mysqlConnConf, sizeof(mysqlConnConf), mysqlConnectConfigIniStruct, sizeof(mysqlConnectConfigIniStruct), "mysql_ini"); // ������� ������ ������, ����� ����� �����

	/*
	! ������ ���� ������������ ��� ��������� �������� ���������� ������ ������� ��������� ����� ������������ � ���� MySQL.
	? �����? �������� �������� ������� ������� ��� ��������� � Docker.
	������� ����������� � ���������� ������� ���� "mysql_config.txt" �� ������� �������� �������, � �� ��� � ���� ������� ��������� �� ������, ��� ��� �� ����� �������� � ����������� ����� Linux.
	������ � �������, ������� ����������� ���� "mysql_config.txt" �������� �� ".env" ����� � ����� �������.
	*/
	INI_readWhole_NoSections("mysql_config.txt", mysqlConnConf, sizeof(mysqlConnConf), mysqlConnectConfigIniStruct, sizeof(mysqlConnectConfigIniStruct), "mysql_ini", false);

	new MySQLOpt: optionId = mysql_init_options();

	mysql_set_option(optionId, AUTO_RECONNECT, true);

	mySQLConnectHandle = mysql_connect(mysqlConnConf[hostname], mysqlConnConf[username], mysqlConnConf[password], mysqlConnConf[database], optionId);
  mysql_set_charset("cp1251");
  mysql_query(mySQLConnectHandle, !"SET CHARACTER SET 'utf8'", false);
  mysql_query(mySQLConnectHandle, !"SET NAMES 'utf8'", false); 
  mysql_query(mySQLConnectHandle, !"SET character_set_client = 'cp1251'", false); 
  mysql_query(mySQLConnectHandle, !"SET character_set_connection = 'cp1251'", false); 
  mysql_query(mySQLConnectHandle, !"SET character_set_results = 'cp1251'", false); 
  mysql_query(mySQLConnectHandle, !"SET SESSION collation_connection = 'utf8_general_ci'", false); 
	
	printf(" ");
	printf("-----------------------------------------------------------------------------------------------------------------------------------------------------------");
	printf(" Server Name: "SERVER_MACROS_HOSTNAME);
	printf(" Mode Name: "SERVER_MACROS_GAMEMODE_NAME);
	printf(" ");
	printf(" �������� CI/CD #1");
	printf(" ");
	printf(" MySQL:");
	switch(mysql_errno())
	{
		case 0: print(!" [Info] [DataBase] Connect to DB - Success!");
		case 1044:    print(!" [Error] [DataBase] #1044 - Error connecting to the database! [The user has been denied access to the database]");
		case 1045: print(!" [Error] [DataBase] #1045 - Error connecting to the database! [[User denied access (Incorrect password)]");
		case 1049: print(!" [Error] [DataBase] #1049 - Error connecting to the database! [Unknown DATABASE]");
		case 2003: print(!" [Error] [DataBase] #2003 - Error connecting to the database! [Unable to connect to MySQL server]");
		case 2005: print(!" [Error] [DataBase] #2005 - Error connecting to the database! [Unknown server]");
		default: printf(" [Error] [DataBase] #%d - Error connecting to the database! [Unknown error]", mysql_errno());
	}
	printf("-----------------------------------------------------------------------------------------------------------------------------------------------------------");
	printf(" ");

	return 1;
}