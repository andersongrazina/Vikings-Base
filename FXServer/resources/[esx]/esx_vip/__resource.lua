

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description "ESX Vip"

server_scripts {
	'@es_extended/locale.lua',
	"@mysql-async/lib/MySQL.lua",
	'config.lua',
	'locales/br.lua',
	"server/server.lua"
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'locales/br.lua',
	"client/client.lua"
}