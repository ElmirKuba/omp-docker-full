/* Импорты модулей серверного назначения */
#include "core/server/events.inc" // Серверные события
#include "MySQL/server/events.inc" // События модуля подключения к MySQL

#include "core/server/helpers/textdraws.inc" // Серверные хелперы и утилиты
#include "MySQL/helpers/queries.inc" // Хелперы модуля работы с MySQL







/* Импорты модулей клиентского назначения */
#include "core/client/events.inc" // Клиентские события
#include "accounts/client/events.inc" // События системы аккаунтов
#include "accounts/client/callbacks.inc" // Колбэки модуля аккаунтов
