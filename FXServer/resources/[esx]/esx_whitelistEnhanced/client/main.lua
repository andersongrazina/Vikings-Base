RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	Citizen.Wait(10000)
	TriggerServerEvent('esx_whitelistExtended:removePlayerToInConnect')
end)