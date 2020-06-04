local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

local menuIsShowed 				 = false
local hasAlreadyEnteredMarker 	 = false
local lastZone 					 = nil
local isInLavagemMarker 		 = false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function ShowLavagemMenu()
	
end

AddEventHandler('esx_blanchisseur:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
	TriggerServerEvent('esx_blanchisseur:stopWhitening')
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.Zones, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z + 1, 0.0, 0.0, 0.0, 0, 180.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				if GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < 1.5 then
					ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para Lavar dinheiro!')
				end
			end
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords         = GetEntityCoords(GetPlayerPed(-1))
		isInLavagemMarker = false
		local currentZone    = nil
		for i=1, #Config.Zones do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.ZoneSize.x + 0.5) then
				isInLavagemMarker  = true
			end
		end
		if isInLavagemMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isInLavagemMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_blanchisseur:hasExitedMarker')
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustReleased(0, Keys['E']) and isInLavagemMarker and not menuIsShowed then
			TriggerServerEvent('esx_blanchisseur:startWhitening')
		end
		CurrentAction = nil
	end
end)
