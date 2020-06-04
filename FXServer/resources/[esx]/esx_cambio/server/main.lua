local PlayersWashing = {}
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function WhiteningMoney(source)
	local source = source
		SetTimeout(1000, function()

		if PlayersWashing[source] == true then
			local xPlayer		= ESX.GetPlayerFromId(source)
			local dinheiroVip	= xPlayer.getAccount('dinheiro_vip')
			
			if dinheiroVip.money < 1000 then
				TriggerClientEvent('esx:showNotification', source, 'Você não tem dinheiro sufiente. Lavagem mínima: R$ 1000!')
			else
				xPlayer.removeAccountMoney('dinheiro_vip', 1000)
				xPlayer.addMoney(4000)
				WhiteningMoney(source)
				
				TriggerClientEvent('esx:showNotification', source, 'Você Trocou: R$ 1000\nRecebido: R$ 4000!')
			end
		end
	end)
end

RegisterServerEvent('esx_cambio:startWhitening')
AddEventHandler('esx_cambio:startWhitening', function()
	PlayersWashing[source] = true
	TriggerClientEvent('esx:showNotification', source, 'Fazendo câmbio...')
	WhiteningMoney(source)
end)

RegisterServerEvent('esx_cambio:stopWhitening')
AddEventHandler('esx_cambio:stopWhitening', function()
	PlayersWashing[source] = false
end)
