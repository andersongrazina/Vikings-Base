ESX 					  = nil
local CurrentActionData   = {}
local lastTime 			  = 0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx_extraitems:rose')
AddEventHandler('esx_extraitems:rose', function()
	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local boneIndex = GetPedBoneIndex(playerPed, 57005)
	
	RequestAnimDict('amb@code_human_wander_drinking@beer@male@base')
	while not HasAnimDictLoaded('amb@code_human_wander_drinking@beer@male@base') do
		Citizen.Wait(10)
	end
	
	ESX.Game.SpawnObject('p_single_rose_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z + 2
	}, function(object)
		AttachEntityToEntity(object, playerPed, boneIndex, 0.10, 0, -0.001, 80.0, 150.0, 200.0, true, true, false, true, 1, true)
		TaskPlayAnim(playerPed, "amb@code_human_wander_drinking@beer@male@base", "static", 3.5, -8, -1, 49, 0, 0, 0, 0)
		Citizen.Wait(30000)
		DeleteObject(object)
		ClearPedSecondaryTask(playerPed)
	end)
end)

RegisterNetEvent('esx_extraitems:oxygen_mask')
AddEventHandler('esx_extraitems:oxygen_mask', function()
	local playerPed  = GetPlayerPed(-1)
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 12844)
	local boneIndex2 = GetPedBoneIndex(playerPed, 24818)
	
	ESX.Game.SpawnObject('p_s_scuba_mask_s', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		ESX.Game.SpawnObject('p_s_scuba_tank_s', {
			x = coords.x,
			y = coords.y,
			z = coords.z - 3
		}, function(object2)
			AttachEntityToEntity(object2, playerPed, boneIndex2, -0.30, -0.22, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			AttachEntityToEntity(object, playerPed, boneIndex, 0.0, 0.0, 0.0, 0.0, 90.0, 180.0, true, true, false, true, 1, true)
			SetPedDiesInWater(playerPed, false)
			
			ESX.ShowNotification(_U('dive_suit_on') .. '%.')
			Citizen.Wait(50000)
			ESX.ShowNotification(_U('oxygen_notify', '~y~', '50') .. '%.')
			Citizen.Wait(25000)
			ESX.ShowNotification(_U('oxygen_notify', '~o~', '25') .. '%.')
			Citizen.Wait(25000)
			ESX.ShowNotification(_U('oxygen_notify', '~r~', '0') .. '%.')
			
			SetPedDiesInWater(playerPed, true)
			DeleteObject(object)
			DeleteObject(object2)
			ClearPedSecondaryTask(playerPed)
		end)
	end)
end)

RegisterNetEvent('esx_extraitems:redgull')
AddEventHandler('esx_extraitems:redgull', function()
	local playerPed  = GetPlayerPed(-1)
	local coords     = GetEntityCoords(playerPed)
	local boneIndex  = GetPedBoneIndex(playerPed, 18905)
	local boneIndex2 = GetPedBoneIndex(playerPed, 57005)

	RequestAnimDict('mp_player_intdrink')
	while not HasAnimDictLoaded('mp_player_intdrink') do
		Citizen.Wait(1)
	end
	
	ESX.Game.SpawnObject('prop_energy_drink', {
		x = coords.x,
		y = coords.y,
		z = coords.z - 3
	}, function(object)
		TaskPlayAnim(playerPed, "mp_player_intdrink", "loop_bottle", 1.0, -1.0, 2000, 0, 1, true, true, true)
		AttachEntityToEntity(object, playerPed, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
		Citizen.Wait(3000)
		DeleteObject(object)
		ClearPedSecondaryTask(playerPed)
	end)
	ESX.ShowNotification(_U('redgull_consumed'))
	
	local timer = 0
	while timer < 300 do
		ResetPlayerStamina(PlayerId())
		Citizen.Wait(2000)
		timer = timer + 2
	end
	ESX.ShowNotification(_U('redgull_end'))
end)