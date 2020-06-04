--[[

  ESX RP Chat

--]]

resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

description 'ESX RP Chat'

version '1.0.0'

client_script{ 
	'@es_extended/locale.lua',
	'locales/br.lua',
	'client/main.lua'
}
server_scripts {
  '@mysql-async/lib/MySQL.lua',
  '@es_extended/locale.lua',
  'locales/br.lua',
  'server/main.lua'

}
