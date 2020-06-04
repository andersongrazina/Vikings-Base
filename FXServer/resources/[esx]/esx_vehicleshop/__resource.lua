resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Vehicle Shop'

version '1.1.0'

ui_page "NUI/NUI.html"

files {
	"NUI/NUI.html",
	"NUI/NUI.css",
	"NUI/jquery.js",
   	"NUI/NUI.js",
   	"NUI/gothicb.ttf",
   	"NUI/signpainter.ttf",
   	"NUI/Bootstrap/js/bootstrap.min.js",
   	"NUI/Bootstrap/css/bootstrap.min.css"
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fi.lua',
	'locales/fr.lua',
	'locales/sv.lua',
	'locales/pl.lua',
	'config.lua',
	'client/utils.lua',
	'client/main.lua'
}

dependency 'es_extended'

export 'GeneratePlate'