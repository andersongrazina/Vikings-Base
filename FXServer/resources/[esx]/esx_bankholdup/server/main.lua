local rob = false
local robbers = {}
ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_bankholdup:tooFar')
AddEventHandler('esx_bankholdup:tooFar', function(currentBank)
	local _source = source
	local xPlayers = ESX.GetPlayers()
	rob = false

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'police' then
			TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at', Banks[currentBank].nameOfBank))
			TriggerClientEvent('esx_bankholdup:killBlip', xPlayers[i])
		end
	end

	if robbers[_source] then
		TriggerClientEvent('esx_bankholdup:tooFar', _source)
		robbers[_source] = nil
		TriggerClientEvent('esx:showNotification', _source, _U('robbery_cancelled_at', Banks[currentBank].nameOfBank))
	end
end)

RegisterServerEvent('esx_bankholdup:robberyStarted')
AddEventHandler('esx_bankholdup:robberyStarted', function(currentBank)
	local _source  = source
	local xPlayer  = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	if Banks[currentBank] then
		local bank = Banks[currentBank]

		if (os.time() - bank.lastRobbed) < Config.TimerBeforeNewRob and bank.lastRobbed ~= 0 then
			TriggerClientEvent('esx:showNotification', _source, _U('recently_robbed', Config.TimerBeforeNewRob - (os.time() - bank.lastRobbed)))
			return
		end

		local cops = 0
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			if xPlayer.job.name == 'police' then
				cops = cops + 1
			end
		end

		if not rob then
				rob = true

				for i=1, #xPlayers, 1 do
					local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
					if xPlayer.job.name == 'police' then
						TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog', bank.nameOfBank))
						TriggerClientEvent('esx_bankholdup:setBlip', xPlayers[i], Banks[currentBank].position)
					end
				end

				TriggerClientEvent('esx:showNotification', _source, _U('started_to_rob', bank.nameOfBank))
				TriggerClientEvent('esx:showNotification', _source, _U('alarm_triggered'))
				
				TriggerClientEvent('esx_bankholdup:currentlyRobbing', _source, currentBank)
				TriggerClientEvent('esx_bankholdup:startTimer', _source)
				TriggerClientEvent('esx_holdup:startRob', source)
				
				Banks[currentBank].lastRobbed = os.time()
				robbers[_source] = currentBank

				SetTimeout(bank.secondsRemaining * 1000, function()
					if robbers[_source] then
						rob = false
						if xPlayer then
							TriggerClientEvent('esx_bankholdup:robberyComplete', _source, bank.reward)

							if Config.GiveBlackMoney then
								xPlayer.addAccountMoney('black_money', bank.reward)
							else
								xPlayer.addMoney(bank.reward)
							end
							
							local xPlayers, xPlayer = ESX.GetPlayers(), nil
							for i=1, #xPlayers, 1 do
								xPlayer = ESX.GetPlayerFromId(xPlayers[i])

								if xPlayer.job.name == 'police' then
									TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_complete_at', bank.nameOfBank))
									TriggerClientEvent('esx_bankholdup:killBlip', xPlayers[i])
								end
							end
						end
					end
				end)
		else
			TriggerClientEvent('esx:showNotification', _source, _U('robbery_already'))
		end
	end
end)
