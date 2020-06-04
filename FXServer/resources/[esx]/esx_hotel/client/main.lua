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

ESX          = nil
local isDead = false
local menuIsShowed = false
local hasAlreadyEnteredMarker = false
local lastZone = nil
local isInHotelMarker = false

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

AddEventHandler('esx_hotel:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		isInHotelMarker = false
		local currentZone    = nil
		for i=1, #Config.Zones do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.ZoneSize.x / 2) then
				isInHotelMarker  = true
				ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para fazer check-in no Hotel')
			end
		end
		
		
		if isInHotelMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isInHotelMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_hotel:hasExitedMarker')
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.Zones, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z-1.001, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustReleased(0, Keys['E']) and isInHotelMarker and not menuIsShowed and not isDead then
			ESX.TriggerServerCallback('esx_hotel:verificarDinheiro', function(hasEnoughMoney)
			if hasEnoughMoney then
					dormir()
						ESX.ShowNotification('Você pagou ~y~R$250~s~ pela ~y~diária do hotel!')
				else
					ESX.ShowNotification('Você ~r~não tem dinheiro suficiente~s~ para pagar a ~y~diária do hotel~s~!')
				end
			end)
						
		end
	end
end)

function dormir()
	local playerPed = PlayerPedId()
	SetEntityCoords(GetPlayerPed(-1), 154.25, -1004.63, -99.119)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetEntityHeading(GetPlayerPed(-1), 316.53)
	TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_BUM_SLUMPED", 0, true)
	Citizen.CreateThread(function()
		Citizen.Wait(15000)
		ClearPedTasksImmediately(playerPed)
		SetEntityCoords(GetPlayerPed(-1), 344.33, -204.82, 58.03)
		FreezeEntityPosition(GetPlayerPed(-1), false)
	end)
end


Citizen.CreateThread(function()
	for i=1, #Config.Zones do
      	blipHotel = AddBlipForCoord(Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z)
      	SetBlipSprite(blipHotel, 430)
      	SetBlipColour(blipHotel, 3)
      	SetBlipAsShortRange(blipHotel, true)
      	BeginTextCommandSetBlipName("STRING")
      	AddTextComponentString('Hotel')
      	EndTextCommandSetBlipName(blipHotel)
    end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)