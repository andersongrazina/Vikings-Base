local ped = PlayerPedId()

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
			if GetEntityHealth(GetPlayerPed(-1)) <= 150 then
				RequestAnimSet("move_injured_generic")
				while not HasAnimSetLoaded("move_injured_generic") do
					Citizen.Wait(0)
				end
				SetPedMovementClipset(GetPlayerPed(-1), "move_injured_generic", 1 )
		end
	end
end)