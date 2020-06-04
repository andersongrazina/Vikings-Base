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
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)

	ESX.TriggerServerCallback('esx_shops:requestDBItems', function(ShopItems)
		for k,v in pairs(ShopItems) do
			Config.Zones[k].Items = v
		end
	end)
end)

function OpenShopMenu(zone)
	local elements = {}
	for i=1, #Config.Zones[zone].Items, 1 do
		local item = Config.Zones[zone].Items[i]

		if item.limit == -1 then
			item.limit = 100
		end

		table.insert(elements, {
			label      = ('%s - <span style="color:green;">%s</span>'):format(item.label, _U('shop_item', ESX.Math.GroupDigits(item.price))),
			label_real = item.label,
			item       = item.item,
			price      = item.price,

			-- menu properties
			value      = 1,
			type       = 'slider',
			min        = 1,
			max        = item.limit
		})
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
		title    = _U('shop'),
		align    = 'bottom-right',
		elements = elements
	}, function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title    = _U('shop_confirm', data.current.value, data.current.label_real, ESX.Math.GroupDigits(data.current.price * data.current.value)),
			align    = 'bottom-right',
			elements = {
				{label = _U('no'),  value = 'no'},
				{label = _U('yes'), value = 'yes'}
			}
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				if zone == 'ExtraItemsShop' then
					TriggerServerEvent('esx_shops:buyItemIllegal', data.current.item, data.current.value, zone)
				else
					TriggerServerEvent('esx_shops:buyItem', data.current.item, data.current.value, zone)
				end
			end

			menu2.close()
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_menu')
		CurrentActionData = {zone = zone}
	end)
end

AddEventHandler('esx_shops:hasEnteredMarker', function(zone)
	if zone == 'bread' then
		CurrentAction     = 'shop_menu_bread'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para comprar ~b~Pão~s~ por ~y~ R$3~s~!'
		CurrentActionData = {zone = zone}
	elseif zone == 'cola' then
		CurrentAction     = 'shop_menu_cola'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para comprar ~b~Coca-Cola~s~ por ~y~ R$6~s~!'
		CurrentActionData = {zone = zone}
	elseif zone == 'cerveja' then
		CurrentAction     = 'shop_menu_cerveja'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para comprar ~b~Cerveja~s~ por ~y~ R$12~s~!'
		CurrentActionData = {zone = zone}
	elseif zone == 'leitep' then
		CurrentAction     = 'shop_menu_leitep'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para comprar ~b~Leite Pequeno~s~ por ~y~ R$3~s~!'
		CurrentActionData = {zone = zone}
	elseif zone == 'leiteg' then
		CurrentAction     = 'shop_menu_leiteg'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para comprar ~b~Leite 1LT~s~ por ~y~ R$8~s~!'
		CurrentActionData = {zone = zone}
	elseif zone == 'burger' then
		CurrentAction     = 'shop_menu_burger'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para comprar ~b~X-Burger~s~ por ~y~ R$5~s~!'
		CurrentActionData = {zone = zone}
	elseif zone == 'water' then
		CurrentAction     = 'shop_menu_water'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para comprar ~b~Água~s~ por ~y~ R$2~s~!'
		CurrentActionData = {zone = zone}
	else
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_menu')
		CurrentActionData = {zone = zone}
	end
end)

RegisterNetEvent('esx_shops:animacao')
AddEventHandler('esx_shops:animacao', function()
	loadAnimDict("anim@am_hold_up@male")
	local lib, anim = 'anim@am_hold_up@male', 'shoplift_high'
	ESX.Streaming.RequestAnimDict(lib, function()	
		TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
		Citizen.Wait(2000)
	end)
end)
AddEventHandler('esx_shops:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()

	for i=1, #Config.Map, 1 do

		local blip = AddBlipForCoord(Config.Map[i].x, Config.Map[i].y, Config.Map[i].z)
		SetBlipSprite (blip, Config.Map[i].id)
		SetBlipScale  (blip, 0.8)
		SetBlipDisplay(blip, 4)
		SetBlipColour (blip, Config.Map[i].color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Map[i].name)
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.DrawDistance) then
					DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z + 1, 0.0, 0.0, 0.0, 0, 180.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local coords      = GetEntityCoords(GetPlayerPed(-1))
		local isInMarker  = false
		local currentZone = nil

		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Pos, 1 do
				if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x + 0.45) then
					isInMarker  = true
					ShopItems   = v.Items
					currentZone = k
					LastZone    = k
				end
			end
		end
		
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('esx_shops:hasEnteredMarker', currentZone)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('esx_shops:hasExitedMarker', LastZone)
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
				if CurrentAction == 'shop_menu' then
					OpenShopMenu(CurrentActionData.zone)
				elseif CurrentAction == 'shop_menu_bread' then
					TriggerServerEvent('esx_shops:buyPrateileira', 'bread', 3, zone)
				elseif CurrentAction == 'shop_menu_cola' then
					TriggerServerEvent('esx_shops:buyPrateileira', 'cola', 6, zone)
				elseif CurrentAction == 'shop_menu_cerveja' then
					TriggerServerEvent('esx_shops:buyPrateileira', 'cerveja', 12, zone)
				elseif CurrentAction == 'shop_menu_leitep' then
					TriggerServerEvent('esx_shops:buyPrateileira', 'leitep', 3, zone)
				elseif CurrentAction == 'shop_menu_leiteg' then
					TriggerServerEvent('esx_shops:buyPrateileira', 'leiteg', 8, zone)
				elseif CurrentAction == 'shop_menu_burger' then
					TriggerServerEvent('esx_shops:buyPrateileira', 'burger', 5, zone)
				elseif CurrentAction == 'shop_menu_water' then
					TriggerServerEvent('esx_shops:buyPrateileira', 'water', 2, zone)
				end
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		
		Citizen.Wait(0)
	end
end
