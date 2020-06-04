ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_recuperacao:loadLicenses', source, licenses)
	end)
end)

function LoadLicenses (source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_recuperacao:loadLicenses', source, licenses)
	end)
end

RegisterServerEvent('esx_recuperacao:ServerLoadLicenses')
AddEventHandler('esx_recuperacao:ServerLoadLicenses', function()
	local _source = source
	LoadLicenses(_source)
end)

ESX.RegisterServerCallback('esx_recuperacao:pagarTratamento', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)
	
	if xPlayer.getMoney() >= 500 then
		xPlayer.removeMoney(500)
		cb(true)
	else
		cb(false)
	end
end)