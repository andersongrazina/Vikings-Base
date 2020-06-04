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

ESX                           = nil
local isDead = false
local menuIsShowed = false
local hasAlreadyEnteredMarker = false
local lastZone = nil
local isInInfoMarker = falset

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function ShowInfoMenu()
	local elements = { }
	  table.insert(elements, {label = _U('weed') .. Config.PriceWeedF .. _U('weed1'),    value = 'weed'})
	  table.insert(elements, {label = _U('tweed') .. Config.PriceWeedT .. _U('tweed1'),    value = 'tweed'})
	  table.insert(elements, {label = _U('rweed') .. Config.PriceWeedR .. _U('rweed1'),    value = 'rweed'})
	  table.insert(elements, {label = _U('opium') .. Config.PriceOpiumF .. _U('opium1'),    value = 'opium'})
	  table.insert(elements, {label = _U('topium') .. Config.PriceOpiumT .. _U('topium1'),    value = 'topium'})
	  table.insert(elements, {label = _U('ropium') .. Config.PriceOpiumR .. _U('ropium1'),    value = 'ropium'})
	  table.insert(elements, {label = _U('coke') .. Config.PriceCokeF .. _U('coke1'),    value = 'coke'})
	  table.insert(elements, {label = _U('tcoke') .. Config.PriceCokeT .. _U('tcoke1'),    value = 'tcoke'})
	  table.insert(elements, {label = _U('rcoke') .. Config.PriceCokeR .. _U('rcoke1'),    value = 'rcoke'})
	  table.insert(elements, {label = _U('meth') .. Config.PriceMethF .. _U('meth1'),    value = 'meth'})
	  table.insert(elements, {label = _U('tmeth') .. Config.PriceMethT .. _U('tmeth1'),    value = 'tmeth'})
	  table.insert(elements, {label = _U('rmeth') .. Config.PriceMethR .. _U('rmeth1'),    value = 'rmeth'})
	  table.insert(elements, {label = 'Lavagem de dinheiro (R$' .. Config.PriceLavagem .. ')',    value = 'lavagemdedinheiro'})

  ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'info',
      {
        title    = _U('info'),
        align    = 'top-left',
        elements = elements,
        },

        function(data, menu)

        if data.current.value == 'weed' then
           TriggerServerEvent("esx_infoillegal:Weed")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'tweed' then
           TriggerServerEvent("esx_infoillegal:TWeed")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'rweed' then
           TriggerServerEvent("esx_infoillegal:RWeed")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'opium' then
           TriggerServerEvent("esx_infoillegal:Opium")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'topium' then
           TriggerServerEvent("esx_infoillegal:TOpium")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'ropium' then
           TriggerServerEvent("esx_infoillegal:ROpium")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'coke' then
           TriggerServerEvent("esx_infoillegal:Coke")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'tcoke' then
           TriggerServerEvent("esx_infoillegal:TCoke")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'rcoke' then
           TriggerServerEvent("esx_infoillegal:RCoke")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'meth' then
           TriggerServerEvent("esx_infoillegal:Meth")
		   ESX.UI.Menu.CloseAll()
        end
		
		if data.current.value == 'tmeth' then
           TriggerServerEvent("esx_infoillegal:TMeth")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'rmeth' then
           TriggerServerEvent("esx_infoillegal:RMeth")
		   ESX.UI.Menu.CloseAll()
        end
		if data.current.value == 'lavagemdedinheiro' then
           TriggerServerEvent("esx_infoillegal:LavagemDinheiro")
		   ESX.UI.Menu.CloseAll()
        end

      CurrentAction     = 'menu_info_illegal'
      CurrentActionData = {}

    end,
    function(data, menu)

      menu.close()
    end
    )
end

AddEventHandler('esx_infoilegal:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.Zones do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				if (GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < (Config.ZoneSize.x / 2) + 0.5) then
					ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pedir alguma informação!')
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
		isInInfoMarker = false
		local currentZone    = nil
		for i=1, #Config.Zones do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < (Config.ZoneSize.x / 2) + 0.5) then
				isInInfoMarker  = true
			end
		end
		if isInInfoMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isInInfoMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_infoilegal:hasExitedMarker')
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()
	for i=1, #Config.Zones do
		local blip = AddBlipForCoord(Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z)
		SetBlipSprite (blip, 133)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.8)
		SetBlipColour (blip, 47)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Informações Ilegais')
		EndTextCommandSetBlipName(blip)
	end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustReleased(0, Keys['E']) and isInInfoMarker and not menuIsShowed and not isDead then
			ShowInfoMenu()
		end
	end
