local holdingUp = false
local bank = ""
local blipRobbery = nil
ESX = nil

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

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawTxt(text, x, y)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextScale(0.5, 0.5)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

RegisterNetEvent('esx_bankholdup:currentlyRobbing')
AddEventHandler('esx_bankholdup:currentlyRobbing', function(currentBank)
	holdingUp, bank = true, currentBank
end)

RegisterNetEvent('esx_bankholdup:killBlip')
AddEventHandler('esx_bankholdup:killBlip', function()
	RemoveBlip(blipRobbery)
end)

RegisterNetEvent('esx_bankholdup:setBlip')
AddEventHandler('esx_bankholdup:setBlip', function(position)
	blipRobbery = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipRobbery, 161)
	SetBlipScale(blipRobbery, 2.0)
	SetBlipColour(blipRobbery, 49)

	PulseBlip(blipRobbery)
end)

RegisterNetEvent('esx_bankholdup:tooFar')
AddEventHandler('esx_bankholdup:tooFar', function()
	holdingUp, bank = false, ''
	ESX.ShowNotification(_U('robbery_cancelled'))
end)

RegisterNetEvent('esx_bankholdup:robberyComplete')
AddEventHandler('esx_bankholdup:robberyComplete', function(award)
	holdingUp, bank = false, ''
	ESX.ShowNotification(_U('robbery_complete', award))
	ClearPedTasks(PlayerPedId())
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            local clothesSkin = { ['bags_1'] = 45, ['bags_2'] = 0 }
            TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
        else
            local clothesSkin = { ['bags_1'] = 45, ['bags_2'] = 0 }
          TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
		end
    end)
end)

RegisterNetEvent('esx_bankholdup:startTimer')
AddEventHandler('esx_bankholdup:startTimer', function()
	local timer = Banks[bank].secondsRemaining

	Citizen.CreateThread(function()
		while timer > 0 and holdingUp do
			Citizen.Wait(1000)

			if timer > 0 then
				timer = timer - 1
			end
		end
	end)

	Citizen.CreateThread(function()
		while holdingUp do
			Citizen.Wait(0)
			DrawTxt(_U('robbery_timer', timer), 0.17,0.80)
		end
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPos = GetEntityCoords(PlayerPedId(), true)

		for k,v in pairs(Banks) do
			local bankPos = v.position
			local distance = Vdist(playerPos.x, playerPos.y, playerPos.z, bankPos.x, bankPos.y, bankPos.z)

			if distance < Config.Marker.DrawDistance then
				if not holdingUp then
					DrawMarker(Config.Marker.Type, bankPos.x, bankPos.y, bankPos.z - 1, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, false, false, false, false)

					if distance < 0.5 then
						ESX.ShowHelpNotification(_U('press_to_rob', v.nameOfBank))

						if IsControlJustReleased(0, Keys['E']) then
							ESX.TriggerServerCallback('esx_service:contarTrabalhadores', function(podeAssaltar)
							 if podeAssaltar then 
								if IsPedArmed(PlayerPedId(), 4) then
									TriggerServerEvent('esx_bankholdup:robberyStarted', k)
								else
									ESX.ShowNotification(_U('no_threat'))
								end
							 else
								ESX.ShowNotification('Não policiais suficientes em serviço para executar um assalto')
							 end
							 end, Config.PoliceNumberRequired, 'police')
						end
					end
				end
			end
		end

		if holdingUp then
			local bankPos = Banks[bank].position
			if Vdist(playerPos.x, playerPos.y, playerPos.z, bankPos.x, bankPos.y, bankPos.z) > Config.MaxDistance or isDead then
				TriggerServerEvent('esx_bankholdup:tooFar', bank)
				TriggerEvent('skinchanger:getSkin', function(skin)
					if skin.sex == 0 then
						local clothesSkin = { ['bags_1'] = 0, ['bags_2'] = 0 }
						TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					else
						local clothesSkin = { ['bags_1'] = 0, ['bags_2'] = 0 }
					  TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
					end
				end)
			end
		end
	end
end)



RegisterNetEvent('esx_holdup:startRob')
AddEventHandler('esx_holdup:startRob', function(source)
    RobAnimation()
end)

function RobAnimation()
    local playerPed = GetPlayerPed(-1)

    Citizen.CreateThread(function()
		SetEntityHeading(GetPlayerPed(-1), 250.0)
		Citizen.Wait(2050)
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
        TriggerEvent('skinchanger:getSkin', function(skin)
            if skin.sex == 0 then
                local clothesSkin = { ['bags_1'] = 44, ['bags_2'] = 0 }
                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
            else
                local clothesSkin = { ['bags_1'] = 44, ['bags_2'] = 0 }
              TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
      end
    end)
  end)
end

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)