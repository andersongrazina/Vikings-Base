ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.MaxInService ~= -1 then
	TriggerEvent('esx_service:activateService', 'mafia', Config.MaxInService)
end

TriggerEvent('esx_society:registerSociety', 'mafia', 'Mafia', 'society_mafia', 'society_mafia', 'society_mafia', {type = 'public'})

RegisterServerEvent('esx_mafiajob:giveWeapon')
AddEventHandler('esx_mafiajob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'mafia' then
		xPlayer.addWeapon(weapon, ammo)
	else
		print(('esx_mafiajob: %s attempted to give weapon!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_mafiajob:confiscatePlayerItem')
AddEventHandler('esx_mafiajob:confiscatePlayerItem', function(target, itemType, itemName, amount)
	local _source = source
	local sourceXPlayer = ESX.GetPlayerFromId(_source)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name ~= 'mafia' then
		print(('esx_mafiajob: %s attempted to confiscate!'):format(xPlayer.identifier))
		return
	end

	if itemType == 'item_standard' then
		local targetItem = targetXPlayer.getInventoryItem(itemName)
		local sourceItem = sourceXPlayer.getInventoryItem(itemName)

		-- does the target player have enough in their inventory?
		if targetItem.count > 0 and targetItem.count <= amount then
		
			-- can the player carry the said amount of x item?
			if sourceItem.limit ~= -1 and (sourceItem.count + amount) > sourceItem.limit then
				TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
			else
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem   (itemName, amount)
				TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated', amount, sourceItem.label, targetXPlayer.name))
				TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated', amount, sourceItem.label, sourceXPlayer.name))
			end
		else
			TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
		end

	elseif itemType == 'item_account' then
		targetXPlayer.removeAccountMoney(itemName, amount)
		sourceXPlayer.addAccountMoney   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_account', amount, itemName, targetXPlayer.name))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_account', amount, itemName, sourceXPlayer.name))

	elseif itemType == 'item_weapon' then
		if amount == nil then amount = 0 end
		targetXPlayer.removeWeapon(itemName, amount)
		sourceXPlayer.addWeapon   (itemName, amount)

		TriggerClientEvent('esx:showNotification', _source, _U('you_confiscated_weapon', ESX.GetWeaponLabel(itemName), targetXPlayer.name, amount))
		TriggerClientEvent('esx:showNotification', target,  _U('got_confiscated_weapon', ESX.GetWeaponLabel(itemName), amount, sourceXPlayer.name))
	end
end)

