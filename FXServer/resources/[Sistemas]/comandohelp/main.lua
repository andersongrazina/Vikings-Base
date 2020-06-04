local open = false

RegisterCommand("help", function()
    Citizen.CreateThread(function()
      TriggerEvent('comandohelp:on', true)
    end)
end)

RegisterNetEvent('comandohelp:on')
AddEventHandler('comandohelp:on', function()
	SetNuiFocus(true, true)
	open = true
	SendNUIMessage({
		action = 'open'
	})
end)

RegisterNUICallback('escape', function(data, cb)
	SetNuiFocus(false, false)
	open = false
	 SendNUIMessage({
      action = 'close'
    })
	cb('ok')
end)

RegisterNetEvent('comandohelp:off')
AddEventHandler('comandohelp:off', function()
	SetNuiFocus(false, false)
	open = false
    SendNUIMessage({
      action = 'close'
    })
end)
