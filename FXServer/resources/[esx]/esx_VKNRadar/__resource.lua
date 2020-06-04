resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Venus Radar'

version '1.0'

server_scripts {
	'config.lua',
	'@mysql-async/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'config.lua',
	'client/main.lua'
}