ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'motoclube', 'Motoclube', 'society_motoclube', 'society_motoclube', 'society_motoclube', {type = 'private'})

RegisterServerEvent('esx_motoclubejob:giveWeapon')
AddEventHandler('esx_motoclubejob:giveWeapon', function(weapon, ammo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'motoclube' then
		xPlayer.addWeapon(weapon, ammo)
	else
		print(('esx_motoclubejob: %s attempted to give weapon!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_motoclubejob:putInVehicle')
AddEventHandler('esx_motoclubejob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'motoclube' then
		TriggerClientEvent('esx_motoclubejob:putInVehicle', target)
	else
		print(('esx_motoclubejob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_motoclubejob:OutVehicle')
AddEventHandler('esx_motoclubejob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'motoclube' then
		TriggerClientEvent('esx_motoclubejob:OutVehicle', target)
	else
		print(('esx_motoclubejob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('esx_motoclubejob:getStockItem')
AddEventHandler('esx_motoclubejob:getStockItem', function(type, itemName, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if type == 'item_standard' then
	
			local sourceItem = xPlayer.getInventoryItem(itemName)

			TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motoclube', function(inventory)

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

		TriggerEvent('esx_addonaccount:getAccount', 'society_motoclube_black_money', xPlayer.identifier, function(account)
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

RegisterServerEvent('esx_motoclubejob:washMoney')
AddEventHandler('esx_motoclubejob:washMoney', function(amount)
	local xPlayer 		= ESX.GetPlayerFromId(source)
	local account 		= xPlayer.getAccount('black_money')

	if amount > 0 and account.money >= amount then
		
		local washedMoney = amount 	

		xPlayer.removeAccountMoney('black_money', amount)
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Você deve esperar ~y~'..(amount/1000)..' segundos~s~ até o dinheiro estar completamente lavado')
		Citizen.Wait(amount)
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'O dinheiro foi ~b~lavado~s~ com sucesso!')
		xPlayer.addMoney(washedMoney)
	else
		TriggerClientEvent('esx:showNotification', xPlayer.source, '~r~Quantia Inválida')
	end

end)

ESX.RegisterServerCallback('esx_motoclubejob:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local blackMoney = xPlayer.getAccount('black_money').money

	cb( { items = items, blackMoney = blackMoney } )
end)

RegisterServerEvent('esx_motoclubejob:putStockItems')
AddEventHandler('esx_motoclubejob:putStockItems', function(type, itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local sourceItem = xPlayer.getInventoryItem(itemName)
	
	if type == 'item_standard' then

		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motoclube', function(inventory)

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

			TriggerEvent('esx_addonaccount:getAccount', 'society_motoclube_black_money', xPlayer.identifier, function(account)
				account.addMoney(count)
			end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('amount_invalid'))
		end
	end

end)

ESX.RegisterServerCallback('esx_motoclubejob:getArmoryWeapons', function(source, cb)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_motoclube', function(store)
		local weapons = store.get('weapons')

		if weapons == nil then
			weapons = {}
		end

		cb(weapons)
	end)

end)

ESX.RegisterServerCallback('esx_motoclubejob:addArmoryWeapon', function(source, cb, weaponName, removeWeapon)

	local xPlayer = ESX.GetPlayerFromId(source)

	if removeWeapon then
		xPlayer.removeWeapon(weaponName)
	end

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_motoclube', function(store)

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

ESX.RegisterServerCallback('esx_motoclubejob:removeArmoryWeapon', function(source, cb, weaponName)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addWeapon(weaponName, 500)

	TriggerEvent('esx_datastore:getSharedDataStore', 'society_motoclube', function(store)

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


ESX.RegisterServerCallback('esx_motoclubejob:buy', function(source, cb, amount)

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_motoclube', function(account)
		if account.money >= amount then
			account.removeMoney(amount)
			cb(true)
		else
			cb(false)
		end
	end)

end)

ESX.RegisterServerCallback('esx_motoclubejob:getStockItems', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local blackMoney = 0
	local items      = {}
	
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_motoclube', function(inventory)
		items = inventory.items
	end)
	
	TriggerEvent('esx_addonaccount:getAccount', 'society_motoclube_black_money', xPlayer.identifier, function(account)
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
		if xPlayer ~= nil and xPlayer.job ~= nil and xPlayer.job.name == 'motoclube' then
			Citizen.Wait(5000)
			TriggerClientEvent('esx_motoclubejob:updateBlip', -1)
		end
	end	
end)

RegisterServerEvent('esx_motoclubejob:forceBlip')
AddEventHandler('esx_motoclubejob:forceBlip', function()
	TriggerClientEvent('esx_motoclubejob:updateBlip', -1)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(5000)
		TriggerClientEvent('esx_motoclubejob:updateBlip', -1)
	end
end)