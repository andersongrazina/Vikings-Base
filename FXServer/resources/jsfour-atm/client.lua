-- *******
-- Copyright (C) JSFOUR - All Rights Reserved
-- You are not allowed to sell this script or re-upload it
-- Visit my page at https://github.com/jonassvensson4
-- Written by Jonas Svensson, July 2018
-- *******

local ESX	 = nil
local open = false
local type = 'fleeca'

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Notification
function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local table = {
  { x = 243.08,   y = 224.25,  z = 106.29},-- BANCO CENTRAL
  { x = 253.38,    y = 220.54,    z = 106.29},-- BANCO CENTRAL
  { x = -1212.77,    y = -330.33,    z = 37.79},-- BANCO VINEWOOD HILLS
  { x = -2962.93,    y = 482.95,    z = 15.7},-- BANCO RODOVIA PRAIA
  { x = -112.45,    y = 6468.86,    z = 31.63},-- BANCO PALETO BAY
  { x = 1175.0,    y = 2706.42,    z = 38.09},-- BANCO SANDY SHORES
  { x = 314.37,    y = -278.7,    z = 54.17},-- BANCO PREFEITURA
  { x = -350.85,    y = -49.46,    z = 49.04},-- BANCO SHOPPING
  
  { x = 150.12,   y = -1040.39,  z = 29.37} -- BANCO PRAÇA
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(table) do
            DrawMarker(29, table[k].x, table[k].y, table[k].z, 0, 0, 0, 0, 0, 0, 1.401, 1.4001, 1.4001, 0, 205, 0, 200, 0, 0, 0, true)
			DrawMarker(1, table[k].x, table[k].y, table[k].z-1.0001, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.7001, 0, 205, 0, 200, 0, 0, 0, 0)
        end
    end
end)

local table2 = {
  { x = 147.74,   y = -1035.44,  z = 29.34},-- ATM BANCO CENTRAL
  { x = 236.98,  y = 217.65,  z = 106.29}, -- ATM BANCO CENTRAL
  { x = -1205.5,  y = -324.69,  z = 37.86},-- ATM BANCO VINEWOOD HILLS
  { x = -2958.98,    y = 488.07,    z = 15.46},-- ATM BANCO RODOVIA PRAIA
  { x = -97.08,    y = 6455.25,    z = 31.46},-- ATM BANCO PALETO BAY
  { x = 1172.43,    y = 2702.22,    z = 38.17},-- ATM BANCO SANDY SHORES
  { x = 119.4,    y = -883.82,    z = 31.12},-- ATM PRAÇA
  { x = 295.51,    y = -895.97,    z = 29.21},-- ATM PRAÇA
  { x = 264.71,   y = 212.18,  z = 106.28}, -- ATM BANCO PRAÇA
  {x = 155.51, y = 6642.44, z = 31.61},
	{x = -133.2, y = 6366.31, z = 31.48},
	{x =-283.27, y = 6225.75, z = 31.49},
	{x = -387.09, y = 6045.85, z = 31.5},
	{x = -1091.21, y = 2708.38, z = 18.96},
	{x = 1686.54, y = 4815.81, z = 42.01},
	{x = -3240.97, y = 997.37, z = 12.55},
	{x = -3044.15, y = 595.02, z = 7.74},
	{x = -2975.38, y = 380.17, z = 15.0},
	{x = -2072.77, y = -317.24, z = 13.32},
	{x = 1701.35, y = 6426.49, z = 32.76},
	{x = -3143.83, y = 1127.36, z = 20.85},
	{x = -1019.24, y = 2708.25, z = 18.96},
	{x = 2565.16, y = 2584.94, z = 38.08}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        for k in pairs(table2) do
            DrawMarker(29, table2[k].x, table2[k].y, table2[k].z, 0, 0, 0, 0, 0, 0, 1.401, 1.4001, 1.4001, 0, 205, 0, 200, 0, 0, 0, true)
        end
    end
end)

