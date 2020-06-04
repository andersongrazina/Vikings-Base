ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'aztecas', 'Aztecas', 'society_aztecas', 'society_aztecas', 'society_aztecas', {type = 'private'})

RegisterServerEvent('esx_aztecasjob:giveWeapon')
AddEventHandler('esx_aztecasjob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'aztecas' then
		xPlayer.addWeapon(weapon, ammo)
	else
		print(('esx_aztecasjob: %s attempted to give weapon!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_aztecasjob:putInVehicle')
AddEventHandler('esx_aztecasjob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'aztecas' then
		TriggerClientEvent('esx_aztecasjob:putInVehicle', target)
	else
		print(('esx_aztecasjob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_aztecasjob:OutVehicle')
AddEventHandler('esx_aztecasjob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'aztecas' then
		TriggerClientEvent('esx_aztecasjob:OutVehicle', target)
	else
		print(('esx_aztecasjob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_aztecasjob:getStockItem')
AddEventHandler('esx_aztecasjob:getStockItem', function(type, itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if type == 'item_standard' then
	
			local sourceItem = xPlayer.getInventoryItem(itemName)

			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_aztecas', function(inventory)

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

		TriggerEvent('esx_addonaccount:getAccount', 'society_aztecas_black_money', xPlayer.identifier, function(account)
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

ESX.RegisterServerCallback('esx_aztecasjob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local blackMoney = xPlayer.getAccount('black_money').money

	cb( { items = items, blackMoney = blackMoney } )
end)

RegisterServerEvent('esx_aztecasjob:putStockItems')
AddEventHandler('esx_aztecasjob:putStockItems', function(type, itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	
	if type == 'item_standard' then

		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_aztecas', function(inventory)

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

			TriggerEvent('esx_addonaccount:getAccount', 'society_aztecas_black_money', xPlayer.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
		end
	end

end)

ESX.RegisterServerCallback('esx_aztecasjob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_aztecas', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)

end)

ESX.RegisterServerCallback('esx_aztecasjob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_aztecas', function(store)

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

ESX.RegisterServerCallback('esx_aztecasjob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_aztecas', function(store)

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


ESX.RegisterServerCallback('esx_aztecasjob:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_aztecas', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)

ESX.RegisterServerCallback('esx_aztecasjob:getStockItems', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local blackMoney = 0
	local items      = {}
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_aztecas', function(inventory)
		items = inventory.items
	end)
	
	TriggerEvent('esx_addonaccount:getAccount', 'society_aztecas_black_money', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)
	
	cb({
		blackMoney = blackMoney,
		items      = items
	})
end)

AddEventHandler('playerDropped', function()
	-- Save the source in case we lose it (which happens a lot)
	local _source = source
	
	-- Did the player ever join?
	if _source ~= nil then
		local xPlayer = ESX.GetPlayerFromId(_source)
		
		-- Is it worth telling all clients to refresh?
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'aztecas' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_aztecasjob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_aztecasjob:forceBlip')
AddEventHandler('esx_aztecasjob:forceBlip', function()
	TriggerClientEvent('esx_aztecasjob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_aztecasjob:updateBlip', -1)
	end
end)