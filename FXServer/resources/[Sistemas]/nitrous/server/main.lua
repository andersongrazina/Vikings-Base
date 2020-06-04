ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterUsableItem('nitro', function(source)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local nitroquantity = xPlayer.getInventoryItem('nitro').count
    if nitroquantity > 0 then
        TriggerClientEvent('nitrous:activar', source)
    else
        TriggerClientEvent('esx:showNotification', source, "Algo deu errado.")
    end
end)

RegisterServerEvent('nitrous:removeInventoryItem')
AddEventHandler('nitrous:removeInventoryItem', function(item, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, quantity)
end)