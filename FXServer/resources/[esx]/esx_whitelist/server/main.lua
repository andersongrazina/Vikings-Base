WhiteList       = {}

function loadWhiteList(cb)
	Whitelist = {}

	MySQL.Async.fetchAll('SELECT * FROM whitelist', {}, function (identifiers)
		for i=1, #identifiers, 1 do
			table.insert(WhiteList, tostring(identifiers[i].identifier):lower())
		end

		if cb ~= nil then
			cb()
		end
	end)
end

MySQL.ready(function()
	loadWhiteList()
end)

AddEventHandler('playerConnecting', function(name, setCallback, deferrals)
	-- Mark this connection as deferred, this is to prevent problems while checking player identifiers.
	deferrals.defer()

	local _source = source
	
	-- Letting the user know what's going on.
	deferrals.update(_U('whitelist_check'))
	
	-- Needed, not sure why.
	Citizen.Wait(100)
	local id
			for k,v in ipairs(GetPlayerIdentifiers(_source))do
				if string.sub(v, 1, string.len("steam:")) == "steam:" then
					id = v
					break
				end
			end

	if not id then
			DropPlayer(_source, "SteamID não encontrada, por favor reinicie o FiveM com a Steam aberta!")
	else
		
	local whitelisted, kickReason, steamID = false, nil, GetPlayerIdentifiers(_source)[1]

		if #WhiteList == 0 then
			kickReason = _U('whitelist_empty')
		elseif not string.match(steamID, 'steam:1') then
			kickReason = _U('steamid_error')
		else
			

			for i = 1, #WhiteList, 1 do
				if tostring(WhiteList[i]) == tostring(steamID) then
					whitelisted = true
					break
				end
			end

			if not whitelisted then
				kickReason = 'Você não possui Visto(WhiteList) para este servidor. Fale sobre isso no Discord. \n Discord: https://discord.gg/cKY7KA2. \nSteam(Hex): '..steamID
			end

		end
	

	if whitelisted then
		deferrals.done()
	else
		deferrals.done(kickReason)
	end
	end
end)
