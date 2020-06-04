ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'groove', 'Groove', 'society_groove', 'society_groove', 'society_groove', {type = 'private'})

RegisterServerEvent('esx_groovejob:giveWeapon')
AddEventHandler('esx_groovejob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'groove' then
		xPlayer.addWeapon(weapon, ammo)
	else
		print(('esx_groovejob: %s attempted to give weapon!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_groovejob:putInVehicle')
AddEventHandler('esx_groovejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'groove' then
		TriggerClientEvent('esx_groovejob:putInVehicle', target)
	else
		print(('esx_groovejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_groovejob:OutVehicle')
AddEventHandler('esx_groovejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'groove' then
		TriggerClientEvent('esx_groovejob:OutVehicle', target)
	else
		print(('esx_groovejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_groovejob:getStockItem')
AddEventHandler('esx_groovejob:getStockItem', function(type, itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if type == 'item_standard' then
	
			local sourceItem = xPlayer.getInventoryItem(itemName)

			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_groove', function(inventory)

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

		TriggerEvent('esx_addonaccount:getAccount', 'society_groove_black_money', xPlayer.identifier, function(account)
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

ESX.RegisterServerCallback('esx_groovejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local blackMoney = xPlayer.getAccount('black_money').money

	cb( { items = items, blackMoney = blackMoney } )
end)

RegisterServerEvent('esx_groovejob:putStockItems')
AddEventHandler('esx_groovejob:putStockItems', function(type, itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	
	if type == 'item_standard' then

		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_groove', function(inventory)

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

			TriggerEvent('esx_addonaccount:getAccount', 'society_groove_black_money', xPlayer.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
		end
	end

end)

ESX.RegisterServerCallback('esx_groovejob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_groove', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)

end)

ESX.RegisterServerCallback('esx_groovejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_groove', function(store)

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

ESX.RegisterServerCallback('esx_groovejob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_groove', function(store)

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


ESX.RegisterServerCallback('esx_groovejob:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_groove', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)

ESX.RegisterServerCallback('esx_groovejob:getStockItems', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local blackMoney = 0
	local items      = {}
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_groove', function(inventory)
		items = inventory.items
	end)
	
	TriggerEvent('esx_addonaccount:getAccount', 'society_groove_black_money', xPlayer.identifier, function(account)
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
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'groove' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_groovejob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_groovejob:forceBlip')
AddEventHandler('esx_groovejob:forceBlip', function()
	TriggerClientEvent('esx_groovejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_groovejob:updateBlip', -1)
	end
end)