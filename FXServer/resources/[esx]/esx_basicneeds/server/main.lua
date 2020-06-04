ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('bread', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('bread', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 100000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_bread'))
end)

ESX.RegisterUsableItem('burger', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('burger', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 180000)
	TriggerClientEvent('esx_basicneeds:onEatBurger', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_burger'))
end)

ESX.RegisterUsableItem('water', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('water', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 100000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_water'))
end)

ESX.RegisterUsableItem('cola', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cola', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_basicneeds:onDrinkCola', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cola'))
end)

ESX.RegisterUsableItem('leitep', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('leitep', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 150000)
	TriggerClientEvent('esx_basicneeds:onDrinkLeiteP', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_leitep'))
end)

ESX.RegisterUsableItem('leiteg', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('leiteg', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 200000)
	TriggerClientEvent('esx_basicneeds:onDrinkLeiteG', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_leiteg'))
end)

ESX.RegisterUsableItem('rhum', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhum', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrinkGin', source)
	TriggerClientEvent('esx:showNotification', source, 'Você tomou 1x Rum!')
end)

ESX.RegisterUsableItem('rhumcoca', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('rhumcoca', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrinkGin', source)
	TriggerClientEvent('esx:showNotification', source, 'Você tomou 1x Rum-Coca!')
end)

ESX.RegisterUsableItem('tequila', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('tequila', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrinkTequila', source)
	TriggerClientEvent('esx:showNotification', source, 'Você tomou 1x Whisky!')
end)

ESX.RegisterUsableItem('vodka', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodka', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrinkVodka', source)
	TriggerClientEvent('esx:showNotification', source, 'Você tomou 1x Vodka!')
end)

ESX.RegisterUsableItem('vodkaenergy', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodkaenergy', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrinkVodka', source)
	TriggerClientEvent('esx:showNotification', source, 'Você tomou 1x Vodka-enérgica!')
end)

ESX.RegisterUsableItem('vodkafruit', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('vodkafruit', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 300000)
	TriggerClientEvent('esx_basicneeds:onDrinkVodka', source)
	TriggerClientEvent('esx:showNotification', source, 'Você tomou 1x Vodka-jus de frutas!')
end)

ESX.RegisterUsableItem('cerveja', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('cerveja', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 180000)
	TriggerClientEvent('esx_status:add', source, 'drunk', 180000)
	TriggerClientEvent('esx_basicneeds:onDrinkBeer', source)
	TriggerClientEvent('esx:showNotification', source, _U('used_cerveja'))
end)

TriggerEvent('es:addGroupCommand', 'heal', 'admin', function(source, args, user)
	-- heal another player - don't heal source
	if args[1] then
		local target = tonumber(args[1])
		
		-- is the argument a number?
		if target ~= nil then
			
			-- is the number a valid player?
			if GetPlayerName(target) then
				print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing a player!')
				TriggerClientEvent('esx_basicneeds:healPlayer', target)
				TriggerClientEvent('chatMessage', target, "HEAL", {223, 66, 244}, "You have been healed!")
			else
				TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Player not found!")
			end
		else
			TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Incorrect syntax! You must provide a valid player ID")
		end
	else
		-- heal source
		print('esx_basicneeds: ' .. GetPlayerName(source) .. ' is healing!')
		TriggerClientEvent('esx_basicneeds:healPlayer', source)
	end
end, function(source, args, user)
	TriggerClientEvent('chatMessage', source, "HEAL", {255, 0, 0}, "Insufficient Permissions.")
end, {help = "Heal a player, or yourself - restores thirst, hunger and health."})