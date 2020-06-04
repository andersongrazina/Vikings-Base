ESX                = nil
local PlayersSell = {}
local PlayersProcess = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_leiteirojob:reward')
AddEventHandler('esx_leiteirojob:reward', function(Weight)
    local xPlayer = ESX.GetPlayerFromId(source)
	
	xPlayer.removeInventoryItem('bucket', 1)
    xPlayer.addInventoryItem('milkbucket', 1)
        
end)

ESX.RegisterServerCallback('esx_leiteirojob:getItemAmount', function(source, cb, item)
    local xPlayer = ESX.GetPlayerFromId(source)
    local qtti = xPlayer.getInventoryItem(item).count
    cb(qtti)
end)

local function Sell(source)
	SetTimeout(1500, function()
		if PlayersSell[source] == true then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local quantity = xPlayer.getInventoryItem('milkpet').count

			if quantity < 1 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Você não tem mais garrafa de leite!')
				PlayersSell[_source] = false
			else
				local amount = 1
				local item = 'milkpet'

				xPlayer.removeInventoryItem(item, amount)
				xPlayer.addMoney(13)
				TriggerClientEvent('esx:showNotification', _source, 'Você recebeu ~g~R$ 13~s~!')
				Sell(_source)
			end
		end
	end)
end

RegisterServerEvent('esx_leiteirojob:startSell')
AddEventHandler('esx_leiteirojob:startSell', function()
	local _source = source

	if PlayersSell[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Saia e volte para a área!')
		PlayersSell[_source] = false
	else
		PlayersSell[_source] = true
		TriggerClientEvent('esx:showNotification', _source, '~g~Ação~w~ em andamento...')
		Sell(_source)
	end
end)

local function Process(source)
	SetTimeout(3500, function()
		if PlayersProcess[source] == true then
			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)

			local quantity = xPlayer.getInventoryItem('milkbucket').count

			if quantity < 1 then
				TriggerClientEvent('esx:showNotification', _source, '~r~Você não tem mais balde de leite!')
				PlayersProcess[_source] = false
			else
				local amount = 1
				local item = 'milkbucket'

				xPlayer.removeInventoryItem(item, amount)
				xPlayer.addInventoryItem('milkpet', 10)
				Process(_source)
			end
		end
	end)
end

RegisterServerEvent('esx_leiteirojob:stopProcess')
AddEventHandler('esx_leiteirojob:stopProcess', function()
	local _source = source

	if PlayersProcess[_source] == true then
		PlayersProcess[_source] = false
	else
		PlayersProcess[_source] = true
	end
end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end

RegisterServerEvent('esx_leiteirojob:startProcess')
AddEventHandler('esx_leiteirojob:startProcess', function()
	local _source = source

	if PlayersProcess[_source] == false then
		TriggerClientEvent('esx:showNotification', _source, '~r~Saia e volte para a área!')
		PlayersProcess[_source] = false
	else
		PlayersProcess[_source] = true
		TriggerClientEvent('esx:showNotification', _source, '~g~Processamento~w~ em andamento...')
		Process(_source)
	end
end)

RegisterServerEvent('esx_leiteirojob:sell')
AddEventHandler('esx_leiteirojob:sell', function()
    local xPlayer = ESX.GetPlayerFromId(source)

    local LeitePrice = 125
   
    local LeiteQuantidade = xPlayer.getInventoryItem('milkbucket').count

    if LeiteQuantidade > 0 then
        xPlayer.addMoney(LeiteQuantidade * LeitePrice)

        xPlayer.removeInventoryItem('milkbucket', LeiteQuantidade)
		TriggerClientEvent('esx:showNotification', source, 'Você vendeu ~y~x'..LeiteQuantidade..' ~s~Baldes de Leite!')
		TriggerClientEvent('esx:showNotification', source, 'Você faturou ~y~R$'..(LeiteQuantidade * LeitePrice)..'~s~!')
    else
        TriggerClientEvent('esx:showNotification', source, 'Você não tem balde de leite para vender!')
    end
        
end)

RegisterServerEvent('esx_leiteirojob:stopSell')
AddEventHandler('esx_leiteirojob:stopSell', function()
	local _source = source

	if PlayersSell[_source] == true then
		PlayersSell[_source] = false
	else
		PlayersSell[_source] = true
	end
end)

function sendNotification(xsource, message, messageType, messageTimeout)
    TriggerClientEvent('notification', xsource, message)
end