ESX                = nil
local valor = false

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('esx_caminhoneirojob:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtt = xPlayer.getInventoryItem(item).count
    cb(qtt)
end)

RegisterServerEvent('esx_caminhoneirojob:stopCraft3')
AddEventHandler('esx_caminhoneirojob:stopCraft3', function()
	local _source = source
	PlayersCrafting3[_source] = false
end)

RegisterServerEvent('esx_caminhoneirojob:onNPCJobMissionCompleted')
AddEventHandler('esx_caminhoneirojob:onNPCJobMissionCompleted', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total   = math.random(Config.NPCJobEarnings.min, Config.NPCJobEarnings.max);

	if xPlayer.job.grade >= 3 then
		total = total * 2
	end

	TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mecano', function(account)
		account.addMoney(total)
	end)

	TriggerClientEvent("esx:showNotification", _source, _U('your_comp_earned').. total)
end)

RegisterServerEvent('esx_caminhoneirojob:success')
AddEventHandler('esx_caminhoneirojob:success', function(recompensa, VidaCarga)
	local xPlayer = ESX.GetPlayerFromId(source)
	if valor == false then
		xPlayer.addMoney(recompensa)
		valor = true
		
		if VidaCarga < 1000 and recompensa == false then
			
			price = (1000 - VidaCarga)
			
			xPlayer.removeMoney(price)
			
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Você multado em ~y~R$'..price..' ~s~por danos a carga!')
			recompensa = true
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Você recebeu ~y~R$'..recompensa..' ~s~pela entrega da carga!')
		Citizen.Wait(2500)
		valor = false
	end
end)

RegisterServerEvent('esx_caminhoneirojob:successFragil')
AddEventHandler('esx_caminhoneirojob:successFragil', function(recompensa, VidaCarga)
	local xPlayer = ESX.GetPlayerFromId(source)
	if valor == false then
		xPlayer.addMoney(recompensa)
		valor = true
		if VidaCarga < 1000 then
		
			price = (2000 - (VidaCarga*2))
			
			xPlayer.removeMoney(price)
			
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Você multado em ~y~R$'..price..' ~s~por danos a carga!')
			
		end

		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Você recebeu ~y~R$'..recompensa..' ~s~pela entrega da carga!')
		Citizen.Wait(2500)
		valor = false
	end
end)