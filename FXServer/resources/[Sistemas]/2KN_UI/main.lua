ESX								= nil
local open = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand("on", function()
	Citizen.CreateThread(function()
		TriggerEvent('nui:on', true)
	end)
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
	TriggerEvent("nui:off", true)
	open = false
	cb('ok')
end)
RegisterNUICallback('INVENTARIO', function(data, cb)
	TriggerClientEvent('showNotification', -1,"~r~NEGO2K ~w~ HUD.")
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
