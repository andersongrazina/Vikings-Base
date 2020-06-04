local PlayersWashing = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function WhiteningMoney(source)
	local source = source
		SetTimeout(1000, function()

		if PlayersWashing[source] == true then
			local xPlayer		= ESX.GetPlayerFromId(source)
			local blackMoney	= xPlayer.getAccount('black_money')
			
			if blackMoney.money < 1000 then
				TriggerClientEvent('esx:showNotification', source, 'Você não tem dinheiro sufiente. Lavagem mínima: R$ 1000!')
			else
				xPlayer.removeAccountMoney('black_money', 1000)
				xPlayer.addMoney(550)
				WhiteningMoney(source)
				
				TriggerClientEvent('esx:showNotification', source, 'Você Lavou: R$ 1000\nRecebido: R$ 550!')
			end
		end
	end)
end

RegisterServerEvent('esx_blanchisseur:startWhitening')
AddEventHandler('esx_blanchisseur:startWhitening', function()
	PlayersWashing[source] = true
	TriggerClientEvent('esx:showNotification', source, 'Lavando dinheiro...')
	WhiteningMoney(source)
end)

RegisterServerEvent('esx_blanchisseur:stopWhitening')
AddEventHandler('esx_blanchisseur:stopWhitening', function()
	PlayersWashing[source] = false
end)
