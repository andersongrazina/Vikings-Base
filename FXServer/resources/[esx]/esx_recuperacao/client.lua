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
local Licenses                = {}


local InAction = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
		
		while ESX.GetPlayerData().job == nil do
			Citizen.Wait(10)
		end

		ESX.PlayerData = ESX.GetPlayerData()
		
		TriggerServerEvent('esx_recuperacao:ServerLoadLicenses')
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterCommand('vida5', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
ToggleVehicleMod(veh, 22, true) -- toggle xenon
for i = 1, 12, 1 do 
	SetVehicleHeadlightsColour(veh, i)
	Citizen.Wait(500)
end

for i = 1, 12, 1 do 
	SetVehicleHeadlightsColour(veh, i)
	Citizen.Wait(500)
end

for i = 1, 12, 1 do 
	SetVehicleHeadlightsColour(veh, i)
	Citizen.Wait(500)
end

for i = 1, 12, 1 do 
	SetVehicleHeadlightsColour(veh, i)
	Citizen.Wait(500)
end
end)

RegisterCommand('farol', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	ToggleVehicleMod(veh, 22, false) -- toggle xenon
end)

RegisterCommand('xenonvermelho', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	ToggleVehicleMod(veh, 22, true)
	SetVehicleHeadlightsColour(veh, 8)
	 -- toggle xenon
end)

RegisterCommand('xenonverde', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	ToggleVehicleMod(veh, 22, true)
	SetVehicleHeadlightsColour(veh, 3)
	 -- toggle xenon
end)

RegisterCommand('xenonazul', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	ToggleVehicleMod(veh, 22, true)
	SetVehicleHeadlightsColour(veh, 2)
	 -- toggle xenon
end)

RegisterCommand('xenonamarelo', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	ToggleVehicleMod(veh, 22, true)
	SetVehicleHeadlightsColour(veh, 5)
	 -- toggle xenon
end)

RegisterCommand('xenonlaranja', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	ToggleVehicleMod(veh, 22, true)
	SetVehicleHeadlightsColour(veh, 7)
	 -- toggle xenon
end)

RegisterCommand('xenonrosa', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	ToggleVehicleMod(veh, 22, true)
	SetVehicleHeadlightsColour(veh, 10)
	 -- toggle xenon
end)

RegisterCommand('xenonroxo', function()
	local veh = GetVehiclePedIsUsing(PlayerPedId())
	ToggleVehicleMod(veh, 22, true)
	SetVehicleHeadlightsColour(veh, 11)
	 -- toggle xenon
end)

Citizen.CreateThread(function()
    while true do

        Citizen.Wait(5)
		
		local ownedLicenses = {}
		
		local vidaPlayer = GetEntityHealth(GetPlayerPed(-1))
		
			for i=1, #Licenses, 1 do
				ownedLicenses[Licenses[i].type] = true
			end

        for i=1, #Config.BedList do
            local bedID   = Config.BedList[i]
            local distance = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z, true)
			
			if distance < 2.5 then
				DrawMarker(23, bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z-1.45, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 2.5, 2.5, 0.2, 255, 255, 255, 100, false, false, 2, false, false, false, false)
			end
			
            if distance < Config.MaxDistance and InAction == false then
					ESX.ShowHelpNotification(bedID.text)
                --ESX.Game.Utils.DrawText3D({ x = bedID.objCoords.x, y = bedID.objCoords.y, z = bedID.objCoords.z + 0.2 }, bedID.text, 0.6)

                if IsControlJustReleased(0, Keys['E']) then
					Citizen.Wait(500)
					if vidaPlayer <= 170 then
						if not ownedLicenses['planosaude'] then
							ESX.TriggerServerCallback('esx_recuperacao:pagarTratamento', function (hasEnoughMoney)
								if hasEnoughMoney then
									ESX.ShowNotification('Você não possui plano de saude, por isso pagará uma taxa de R$ 500')
										DoScreenFadeOut(3000)
										TriggerServerEvent('esx_society:addMoney', 'ambulance', 750)
										bedActive(bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z, bedID.heading, bedID)
										Citizen.Wait(500)
										DoScreenFadeIn(3000)
								else
									ESX.ShowNotification('Você não possui dinheiro suficiente, o tratamento custa R$ 500')
								end
							end)
						else
							DoScreenFadeOut(3000)
							bedActive(bedID.objCoords.x, bedID.objCoords.y, bedID.objCoords.z, bedID.heading, bedID)
							TriggerServerEvent('esx_society:addMoney', 'ambulance', 1000)
							Citizen.Wait(500)
							DoScreenFadeIn(3000)
						end
					else
						ESX.ShowNotification('Você não precisa de atendimento médico!')
					end
                end
            end
        end
    end
end)

RegisterNetEvent('esx_recuperacao:loadLicenses')
AddEventHandler('esx_recuperacao:loadLicenses', function(licenses)
	Licenses = licenses
end)

function bedActive(x, y, z, heading)

    SetEntityCoords(GetPlayerPed(-1), x, y, z + 0.3)
    RequestAnimDict('anim@gangops@morgue@table@')
    while not HasAnimDictLoaded('anim@gangops@morgue@table@') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(GetPlayerPed(-1), 'anim@gangops@morgue@table@' , 'ko_front' ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(GetPlayerPed(-1), heading + 180.0)
	FreezeEntityPosition(GetPlayerPed(-1), true)
    InAction = true


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            if InAction == true then
                local playerLife = GetEntityHealth(GetPlayerPed(-1))
				
				FreezeEntityPosition(GetPlayerPed(-1), true)

					for i = playerLife, 200, 1 do
						SetEntityHealth(GetPlayerPed(-1), i)
						Citizen.Wait(2000)
						if currentView ~= 4 then
							SetFollowPedCamViewMode(4)

							Citizen.Wait(5)
						end
					end
					
					
					
					if playerLife >= 200 then
						ClearPedTasks(GetPlayerPed(-1))
						FreezeEntityPosition(GetPlayerPed(-1), false)
						SetEntityCoords(GetPlayerPed(-1), x - 1.2, y, z)
						ResetPedMovementClipset(GetPlayerPed(-1), 0)
						InAction = false
						Citizen.Wait(250)
						Efeitos()
					end
            end
        end
    end)
end

function Efeitos()
	ESX.ShowNotification('Você ficará sobre efeito do medicamento por alguns minutos. Evite dirigir!')
	RequestAnimSet("move_m@drunk@slightlydrunk")
	while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
		Citizen.Wait(0)
	end
	SetPedMovementClipset(GetPlayerPed(-1), "move_m@drunk@slightlydrunk", true)
    StartScreenEffect('HeistCelebPass', 0, true)
		Citizen.Wait(300000)
    StopAllScreenEffects(GetPlayerPed(-1))
	ResetPedMovementClipset(GetPlayerPed(-1), 0)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if InAction then
			DisableAllControlActions(0)
			DisableControlAction(0, Keys['F3'], true) -- Reload
		else
			Citizen.Wait(500)
		end
	end
end)


function headsUp(text)
    SetTextComponentFormat('STRING')
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
