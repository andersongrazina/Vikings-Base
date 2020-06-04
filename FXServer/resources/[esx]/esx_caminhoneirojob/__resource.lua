resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX Mecano Job'

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

version '1.1.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/br.lua',
	'config.lua',
	'server/main.lua'
}