end)

RegisterNetEvent("esx_infoillegal:WeedFarm")
AddEventHandler("esx_infoillegal:WeedFarm", function()
	if Config.GPS then
		x, y, z = Config.WeedFarm.x, Config.WeedFarm.y, Config.WeedFarm.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RecWeed'))
	end
end)

RegisterNetEvent("esx_infoillegal:WeedTreatment")
AddEventHandler("esx_infoillegal:WeedTreatment", function()
	if Config.GPS then
		x, y, z = Config.WeedTreatment.x, Config.WeedTreatment.y, Config.WeedTreatment.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiWeed1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiWeed'))
	end
end)

RegisterNetEvent("esx_infoillegal:WeedResell")
AddEventHandler("esx_infoillegal:WeedResell", function()
	if Config.GPS then
		x, y, z = Config.WeedResell.x, Config.WeedResell.y, Config.WeedResell.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevWeed1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevWeed'))
	end
end)

RegisterNetEvent("esx_infoillegal:OpiumFarm")
AddEventHandler("esx_infoillegal:OpiumFarm", function()
	if Config.GPS then
		x, y, z = Config.OpiumFarm.x, Config.OpiumFarm.y, Config.OpiumFarm.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RecOpium'))
	end
end)

RegisterNetEvent("esx_infoillegal:OpiumTreatment")
AddEventHandler("esx_infoillegal:OpiumTreatment", function()
	if Config.GPS then
		x, y, z = Config.OpiumTreatment.x, Config.OpiumTreatment.y, Config.OpiumTreatment.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiOpium1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiOpium'))
	end
end)

RegisterNetEvent("esx_infoillegal:OpiumResell")
AddEventHandler("esx_infoillegal:OpiumResell", function()
	if Config.GPS then
		x, y, z = Config.OpiumResell.x, Config.OpiumResell.y, Config.OpiumResell.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevOpium1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevOpium'))
	end
end)

RegisterNetEvent("esx_infoillegal:CokeFarm")
AddEventHandler("esx_infoillegal:CokeFarm", function()
	if Config.GPS then
		x, y, z = Config.CokeFarm.x, Config.CokeFarm.y, Config.CokeFarm.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RecCoke'))
	end
end)

RegisterNetEvent("esx_infoillegal:CokeTreatment")
AddEventHandler("esx_infoillegal:CokeTreatment", function()
	if Config.GPS then
		x, y, z = Config.CokeTreatment.x, Config.CokeTreatment.y, Config.CokeTreatment.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiCoke1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiCoke'))
	end
end)

RegisterNetEvent("esx_infoillegal:CokeResell")
AddEventHandler("esx_infoillegal:CokeResell", function()
	if Config.GPS then
		x, y, z = Config.CokeResell.x, Config.CokeResell.y, Config.CokeResell.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevCoke1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevCoke'))
	end
end)

RegisterNetEvent("esx_infoillegal:MethFarm")
AddEventHandler("esx_infoillegal:MethFarm", function()
	if Config.GPS then
		x, y, z = Config.MethFarm.x, Config.MethFarm.y, Config.MethFarm.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RecMeth'))
	end
end)

RegisterNetEvent("esx_infoillegal:MethTreatment")
AddEventHandler("esx_infoillegal:MethTreatment", function()
	if Config.GPS then
		x, y, z = Config.MethTreatment.x, Config.MethTreatment.y, Config.MethTreatment.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiMeth1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('TraiMeth'))
	end
end)

RegisterNetEvent("esx_infoillegal:MethResell")
AddEventHandler("esx_infoillegal:MethResell", function()
	if Config.GPS then
		x, y, z = Config.MethResell.x, Config.MethResell.y, Config.MethResell.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevMeth1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevMeth'))
	end
end)

RegisterNetEvent("esx_infoillegal:LavagemLocal")
AddEventHandler("esx_infoillegal:LavagemLocal", function()
	if Config.GPS then
		x, y, z = Config.LavagemDinheiro.x, Config.LavagemDinheiro.y, Config.LavagemDinheiro.z
		SetNewWaypoint(x, y, z)
		local source = GetPlayerServerId();
		ESX.ShowNotification('A localização foi marcada no seu mapa!')
	else
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevMeth1'))
		TriggerEvent("esx_infoillegal:notify", "CHAR_LESTER_DEATHWISH", 1, _U('Notification'), false, _U('RevMeth'))
	end
end)


AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)