-- Enter / Exit zones
Citizen.CreateThread(function ()
  SetNuiFocus(false, false)
	time = 500
	x = 1
  while true do
    Citizen.Wait(time)
		inMarker = false
		inBankMarker = false

    for i=1, #Config.ATMS, 1 do
      if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.ATMS[i].x, Config.ATMS[i].y, Config.ATMS[i].z, true) < 1  then
				x = i
				time = 0
				if ( Config.ATMS[i].b == nil ) then
					inMarker = true
					hintToDisplay('Pressione ~INPUT_PICKUP~ usar o caixa eletrônico')
				else
					inBankMarker = true
					type = Config.ATMS[i].t
					hintToDisplay('Pressione ~INPUT_PICKUP~ para ser atendido')
				end
			elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), Config.ATMS[x].x, Config.ATMS[x].y, Config.ATMS[x].z, true) > 4 then
				time = 500
			end
    end

	end
end)

-- Create account when the script is started
Citizen.CreateThread(function ()
	Wait(10000)
	TriggerServerEvent('jsfour-atm:createAccount')
end)

-- Key event
Citizen.CreateThread(function ()
  while true do
    Wait(0)
		if IsControlJustReleased(0, 38) and inMarker then
					
					ESX.TriggerServerCallback('jsfour-atm:getMoney', function( data )
					ESX.TriggerServerCallback('jsfour-atm:getUser', function( dataUser )
						SetNuiFocus(true, true)
						open = true
						SendNUIMessage({
						  action = "open",
							bank = data.bank,
							cash = data.cash,
							code = dataUser[1].code
						})
					end)
					end)
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_ATM", 0, true)
		end
		if IsControlJustReleased(0, 38) and inBankMarker then
			ESX.TriggerServerCallback('jsfour-atm:getMoney', function( data )
				ESX.TriggerServerCallback('jsfour-atm:getUser', function( dataUser )
					SetNuiFocus(true, true)
					open = true
					SendNUIMessage({
						action = "openBank",
						bank = data.bank,
						cash = data.cash,
						type = type,
						firstname = dataUser[1].firstname,
						lastname = dataUser[1].lastname,
						account = dataUser[1].account
					})
				end)
			end)
		end
	if open then
      DisableControlAction(0, 1, true) -- LookLeftRight
      DisableControlAction(0, 2, true) -- LookUpDown
      DisableControlAction(0, 24, true) -- Attack
      DisablePlayerFiring(GetPlayerPed(-1), true) -- Disable weapon firing
      DisableControlAction(0, 142, true) -- MeleeAttackAlternate
      DisableControlAction(0, 106, true) -- VehicleMouseControlOverrid
    end
	end
end)

-- Insert money
RegisterNUICallback('insert', function(data, cb)
	cb('ok')
	TriggerServerEvent('jsfour-atm:insert', data.money)
end)

-- Take money
RegisterNUICallback('take', function(data, cb)
	cb('ok')
	TriggerServerEvent('jsfour-atm:take', data.money)
end)

-- Transfer money
RegisterNUICallback('transfer', function(data, cb)
	cb('ok')
	TriggerServerEvent('jsfour-atm:transfer', data.money, data.account)
end)

-- Close the NUI/HTML window
RegisterNUICallback('escape', function(data, cb)
	SetNuiFocus(false, false)
	open = false
	cb('ok')
	ClearPedTasksImmediately(GetPlayerPed(-1))
	Citizen.Wait(250)
	local lib, anim = 'amb@prop_human_atm@male@exit', 'exit'
	ESX.Streaming.RequestAnimDict(lib, function()	
		TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
		Citizen.Wait(2000)
	end)
end)

-- Handles the error message
RegisterNUICallback('error', function(data, cb)
	SetNuiFocus(false, false)
	open = false
	cb('ok')
	ESX.ShowNotification('A máquina não está funcionando. Aguarde por favor...')
end)
