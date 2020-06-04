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

ESX                     = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentBlip       = nil
local CurrentZoneType   = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawMissionText(msg, time)
	ClearPrints()
	SetTextEntry_2('STRING')
	AddTextComponentString(msg)
	DrawSubtitleTimed(time, 1)
end

function StartTheoryTest()
	CurrentTest = 'theory'

	SendNUIMessage({
		openQuestion = true
	})

	ESX.SetTimeout(200, function()
		SetNuiFocus(true, true)
	end)

	TriggerServerEvent('esx_oab:pay', Config.Prices['oab'])
end

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage({
		openQuestion = false
	})

	SetNuiFocus(false)

	if success then
		TriggerServerEvent('esx_oab:addLicense', 'oab')
		ESX.ShowNotification(_U('passed_test'))
	else
		ESX.ShowNotification(_U('failed_test'))
	end
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

function OpenOabTestMenu()
	local ownedLicenses = {}

	for i=1, #Licenses, 1 do
		ownedLicenses[Licenses[i].type] = true
	end

	local elements = {}

	if not ownedLicenses['oab'] then
		table.insert(elements, {label = _U('theory_test') .. ' <span style="color: green;">$' .. Config.Prices['oab'] .. '</span>', value = 'theory_test'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'oabtest_actions',
	{
		title    = _U('oab_test'),
		elements = elements,
		align    = 'top-left',
	}, function(data, menu)
		if data.current.value == 'theory_test' then
			menu.close()
			StartTheoryTest()
		end
		
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'oab_menu'
			CurrentActionMsg  = _U('press_open_menu')
			CurrentActionData = {}
		end
	)
end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})

	cb('OK')
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb('OK')
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb('OK')
end)

AddEventHandler('esx_oab:hasEnteredMarker', function(zone)
	if zone == 'OABTest' then
		CurrentAction     = 'oab_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_oab:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('esx_oab:loadLicenses')
AddEventHandler('esx_oab:loadLicenses', function(licenses)
	Licenses = licenses
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.OABTest.Pos.x, Config.Zones.OABTest.Pos.y, Config.Zones.OABTest.Pos.z)

	SetBlipSprite (blip, 408)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.8)
	SetBlipColour (blip, 78)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('oab_blip'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
			end
		end

		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone                = currentZone
			TriggerEvent('esx_oab:hasEnteredMarker', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_oab:hasExitedMarker', LastZone)
		end
	end
end)

-- Block UI
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if CurrentTest == 'theory' then
			local playerPed = PlayerPedId()

			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Citizen.Wait(500)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then

			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'oab_menu' then
					OpenOabTestMenu()
				end

				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)