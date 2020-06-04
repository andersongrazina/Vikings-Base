local open = false

RegisterCommand("on", function()
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
		Citizen.CreateThread(function()
		  TriggerEvent('nui:on', true)
		end)
	else
	TriggerEvent('chatMessage', '', {0, 255, 0}, 'Você não está em um veículo!')
	end
end)
  

RegisterCommand("off", function()
   Citizen.CreateThread(function()
       TriggerEvent("nui:off", true)
   end)
end)

RegisterNUICallback('escape', function(data, cb)
	SetNuiFocus(false, false)
	SendNUIMessage({
		action = "close"
	})
	open = false
	cb('ok')
end)

RegisterNUICallback('MALAS', function(data, cb)
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
	   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
		  if GetVehicleDoorAngleRatio(playerVeh, 5) > 0.0 then 
			 SetVehicleDoorShut(playerVeh, 5, false)
		   else
			 SetVehicleDoorOpen(playerVeh, 5, false)      
		  end
	   end
	cb('ok')
end)

RegisterNUICallback('CAPO', function(data, cb)
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
	   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
		  if GetVehicleDoorAngleRatio(playerVeh, 4) > 0.0 then 
			 SetVehicleDoorShut(playerVeh, 4, false)
		   else
			 SetVehicleDoorOpen(playerVeh, 4, false)        
		  end
	   end
	cb('ok')
end)

RegisterNUICallback('PILOTO', function(data, cb)
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
	   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
		  if GetVehicleDoorAngleRatio(playerVeh, 0) > 0.0 then 
			 SetVehicleDoorShut(playerVeh, 0, false)
		   else
			 SetVehicleDoorOpen(playerVeh, 0, false)        
		  end
	   end
	cb('ok')
end)

RegisterNUICallback('PASSAGEIRO', function(data, cb)
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
	   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
		  if GetVehicleDoorAngleRatio(playerVeh, 1) > 0.0 then 
			 SetVehicleDoorShut(playerVeh, 1, false)
		   else
			 SetVehicleDoorOpen(playerVeh, 1, false)        
		  end
	   end
	cb('ok')
end)

RegisterNUICallback('P3', function(data, cb)
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
	   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
		  if GetVehicleDoorAngleRatio(playerVeh, 2) > 0.0 then 
			 SetVehicleDoorShut(playerVeh, 2, false)
		   else
			 SetVehicleDoorOpen(playerVeh, 2, false)        
		  end
	   end
	cb('ok')
end)

RegisterNUICallback('P4', function(data, cb)
   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
	   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
		  if GetVehicleDoorAngleRatio(playerVeh, 3) > 0.0 then 
			 SetVehicleDoorShut(playerVeh, 3, false)
		   else
			 SetVehicleDoorOpen(playerVeh, 3, false)        
		  end
	   end
	cb('ok')
end)

  --[[ ////////////////////////////////////////// ]]

RegisterNetEvent('nui:on')
AddEventHandler('nui:on', function()
   open = true
	SetNuiFocus( true, true )
	SendNUIMessage({
		action = "open"
	})
end)

RegisterNetEvent('nui:off')
AddEventHandler('nui:off', function()
    SetNuiFocus(false, false)
	SendNUIMessage({
		action = "close"
	})
	open = false
	cb('ok')
end)
