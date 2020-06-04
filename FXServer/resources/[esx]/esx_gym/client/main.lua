local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData              = {}
local training = false
local resting = false
local membership = false
rentalTimer = 5 
autoChargeAmount = 100
isBeingCharged = false
damageCharge = false
canBeCharged = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  PlayerData.job = job
end)

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local blips = {
	{title="Academia", colour=7, id=311, x = -1201.2257, y = -1568.8670, z = 4.6101}
}
	
Citizen.CreateThread(function()

	for _, info in pairs(blips) do
		info.blip = AddBlipForCoord(info.x, info.y, info.z)
		SetBlipSprite(info.blip, info.id)
		SetBlipDisplay(info.blip, 4)
		SetBlipScale(info.blip, 1.0)
		SetBlipColour(info.blip, info.colour)
		SetBlipAsShortRange(info.blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(info.title)
		EndTextCommandSetBlipName(info.blip)
	end
end)

RegisterNetEvent('esx_gym:useBandage')
AddEventHandler('esx_gym:useBandage', function()
	local playerPed = GetPlayerPed(-1)
	local maxHealth = GetEntityMaxHealth(playerPed)
	local health = GetEntityHealth(playerPed)
	local newHealth = math.min(maxHealth , math.floor(health + maxHealth/3))

	SetEntityHealth(playerPed, newHealth)
	--SetEntityHealth(playerPed, maxHealth) -- Give them full health by one bandage
	
	ESX.ShowNotification("Você usou uma ~g~Bandagem")
end)

RegisterNetEvent('esx_gym:trueMembership')
AddEventHandler('esx_gym:trueMembership', function()
	membership = true
end)

RegisterNetEvent('esx_gym:falseMembership')
AddEventHandler('esx_gym:falseMembership', function()
	membership = false
end)

-- LOCATION (START)

local arms = {
    {x = -1202.9837,y = -1565.1718,z = 4.6115},
	{x = 1642.86,y = 2523.83,z = 45.57},
	{x = 1646.62,y = 2535.89,z = 45.57}
}

local pushup = {
    {x = -1203.3242,y = -1570.6184,z = 4.6115},
	{x = 1642.37,y = 2531.34,z = 45.57}
}

local yoga = {
    {x = -1204.7958,y = -1560.1906,z = 4.6115},
	{x = 1637.45,y = 2525.31,z = 45.57}
}

local situps = {
    {x = -1206.1055,y = -1565.1589,z = 4.6115},
	{x = 1641.5,y = 2519.96,z = 45.57}
}

local gym = {
    {x = -1195.6551,y = -1577.7689,z = 4.6115}
}

local gymprison = {
    {x = 1643.81,y = 2540.37,z = 45.57}
}

local chins = {
    {x = -1200.1284,y = -1570.9903,z = 4.6115},
	{x = 1642.98,y = 2528.07,z = 45.57},
	{x = 1648.89,y = 2529.76,z = 45.57}
}

local rentbike = {
    {x = -1038.03, y = -2731.68, z = 20.17}
}

local rentcar = {
    {x = -1016.79, y = -2696.2, z = 13.98}
}

local renttruck = {
    {x = 887.37, y = -953.235, z = 39.22}
}

RegisterCommand("entregarbike", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			local model = GetEntityModel(vehicle)
			local displaytext = GetDisplayNameFromVehicleModel(model)
			if displaytext == "BMX" or displaytext == "FIXTER" or displaytext == "CRUISER" or displaytext == "SCORCHER" then
					ESX.Game.DeleteVehicle(vehicle)
			else
			ESX.ShowNotification('~r~Você não está utilizando uma bicicleta!')
			end
	else
	ESX.ShowNotification('~r~Você não está em cima de uma bicicleta!')
	end
end)

RegisterCommand("entregarcarro", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			local model = GetEntityModel(vehicle)
			local displaytext = GetDisplayNameFromVehicleModel(model)
			local plate = GetVehicleNumberPlateText(vehicle)
			if displaytext == "BLISTA" or displaytext == "ISSI2" or displaytext == "DILETTANTE" or displaytext == "ASEA" then
				if plate == " ALUGUE " then
					ESX.Game.DeleteVehicle(vehicle)
					damageCharge = false
					isBeingCharged = false
				else
					ESX.ShowNotification('~r~Este carro não é alugado!')
				end
			else
				ESX.ShowNotification('~r~Este carro não é alugado!')
			end
	else
	ESX.ShowNotification('~r~Você não está utilizando um carro alugado!')
	end
end)

RegisterCommand("entregarcaminhao", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			local model = GetEntityModel(vehicle)
			local displaytext = GetDisplayNameFromVehicleModel(model)
			local plate = GetVehicleNumberPlateText(vehicle)
			if displaytext == "HAULER" or displaytext == "PACKER" or displaytext == "PHANTOM" or displaytext == "PHANTHOM3" then
				if plate == " ALUGUE " then
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification('~r~Este caminhão não é alugado!')
				end
			else
				ESX.ShowNotification('~r~Este caminhão não é alugado!')
			end
	else
		ESX.ShowNotification('~r~Você não está utilizando um caminhão alugado!')
	end
end)

-- LOCATION (END)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(rentbike) do
            DrawMarker(27, rentbike[k].x, rentbike[k].y, rentbike[k].z-0.99, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 0, 153, 255, 255, 0, 0, 0, 0)
			DrawMarker(38, rentbike[k].x, rentbike[k].y, rentbike[k].z, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 1.5, 0, 153, 255, 255, 0, 0, 0, 1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(rentbike) do
            DrawMarker(25, rentcar[k].x, rentcar[k].y, rentcar[k].z-0.99, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 0, 153, 255, 255, 0, 0, 0, 0)
			DrawMarker(36, rentcar[k].x, rentcar[k].y, rentcar[k].z, 0, 0, 0, 0, 0, 0, 1.35, 1.35, 1.35, 0, 153, 255, 255, 0, 0, 0, 1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(arms) do
            DrawMarker(21, arms[k].x, arms[k].y, arms[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(pushup) do
            DrawMarker(21, pushup[k].x, pushup[k].y, pushup[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(yoga) do
            DrawMarker(21, yoga[k].x, yoga[k].y, yoga[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(situps) do
            DrawMarker(21, situps[k].x, situps[k].y, situps[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(gym) do
            DrawMarker(21, gym[k].x, gym[k].y, gym[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(gymprison) do
            DrawMarker(21, gymprison[k].x, gymprison[k].y, gymprison[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 153, 255, 255, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(renttruck) do
            DrawMarker(27, renttruck[k].x, renttruck[k].y, renttruck[k].z-0.99, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 0, 153, 255, 255, 0, 0, 0, 0)
			DrawMarker(39, renttruck[k].x, renttruck[k].y, renttruck[k].z-0.10, 0, 0, 0, 0, 0, 0, 1.25, 1.25, 1.09, 0, 153, 255, 255, 0, 0, 0, 1)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(chins) do
            DrawMarker(21, chins[k].x, chins[k].y, chins[k].z, 0, 0, 0, 0, 0, 0, 0.301, 0.301, 0.3001, 0, 255, 50, 200, 0, 0, 0, 0)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(rentbike) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, rentbike[k].x, rentbike[k].y, rentbike[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para alugar uma ~b~bicicleta')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if IsPedInAnyVehicle(GetPlayerPed(-1)) then
						ESX.ShowNotification("Você já tem um ~r~veículo")
					else
						OpenBikeMenu()
					end
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(rentcar) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, rentcar[k].x, rentcar[k].y, rentcar[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para alugar um ~b~CARRO')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if IsPedInAnyVehicle(GetPlayerPed(-1)) then
						ESX.ShowNotification("Você já tem um ~r~veículo")
					else
						OpenCarMenu()
					end
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(gym) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gym[k].x, gym[k].y, gym[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para abrir o menu da ~b~academia')
				
				if IsControlJustPressed(0, Keys['E']) then
					OpenGymMenu()
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(gymprison) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, gymprison[k].x, gymprison[k].y, gymprison[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para abrir o menu da ~b~academia')
				
				if IsControlJustPressed(0, Keys['E']) then
					OpenGymPrisonMenu()
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(renttruck) do
		
            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, renttruck[k].x, renttruck[k].y, renttruck[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para alugar um ~b~Caminhão')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					if IsPedInAnyVehicle(GetPlayerPed(-1)) then
						ESX.ShowNotification("Você já tem um ~r~veículo")
					else
						OpenTruckMenu()
					end
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(arms) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, arms[k].x, arms[k].y, arms[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para treinar seus ~g~braços')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando para o exercício...")
						Citizen.Wait(1000)					
					
						if membership == true then
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_muscle_free_weights", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							
							ESX.ShowNotification("Você deve descansar ~r~60 segundos~w~ antes de continuar")
							
							--TriggerServerEvent('esx_gym:trainArms') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification("Você precisa ser membro da academia para poder treinar")
						end
					elseif training == true then
						ESX.ShowNotification("Você precisa descansar...")
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(chins) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, chins[k].x, chins[k].y, chins[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para fazer ~g~pull-up')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando para ~g~exercício~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "prop_human_muscle_chin_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							
							ESX.ShowNotification("Você precisa descansar ~r~60 segundos ~w~antes de fazer outro exercício.")
							
							--TriggerServerEvent('esx_gym:trainChins') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification("Você precisa matricular-se para fazer um ~r~exercício~w~ Matricule-se a sua Direita >")
						end
					elseif training == true then
						ESX.ShowNotification("Você precisa descansar...")
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(pushup) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pushup[k].x, pushup[k].y, pushup[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para fazer ~g~flexões')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando o ~g~exercício~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then				
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_push_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							
							ESX.ShowNotification("Você precisa descansar ~r~60 segundos ~w~antes de fazer outro exercício.")
						
							--TriggerServerEvent('esx_gym:trainPushups') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification("Você precisa matricular-se para fazer um ~r~exercício~w~ Matricule-se a sua Direita >")
						end							
					elseif training == true then
						ESX.ShowNotification("Você precisa descansar...")
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(yoga) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, yoga[k].x, yoga[k].y, yoga[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para fazer ~g~yoga')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then
					
						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando o ~g~exercício~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then	
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_yoga", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							
							ESX.ShowNotification("Você precisa descansar ~r~60 segundos ~w~antes de fazer outro exercício.")
						
							--TriggerServerEvent('esx_gym:trainYoga') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification("Você precisa matricular-se para fazer um ~r~exercício~w~ Matricule-se a sua Direita >")
						end
					elseif training == true then
						ESX.ShowNotification("Você precisa descansar...")
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        for k in pairs(situps) do

            local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, situps[k].x, situps[k].y, situps[k].z)

            if dist <= 0.5 then
				hintToDisplay('Pressione ~INPUT_CONTEXT~ para fazer alguns ~g~abdominais')
				
				if IsControlJustPressed(0, Keys['E']) then
					if training == false then

						TriggerServerEvent('esx_gym:checkChip')
						ESX.ShowNotification("Preparando o ~g~exercício~w~...")
						Citizen.Wait(1000)					
					
						if membership == true then	
							local playerPed = GetPlayerPed(-1)
							TaskStartScenarioInPlace(playerPed, "world_human_sit_ups", 0, true)
							Citizen.Wait(30000)
							ClearPedTasksImmediately(playerPed)
							
							ESX.ShowNotification("Você precisa descansar ~r~60 segundos ~w~antes de fazer outro exercício.")
						
							--TriggerServerEvent('esx_gym:trainSitups') ## COMING SOON...
							
							training = true
						elseif membership == false then
							ESX.ShowNotification("Você precisa matricular-se para fazer um ~r~exercício~w~ Matricule-se a sua Direita >")
						end
					elseif training == true then
						ESX.ShowNotification("Você precisa descansar...")
						
						resting = true
						
						CheckTraining()
					end
				end			
            end
        end
    end
end)

function CheckTraining()
	if resting == true then
		ESX.ShowNotification("Você está descansando...")
		
		resting = false
		Citizen.Wait(60000)
		training = false
	end
	
	if resting == false then
		ESX.ShowNotification("Agora você pode se exercitar novamente...")
	end
end

function OpenGymMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_menu',
        {
            title    = 'Academia',
            elements = {
				{label = 'Loja', value = 'shop'},
				{label = 'Horário de Funcionamento', value = 'hours'},
				{label = 'Tornar-se Membro', value = 'ship'},
            }
        },
        function(data, menu)
            if data.current.value == 'shop' then
				OpenGymShopMenu()
            elseif data.current.value == 'hours' then
				ESX.UI.Menu.CloseAll()
				
				ESX.ShowNotification("Estamos Aberto ~g~24~w~ Horas P/Dia. Bem Vindo!")
            elseif data.current.value == 'ship' then
				OpenGymShipMenu()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymPrisonMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_menu',
        {
            title    = 'Academia',
            elements = {
				{label = 'Tornar-se Membro', value = 'ship'},
            }
        },
        function(data, menu)
            if data.current.value == 'ship' then
				OpenGymShipMenu()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymShopMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_shop_menu',
        {
            title    = 'Loja - Academia',
            elements = {
				{label = 'Shake Proteico (R$ 6)', value = 'protein_shake'},
				{label = 'Água (R$ 1)', value = 'water'},
				{label = 'Almoço Esportivo (R$ 22)', value = 'sportlunch'},
				{label = 'Powerade (R$ 18)', value = 'powerade'},
				--{label = 'Bandage (R$ 1900)', value = 'bandage'},
            }
        },
        function(data, menu)
            if data.current.value == 'protein_shake' then
				TriggerServerEvent('esx_gym:buyProteinshake')
            elseif data.current.value == 'water' then
				TriggerServerEvent('esx_gym:buyWater')
            elseif data.current.value == 'sportlunch' then
				TriggerServerEvent('esx_gym:buySportlunch')
            elseif data.current.value == 'powerade' then
				TriggerServerEvent('esx_gym:buyPowerade')
            elseif data.current.value == 'bandage' then
				TriggerServerEvent('esx_gym:buyBandage')
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenGymShipMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'gym_ship_menu',
        {
            title    = 'Academia - Membro Gratis',
            elements = {
				{label = 'Inscrever-se na academia', value = 'membership'},
            }
        },
        function(data, menu)
            if data.current.value == 'membership' then
				TriggerServerEvent('esx_gym:buyMembership')
				
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenBikeMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'bike_menu',
        {
            title    = 'Alugar uma bicicleta',
            elements = {
				{label = 'BMX (R$ 250)', value = 'bmx'},
				{label = 'Cruiser (R$ 300)', value = 'cruiser'},
				{label = 'Fixter (R$ 329)', value = 'fixter'},
				{label = 'Scorcher (R$ 400)', value = 'scorcher'},
            }
        },
        function(data, menu)
            if data.current.value == 'bmx' then
				TriggerServerEvent('esx_gym:hireBmx')
				TriggerEvent('esx:spawnVehicle', "bmx")
				Citizen.Wait(2750)
				ESX.ShowHelpNotification('Você alugou uma ~y~BMX~s~, para devolvê-la, digite ~y~/entregarbike~s~!')
				
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'cruiser' then
				TriggerServerEvent('esx_gym:hireCruiser')
				TriggerEvent('esx:spawnVehicle', "cruiser")
				Citizen.Wait(2750)
				ESX.ShowHelpNotification('Você alugou uma ~y~CRUISER~s~, para devolvê-la, digite ~y~/entregarbike~s~!')
				
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'fixter' then
				TriggerServerEvent('esx_gym:hireFixter')
				TriggerEvent('esx:spawnVehicle', "fixter")
				Citizen.Wait(2750)
				ESX.ShowHelpNotification('Você alugou uma ~y~FIXTER~s~, para devolvê-la, digite ~y~/entregarbike~s~!')
				
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'scorcher' then
				TriggerServerEvent('esx_gym:hireScorcher')
				TriggerEvent('esx:spawnVehicle', "scorcher")
				Citizen.Wait(2750)
				ESX.ShowHelpNotification('Você alugou uma ~y~SCORCHER~s~, para devolvê-la, digite ~y~/entregarbike~s~!')
				
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenCarMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'car_menu',
        {
            title    = 'Alugar um carro',
            elements = {
				{label = 'Blista (R$ 250)', value = 'blista'},
				{label = 'Issi (R$ 300)', value = 'issi2'},
				{label = 'Dilettante (R$ 350)', value = 'dilettante'},
				{label = 'Asea (R$ 400)', value = 'asea'},
            }
        },
        function(data, menu)
            if data.current.value == 'blista' then
				ESX.TriggerServerCallback('esx_gym:rentBlista', function(hasEnoughMoney)
					if hasEnoughMoney then
					SpawnVehicle('Blista')
					isBeingCharged = true
					Citizen.Wait(2750)
					ESX.ShowHelpNotification('Você alugou um ~y~BLISTA~s~, para devolvê-lo, digite ~y~/entregarcarro~s~!')
					else
						ESX.ShowNotification("Você não tem ~r~dinheiro suficiente")
					end
				end)
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'issi2' then
			ESX.TriggerServerCallback('esx_gym:rentIssi', function(hasEnoughMoney)
					if hasEnoughMoney then
					SpawnVehicle('issi2')
					isBeingCharged = true
					Citizen.Wait(2750)
					ESX.ShowHelpNotification('Você alugou um ~y~ISSI~s~, para devolvê-lo, digite ~y~/entregarcarro~s~!')
					else
						ESX.ShowNotification("Você não tem ~r~dinheiro suficiente")
					end
				end)
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'dilettante' then
				ESX.TriggerServerCallback('esx_gym:rentDilettante', function(hasEnoughMoney)
					if hasEnoughMoney then
				SpawnVehicle('dilettante')
				isBeingCharged = true
				Citizen.Wait(2750)
				ESX.ShowHelpNotification('Você alugou um ~y~DILETTANTE~s~, para devolvê-lo, digite ~y~/entregararro~s~!')
				else
					ESX.ShowNotification("Você não tem ~r~dinheiro suficiente")
				end
				end)
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'asea' then
				ESX.TriggerServerCallback('esx_gym:rentAsea', function(hasEnoughMoney)
					if hasEnoughMoney then
					SpawnVehicle('asea')
					isBeingCharged = true
					Citizen.Wait(2750)
				ESX.ShowHelpNotification('Você alugou um ~y~ASEA~s~, para devolvê-lo, digite ~y~/entregarcarro~s~!')
				else
					ESX.ShowNotification("Você não tem ~r~dinheiro suficiente")
				end
				end)
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function OpenTruckMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'truck_menu',
        {
            title    = 'Alugar um Caminhão',
            elements = {
				{label = 'Scania R730 (R$ 2500)', value = 'scania'},
				{label = 'Packer (R$ 3000)', value = 'packer'},
				{label = 'Phantom (R$ 3500)', value = 'phantom2'},
				{label = 'Phantom Boss (R$ 4000)', value = 'phantom'},
            }
        },
        function(data, menu)
            if data.current.value == 'scania' then
				ESX.TriggerServerCallback('esx_gym:rentScania', function(hasEnoughMoney)
					if hasEnoughMoney then
					SpawnTruck('Hauler')
					Citizen.Wait(2750)
						ESX.ShowHelpNotification('Você alugou um ~y~Hauler~s~, para devolvê-lo, digite ~y~/entregarcaminhao~s~!')
					else
						ESX.ShowNotification("Você não tem ~r~dinheiro suficiente")
					end
				end)
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'packer' then
			ESX.TriggerServerCallback('esx_gym:rentPacker', function(hasEnoughMoney)
					if hasEnoughMoney then
					SpawnTruck('packer')
					Citizen.Wait(2750)
					ESX.ShowHelpNotification('Você alugou um ~y~Packer~s~, para devolvê-lo, digite ~y~/entregarcaminhao~s~!')
					else
						ESX.ShowNotification("Você não tem ~r~dinheiro suficiente")
					end
				end)
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'phantom2' then
				ESX.TriggerServerCallback('esx_gym:rentPhantom2', function(hasEnoughMoney)
					if hasEnoughMoney then
				SpawnTruck('Phantom')
				Citizen.Wait(2750)
				ESX.ShowHelpNotification('Você alugou um ~y~Packer~s~, para devolvê-lo, digite ~y~/entregarcaminhao~s~!')
				else
					ESX.ShowNotification("Você não tem ~r~dinheiro suficiente")
				end
				end)
				ESX.UI.Menu.CloseAll()
            elseif data.current.value == 'phantom' then
				ESX.TriggerServerCallback('esx_gym:rentPhantom', function(hasEnoughMoney)
					if hasEnoughMoney then
					SpawnTruck('Phantom3')
					Citizen.Wait(2750)
				ESX.ShowHelpNotification('Você alugou um ~y~PHANTOM~s~, para devolvê-lo, digite ~y~/entregarcaminhao~s~!')
				else
					ESX.ShowNotification("Você não tem ~r~dinheiro suficiente")
				end
				end)
				ESX.UI.Menu.CloseAll()
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end

function SpawnVehicle(request)
			local hash = GetHashKey(request)

			RequestModel(hash)

			while not HasModelLoaded(hash) do
				RequestModel(hash)
				Citizen.Wait(0)
			end

			local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
			local vehicle = CreateVehicle(hash, -984.08, -2697.59, 13.83, 0.0, true, false)
			local BlipCar = AddBlipForEntity(vehicle)
				SetBlipSprite(BlipCar, 225)
				SetBlipScale(BlipCar, 0.8)
			SetVehicleDoorsLocked(vehicle, 1)
			CarPlate = (' ALUGUE ')
			SetVehicleNumberPlateText(vehicle, CarPlate)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
			canBeCharged = true
			
			SetVehicleFuelLevel(vehicle, 100.0)
			TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', CarPlate, 100.0)
			TriggerServerEvent('LegacyFuel:CheckServerFuelTable', CarPlate)
end

function SpawnTruck(request)
			local hash = GetHashKey(request)

			RequestModel(hash)

			while not HasModelLoaded(hash) do
				RequestModel(hash)
				Citizen.Wait(0)
			end

			local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
			local vehicle = CreateVehicle(hash, 882.33, -888.42, 26.2, 91.01, true, false)
			local BlipCar = AddBlipForEntity(vehicle)
				SetBlipSprite(BlipCar, 477)
				SetBlipScale(BlipCar, 0.8)
			SetVehicleDoorsLocked(vehicle, 1)
			TruckPlate = (' ALUGUE ')
			SetVehicleNumberPlateText(vehicle, TruckPlate)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
			
			SetVehicleFuelLevel(vehicle, 100.0)
			TriggerServerEvent('LegacyFuel:UpdateServerFuelTable', TruckPlate, 100.0)
			TriggerServerEvent('LegacyFuel:CheckServerFuelTable', TruckPlate)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			local playerPed = GetPlayerPed(-1)
			local amount                         = 500
			local model = GetEntityModel(vehicle)
			local displaytext = GetDisplayNameFromVehicleModel(model)
			local plate = GetVehicleNumberPlateText(vehicle)
			if displaytext == "BLISTA" or displaytext == "ISSI2" or displaytext == "DILETTANTE" or displaytext == "ASEA" then
				if plate == " ALUGUE " then
			if (IsVehicleDamaged(vehicle) and damageCharge == false and canBeCharged == true) then
				damageCharge = true
				TriggerServerEvent('esx_gym:Faturadedanos')
				ESX.ShowNotification("Você foi cobrado ~y~R$500~s~ por danificar o carro. A ~r~fatura pode ser paga em uma ~y~lotérica~s~.")
			else
			end
		end
	end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(rentalTimer*60*1000)
		if isBeingCharged == true then
			TriggerServerEvent("chargePlayer", autoChargeAmount)
			ESX.ShowNotification("Você foi cobrado R$" .. autoChargeAmount .. " em outro dia de seu aluguel. Devolva o veículo para parar as taxas.")
		end
	end
end)