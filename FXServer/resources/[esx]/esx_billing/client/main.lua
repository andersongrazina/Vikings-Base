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
local isInBillsMarker = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		CalculateTimeToDisplay()
	end
end)

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
end

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0*scale, 0.5*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150) 
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function ShowBillsMenu()

	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		ESX.UI.Menu.CloseAll()
		local elements = {}

		for i=1, #bills, 1 do
			table.insert(elements, {
				label  = ('%s - <span style="color:red;">%s</span>'):format(bills[i].label, _U('invoices_item', ESX.Math.GroupDigits(bills[i].amount))),
				billID = bills[i].id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = _U('invoices'),
			align    = 'bottom-right',
			elements = elements
		}, function(data, menu)
			menu.close()
			if not isInBillsMarker then
						ESX.ShowAdvancedNotification('Banco Venus', 'Faturas', 'Você deve pagar suas faturas em um banco ou lotérica!', 'CHAR_BANK_MAZE', 9)
						menu.close()
					else
						if hour > 6 and hour < 22 then
							ESX.TriggerServerCallback('esx_billing:payBill', function()
							ShowBillsMenu()
							end, data.current.billID)
							ESX.UI.Menu.CloseAll()
						else 
							ESX.ShowAdvancedNotification('Banco Venus', 'Faturas', 'O pagamento de contas está fechado, volte entre as 7:00hrs e às 22:00hrs!', 'CHAR_BANK_MAZE', 9)
						end
				end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for i=1, #Config.Zones, 1 do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.ZoneSize.x, Config.ZoneSize.y, Config.ZoneSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
	end
end)

AddEventHandler('esx_billing:hasExitedMarker', function(zone)
	ESX.UI.Menu.CloseAll()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		isInBillsMarker = false
		local currentZone    = nil
		for i=1, #Config.Zones do
			if(GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < Config.ZoneSize.x / 2) then
				isInBillsMarker  = true
			end
		end
		if isInBillsMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
		end
		if not isInBillsMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			TriggerEvent('esx_billing:hasExitedMarker')
		end
	end
end)

local table = {
   { x = 248.21,  y = 222.41,  z = 106.29},-- BANCO CENTRAL
  {x = -339.72, y = -989.9, z = 30.91},
  {x = 135.7, y = 6650.03, z = 32.37},
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
        for k in pairs(table) do
			if GetDistanceBetweenCoords(coords, table[k].x, table[k].y, table[k].z, true) < 4 then
			Draw3DText(table[k].x, table[k].y, table[k].z, tostring("Pressione ~b~[E]~w~ para pagar suas ~y~faturas! "))
			end
			DrawMarker(27, table[k].x, table[k].y, table[k].z-1.0001, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.7001, 0, 255, 255, 200, 0, 0, 0, 0)
        end
    end
end)

-- Menu Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if IsControlJustReleased(0, Keys['E']) and isInBillsMarker and not menuIsShowed then
			ShowBillsMenu()
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsControlJustReleased(0, Keys['F7']) and not isDead and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'billing') then
			ShowBillsMenu()
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function(data)
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)
