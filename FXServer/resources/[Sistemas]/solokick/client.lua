Citizen.CreateThread(function()
	Wait(3*60*10) -- Delay first spawn.
	while true do
		local count = 0
		for id = 0, 255 do 
			if NetworkIsPlayerActive(id) then
				count = count+1
			end
		end
		TriggerServerEvent('sendSession:PlayerNumber', count)
		Wait(5*60*10)
	end
end)
