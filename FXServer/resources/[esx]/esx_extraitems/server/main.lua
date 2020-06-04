ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('oxygen_mask', function(source)
	TriggerClientEvent('esx_extraitems:oxygen_mask', source)
	local xPlayer  = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('oxygen_mask', 1)
end)

ESX.RegisterUsableItem('rose', function(source)
	TriggerClientEvent('esx_extraitems:rose', source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('rose', 1)
end)

ESX.RegisterUsableItem('redgull', function(source)
	TriggerClientEvent('esx_extraitems:redgull', source)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('redgull', 1)
	TriggerClientEvent('esx_status:add', source, 'thirst', 50000)
end)