ESX = nil

TriggerEvent("esx:getSharedObject", function(response)
    ESX = response
end)

RegisterServerEvent('esx-sopletare:getItem')
AddEventHandler('esx-sopletare:getItem', function()

    local luck = math.random(1, 3)

    if luck == 1 then

        local items = { -- add whatever items you want here
            'bandage',
            'weed_pooch',
            'bread',
            'burger'
        }

        local xPlayer = ESX.GetPlayerFromId(source)
        local randomItems = items[math.random(#items)]
        local quantity = math.random(#items)
        local itemfound = ESX.GetItemLabel(randomItems)

        xPlayer.addInventoryItem(randomItems, quantity)
        TriggerClientEvent('esx:showNotification', source, 'Você encontrou ' .. quantity .. ' ' .. itemfound)
    else
        TriggerClientEvent('esx:showNotification', source, 'Você não encontrou nada, talvez tenha mais sorte da próxima vez!')
    end
end)
