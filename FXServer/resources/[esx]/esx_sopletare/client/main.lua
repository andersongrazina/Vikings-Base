ESX        = nil
cachedBins = {}
closestBin = {
    'prop_dumpster_01a',
    'prop_dumpster_02a',
    'prop_dumpster_02b',
    'prop_dumpster_4a',
    'prop_dumpster_4b'
}

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

Citizen.CreateThread(function()
    while true do
        
        local sleep = 1000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestBin do
            local x = GetClosestObjectOfType(playerCoords, 1.0, GetHashKey(closestBin[i]), false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                entity = x
                bin    = GetEntityCoords(entity)
                sleep  = 5
                ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para procurar algo na ~b~lixeira~s~')  
                if IsControlJustReleased(0, 38) then
                    if not cachedBins[entity] then
                        OpenBin(entity)
                    else
                        ESX.ShowNotification('~r~Você ou alguém já está procurando aqui!~s~')
                    end
                end
                break
            else
                sleep = 1000
            end
        end
        Citizen.Wait(sleep)
    end
end)