RegisterServerEvent('esx_mafiajob:handcuff')
AddEventHandler('esx_mafiajob:handcuff', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'mafia' then
		TriggerClientEvent('esx_mafiajob:handcuff', target)
	else
		print(('esx_mafiajob: %s attempted to handcuff a player (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_mafiajob:drag')
AddEventHandler('esx_mafiajob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'mafia' then
		TriggerClientEvent('esx_mafiajob:drag', target, source)
	else
		print(('esx_mafiajob: %s attempted to drag (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_mafiajob:putInVehicle')
AddEventHandler('esx_mafiajob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'mafia' then
		TriggerClientEvent('esx_mafiajob:putInVehicle', target)
	else
		print(('esx_mafiajob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_mafiajob:OutVehicle')
AddEventHandler('esx_mafiajob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'mafia' then
		TriggerClientEvent('esx_mafiajob:OutVehicle', target)
	else
		print(('esx_mafiajob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_mafiajob:getStockItem')
AddEventHandler('esx_mafiajob:getStockItem', function(type, itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if type == 'item_standard' then
	
			local sourceItem = xPlayer.getInventoryItem(itemName)

			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)

				local inventoryItem = inventory.getItem(itemName)

				-- is there enough in the society?
				if count > 0 and inventoryItem.count >= count then
				
					-- can the player carry the said amount of x item?
					if sourceItem.limit ~= -1 and (sourceItem.count + count) > sourceItem.limit then
						TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
					else
						inventory.removeItem(itemName, count)
						xPlayer.addInventoryItem(itemName, count)
						TriggerClientEvent('esx:showNotification', _source, _U('have_withdrawn', count, inventoryItem.label))
					end
				else
					TriggerClientEvent('esx:showNotification', _source, _U('quantity_invalid'))
				end
			end)
	elseif type == 'item_account' then

		TriggerEvent('esx_addonaccount:getAccount', 'society_mafia_black_money', xPlayer.identifier, function(account)
			local chestAccountMoney = account.money

			if chestAccountMoney >= count then
				account.removeMoney(count)
				xPlayer.addAccountMoney(itemName, count)
			else
				TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
			end
		end)
	end
end)

RegisterServerEvent('esx_mafiajob:putStockItems')
AddEventHandler('esx_mafiajob:putStockItems', function(type, itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	
	if type == 'item_standard' then

		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)

			local inventoryItem = inventory.getItem(itemName)

			-- does the player have enough of the item?
			if sourceItem.count >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_deposited', count, inventoryItem.label))
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, _U('quantity_invalid'))
			end

		end)
	
	elseif type == 'item_account' then

		local playerAccountMoney = xPlayer.getAccount(itemName).money

		if playerAccountMoney >= count then
			xPlayer.removeAccountMoney(itemName, count)

			TriggerEvent('esx_addonaccount:getAccount', 'society_mafia_black_money', xPlayer.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
		end
	end

end)

ESX.RegisterServerCallback('esx_mafiajob:getOtherPlayerData', function(source, cb, target)

	if Config.EnableESXIdentity then

		local xPlayer = ESX.GetPlayerFromId(target)

		local result = MySQL.Sync.fetchAll('SELECT firstname, lastname, sex, dateofbirth, height FROM users WHERE identifier = @identifier', {
			['@identifier'] = xPlayer.identifier
		})

		local firstname = result[1].firstname
		local lastname  = result[1].lastname
		local sex       = result[1].sex
		local dob       = result[1].dateofbirth
		local height    = result[1].height

		local data = {
			name      = GetPlayerName(target),
			job       = xPlayer.job,
			inventory = xPlayer.inventory,
			accounts  = xPlayer.accounts,
			weapons   = xPlayer.loadout,
			firstname = firstname,
			lastname  = lastname,
			sex       = sex,
			dob       = dob,
			height    = height
		}

		TriggerEvent('esx_status:getStatus', target, 'drunk', function(status)
			if status ~= nil then
				data.drunk = math.floor(status.percent)
			end
		end)

		if Config.EnableLicenses then
			TriggerEvent('esx_license:getLicenses', target, function(licenses)
				data.licenses = licenses
				cb(data)
			end)
		else
			cb(data)
		end

	else

		local xPlayer = ESX.GetPlayerFromId(target)

		local data = {
			name       = GetPlayerName(target),
			job        = xPlayer.job,
			inventory  = xPlayer.inventory,
			accounts   = xPlayer.accounts,
			weapons    = xPlayer.loadout
		}

		TriggerEvent('esx_license:getLicenses', target, function(licenses)
			data.licenses = licenses
		end)

		cb(data)

	end

end)

ESX.RegisterServerCallback('esx_mafiajob:getFineList', function(source, cb, category)
	MySQL.Async.fetchAll('SELECT * FROM fine_types WHERE category = @category', {
		['@category'] = category
	}, function(fines)
		cb(fines)
	end)
end)

ESX.RegisterServerCallback('esx_mafiajob:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE @plate = plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname
				else
					retrivedInfo.owner = result2[1].name
				end

				cb(retrivedInfo)
			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

ESX.RegisterServerCallback('esx_mafiajob:getVehicleFromPlate', function(source, cb, plate)
	MySQL.Async.fetchAll('SELECT owner FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		if result[1] ~= nil then

			MySQL.Async.fetchAll('SELECT name, firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				if Config.EnableESXIdentity then
					cb(result2[1].firstname .. ' ' .. result2[1].lastname, true)
				else
					cb(result2[1].name, true)
				end

			end)
		else
			cb(_U('unknown'), false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_mafiajob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_mafia', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)

end)

ESX.RegisterServerCallback('esx_mafiajob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_mafia', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = weapons[i].count + 1
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 1
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)

ESX.RegisterServerCallback('esx_mafiajob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_mafia', function(store)

		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		local foundWeapon = false

		for i=1, #weapons, 1 do
			if weapons[i].name == weaponName then
				weapons[i].count = (weapons[i].count > 0 and weapons[i].count - 1 or 0)
				foundWeapon = true
				break
			end
		end

		if not foundWeapon then
			table.insert(weapons, {
				name  = weaponName,
				count = 0
			})
		end

		store.set('weapons', weapons)
		cb()
	end)

end)


ESX.RegisterServerCallback('esx_mafiajob:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mafia', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)
end)

ESX.RegisterServerCallback('esx_mafiajob:getStockItems', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local blackMoney = 0
	local items      = {}
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mafia', function(inventory)
		items = inventory.items
	end)
	
	TriggerEvent('esx_addonaccount:getAccount', 'society_mafia_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)
	
	cb({
		blackMoney = blackMoney,
		items      = items
	})
end)

ESX.RegisterServerCallback('esx_mafiajob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local blackMoney = xPlayer.getAccount('black_money').money

	cb( { items = items, blackMoney = blackMoney } )
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'mafia' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_mafiajob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_mafiajob:spawned')
AddEventHandler('esx_mafiajob:spawned', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'mafia' then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_mafiajob:updateBlip', -1)
	end
end)

RegisterServerEvent('esx_mafiajob:forceBlip')
AddEventHandler('esx_mafiajob:forceBlip', function()
	TriggerClientEvent('esx_mafiajob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_mafiajob:updateBlip', -1)
	end
end)


RegisterServerEvent('esx_mafiajob:message')
AddEventHandler('esx_mafiajob:message', function(target, msg)
	TriggerClientEvent('esx:showNotification', target, msg)
end)