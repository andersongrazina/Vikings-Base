ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fs_taxi:check')
AddEventHandler('fs_taxi:check', function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

    local taxi = 0
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if xPlayer.job.name == 'taxi' then
                    taxi = taxi + 1
            end
        end
        if taxi == 0 then
		TriggerClientEvent('fs_taxi:corrida', src)
		else
			TriggerClientEvent('esx:showAdvancedNotification', src, 'Táxi', 'Chamada de Táxi', 'Já tem outros táxis trabalhando na cidade!', 'CHAR_TAXI', 1)
    end
end)

RegisterServerEvent('fs_taxi:payCab')
AddEventHandler('fs_taxi:payCab', function(meters)
	local src = source
	local totalPrice = meters / 40.0
	local price = math.floor(totalPrice)
		
		TriggerEvent('es:getPlayerFromId', src, function(user)
			if user.getMoney() >= tonumber(price) then
				user.removeMoney(tonumber(price))
				TriggerClientEvent('fs_taxi:payment-status', src, true)
				TriggerClientEvent('esx:showNotification', src, 'Você pagou ~y~'..price..'R$ ~s~para o ~y~Taxí~s~!')
			else
				TriggerClientEvent('fs_taxi:payment-status', src, false)
			end
		end)
	
end)