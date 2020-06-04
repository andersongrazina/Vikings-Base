ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_lapdance:Buy')
AddEventHandler('esx_lapdance:Buy', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 50) then
	xPlayer.removeMoney(50)
	TriggerClientEvent('esx_lapdance:lapdance', _source)
	sendNotification(_source, 'Você pagou R$ 50 Por uma dança privativa!', 'success', 2500)
	else
	sendNotification(_source, 'Você não tem dinheiro suficiente para pagar uma dança privativa', 'error', 2500)
	end

end)

--notification
function sendNotification(xSource, message, messageType, messageTimeout)
    TriggerClientEvent("pNotify:SendNotification", xSource, {
        text = message,
        type = messageType,
        queue = "lmao",
        timeout = messageTimeout,
        layout = "bottomCenter"
    })
end