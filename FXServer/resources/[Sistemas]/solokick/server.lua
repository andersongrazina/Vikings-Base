RegisterServerEvent('sendSession:PlayerNumber')
AddEventHandler('sendSession:PlayerNumber', function(clientPlayerNumber)
	if source ~= nil then
		serverPlayerNumber = GetPlayers()
		if #serverPlayerNumber-clientPlayerNumber > 6 then 
			DropPlayer(source, '[Kickado] Sessão solo.') -- Kick player
			print("sendSession:PlayerNumber clientPlayerNumber-"..clientPlayerNumber.." serverPlayerNumber-"..serverPlayerNumber) -- Debug
		end
	end
end)
