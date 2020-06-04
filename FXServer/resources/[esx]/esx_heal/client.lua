--  Made By Zeaqy --

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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	ScriptLoaded()
end)

function ScriptLoaded()
	LoadLocations()
end

local Locations = {
    ["Atendimento"] = {
        ["x"] = 308.15,
        ["y"] = -595.30,
        ["z"] = 43.29
    }
}

function LoadLocations()

	Citizen.CreateThread(function()

		while true do

			local sleepThread = 500

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			for locationId, v in pairs(Locations) do
				local distanceCheck = GetDistanceBetweenCoords(pedCoords, v["x"], v["y"], v["z"], true)

				if distanceCheck <= 5.0 then
					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "" .. locationId, 0.5)

					if distanceCheck <= 2.0 then
                        if IsControlJustPressed(0, 38) then
                            OpenERMenu()
						end
					end					
				end
			end
			Citizen.Wait(sleepThread)
		end
	end)
end

function DoAction(action)
	local currentView = GetFollowPedCamViewMode()
	
    if action == "Reception" then
		ClearPedTasksImmediately(GetPlayerPed(-1))
		Citizen.Wait(750)
		SetEntityCoords(GetPlayerPed(-1), 349.87, -583.67, 42.88 + 0.2)
        SetEntityHeading(GetPlayerPed(-1), -25 + 180.0)
		DoScreenFadeIn(3000)
        TriggerEvent('esx_ambulancejob:revive', GetPlayerPed(-1))
        SetEntityHealth(GetPlayerPed(-1), 200)
        Citizen.Wait(1000)
        ERINProgress()
        Citizen.Wait(500)
        Citizen.CreateThread(function()
            local timeStarted = GetGameTimer()
            local Reception = true
			local playerPed = GetPlayerPed(-1)
            local time = 120000
			while Reception do
			
				if currentView ~= 4 then
					SetFollowPedCamViewMode(4)

				Citizen.Wait(5)
				
                local percent = (GetGameTimer() - timeStarted) / time * 100
                local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

				ESX.Game.Utils.DrawText3D({ x = x, y = y, z = z + 1.0 }, "~g~Tratamento " .. math.ceil(percent) .. "%~s~", 0.4)
				
				
				if percent >= 100 then
                    ClearPedTasksImmediately(GetPlayerPed(-1))
                    Reception = false
					DisableControlAction(0, Keys['N-'], false) 
					DoScreenFadeIn(3000)
					FreezeEntityPosition(GetPlayerPed(-1), false)
                    ESX.ShowNotification('Você ficará sobre efeito do medicamento por alguns minutos. Evite dirigir!')
					SetEntityCoords(GetPlayerPed(-1), 347.93, -583.22, 43.32)
					ResetPedMovementClipset(playerPed, 0)
					SetEntityHeading(GetPlayerPed(-1), 78.0)
					RequestAnimSet("move_m@drunk@slightlydrunk")
					while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
					 Citizen.Wait(0)
					end
					SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
                    StartScreenEffect('HeistCelebPass', 0, true)
                    Citizen.Wait(300000)
                    StopAllScreenEffects(GetPlayerPed(-1))
					ResetPedMovementClipset(playerPed, 0)
				end
			end
		  end
		end)
    end
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
	end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

function OpenERMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'er_menu',
        {
            title    = 'Hospital',
            elements = {
				{label = 'Tratamento: R$500', value = 'er' },
            }
        },
        function(data, menu)
            if data.current.value == 'er' then
                ESX.TriggerServerCallback('esx_heal:money', function(hasMoney)
                    if hasMoney then
                        TriggerServerEvent('esx_heal:check')
        end
        ESX.UI.Menu.CloseAll()
    end)
end
end,
    function(data, menu)
        menu.close()
    end)
end

function ERINProgress()
	DisableControlAction(0, Keys['N-'], true) 
    SetEntityCoords(GetPlayerPed(-1), 349.87, -583.67, 42.88 + 0.3)
	FreezeEntityPosition(GetPlayerPed(-1), true)
    RequestAnimDict('anim@gangops@morgue@table@')
    while not HasAnimDictLoaded('anim@gangops@morgue@table@') do
        Citizen.Wait(0)
    end
    TaskPlayAnim(GetPlayerPed(-1), 'anim@gangops@morgue@table@' , 'ko_front' ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(GetPlayerPed(-1), -25 + 180.0)
    InAction = true


    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
        end
    end)
end

function Nurse()
    wanted_model="s_m_m_doctor_01"
    modelHash = GetHashKey(wanted_model)
    RequestModel(modelHash)

    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
    local Nurse1 = CreatePed(5, modelHash , 342.4, -586.08, 44.02, 65.79, false, false)
    SetEntityAsMissionEntity(Nurse1)
    Wait(1500)

    SetPedDesiredHeading(Nurse1, 214.00)
    Wait(100)
    
    TaskGoStraightToCoord(Nurse1, 348.53, -583.32, 42.41, 1.0, 5000, 255.50, 2.0)
    Wait(5000)

    TaskStartScenarioInPlace(Nurse1, "WORLD_HUMAN_CLIPBOARD", 0, false)
    Wait(110000)
    TaskGoStraightToCoord(Nurse1, 342.41, -581.68, 42.41, 1.0, 5000, 70.50, 2.0)
    Wait(5000)
    DeleteEntity(Nurse1)
end

RegisterNetEvent('esx_heal:Last')
AddEventHandler('esx_heal:Last', function()
    TriggerServerEvent('esx_heal:pay')
    TriggerServerEvent('esx_society:addMoney', 'ambulance', 500)
    DoAction("Reception")
    Nurse()
end)
