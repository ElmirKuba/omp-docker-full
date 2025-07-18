/** �������� ������� ������������ ���������� � ���� ������ */
enum mysqlConnectConfig {
  hostname[255], // ����� ����������� � ���� MySQL
  username[32],  // ��� ������������ ����������� � ���� MySQL
  database[64],  // �������� ���� ������ ��� ����������� � ���� MySQL
  password[32],  // ������ ������������ ����������� � ���� MySQL
};
/** ������������ ���������� � ���� ������ */
new mysqlConnConf[mysqlConnectConfig];
/** �� ��� �� ��������� ������, � 2015 �� ����� �� pawn */
new const mysqlConnectConfigIniStruct[][e_ini_struct_info] = {
  {'s', mysqlConnectConfig:hostname, 255, 0, 8, "hostname"},
  {'s', mysqlConnectConfig:username, 32,  0, 8, "username"},
  {'s', mysqlConnectConfig:database, 64,  0, 8, "database"},
  {'s', mysqlConnectConfig:password, 32,  0, 8, "password"}
};

new MySQL: mySQLConnectHandle; // ������������� ��������� ����������� � ���� MySQL