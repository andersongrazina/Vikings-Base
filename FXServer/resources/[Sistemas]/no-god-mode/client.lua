local isInvincible = false
local isAdmin = false

Citizen.CreateThread(function()
    while true do
        isInvincible = GetPlayerInvincible(PlayerId())
        isInVeh = IsPedInAnyVehicle(PlayerPedId(), false)
        Citizen.Wait(500)
    end
end)

Citizen.CreateThread(function()
    while true do
        
        local ped = PlayerPedId()
        local player = PlayerId()
        if isInvincible and not isAdmin then
            DrawLabel("~r~Você ativou godmod isso é ~h~proibido~h~ neste servidor, você será banido.")
            FreezeEntityPosition(ped, true)
            DisablePlayerFiring(player, true) -- true/false - doesn't seem to do anything different, still disables every frame
				Citizen.Wait(1000) 
				TriggerServerEvent('godmod:kick')
            if isInVeh then
                FreezeEntityPosition(GetVehiclePedIsIn(ped, false), true)
			end
        else
            FreezeEntityPosition(ped, false)
            if isInVeh then
                FreezeEntityPosition(GetVehiclePedIsIn(ped, false), false)
            end 
        end
        
        Citizen.Wait(500)
    end
end)

function DrawLabel(text)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayHelp(0, 0, 1, -1)
end

RegisterNetEvent("sendAcePermissionToClient")
AddEventHandler("sendAcePermissionToClient", function(state)
    isAdmin = state
end)