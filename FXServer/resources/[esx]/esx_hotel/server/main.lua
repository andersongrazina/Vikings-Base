ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('esx_hotel:verificarDinheiro', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)
	
	if xPlayer.getMoney() >= 225 then
		xPlayer.removeMoney(225)
		cb(true)
	else
		cb(false)
	end
end)
