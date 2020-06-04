ESX                             = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        HideHudComponentThisFrame(1)
        HideHudComponentThisFrame(2)
        HideHudComponentThisFrame(3)
        HideHudComponentThisFrame(4)
        HideHudComponentThisFrame(6)
        HideHudComponentThisFrame(7)
        HideHudComponentThisFrame(8)
        HideHudComponentThisFrame(9)
        HideHudComponentThisFrame(13)
        HideHudComponentThisFrame(17)
        HideHudComponentThisFrame(20)
    end
end)

local table = { -- these peds wont show up anywhere, they will be removed and their vehicles deleted
  "s_m_y_prisoner_01",
  "u_m_y_prisoner_01",
  "s_m_y_prismuscl_01",
  "s_m_m_prisguard_01"
}

Citizen.CreateThread(function()
    while true do
        SetVehicleDensityMultiplierThisFrame(0.4) -- NPCS em veículos
        SetPedDensityMultiplierThisFrame(0.4) -- Pedestres 
        SetRandomVehicleDensityMultiplierThisFrame(0.4) -- Veículos aleatórios 
        SetParkedVehicleDensityMultiplierThisFrame(0.0) -- Veículos estacionados 
        SetScenarioPedDensityMultiplierThisFrame(0.4, 0.4) -- Peds em cenários (sentados, etc)
        
        local playerPed = GetPlayerPed(-1)
        local pos = GetEntityCoords(playerPed) 
		ClearPlayerWantedLevel(playerPed)
        RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
        
        SetGarbageTrucks(0)
        SetRandomBoats(0)
        
        for i = 1, 13 do
            EnableDispatchService(i, false)
        end
        
        Citizen.Wait(1)
			for ped in EnumeratePeds() do
            if DoesEntityExist(ped) then
			for i,model in pairs(table) do
					if (GetEntityModel(ped) == GetHashKey(model)) then
						RemovePedDefensiveArea(ped, false);
						veh = GetVehiclePedIsIn(ped, false)
						SetBlockingOfNonTemporaryEvents(ped, true)
					end
				end
			end
		end
    end
end)