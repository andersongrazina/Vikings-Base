local ace_perm = "admin"
local debug = false

function ProcessAces()
    if GetNumPlayerIndices() > 0 then -- don't do it when there aren't any players
        for i=0, GetNumPlayerIndices()-1 do -- loop through all players
            player = tonumber(GetPlayerFromIndex(i))
            Citizen.Wait(0)
            if IsPlayerAceAllowed(player, ace_perm) then
                TriggerClientEvent("sendAcePermissionToClient", player, true)
                if debug then print("[DEBUG][" .. GetCurrentResourceName() .. "] ^5Syncronising player aces, sending to client...^0") end
            end
        end
    end
end

RegisterServerEvent("godmod:kick")
AddEventHandler("godmod:kick", function()
	DropPlayer(source, 'Banido: Uso de Hack(GodMode)')
end)

--[[
TriggerEvent('es:addGroupCommand', 'ban', Config.permission, function (source, args, user)
	local identifier
	local license
	local liveid    = "no info"
	local xblid     = "no info"
	local discord   = "no info"
	local playerip
	local duree     = 365
	local reason    = 'GodMode'
	local permanent = 1
		
		if reason == "" then
			reason = _U('no_reason')
		end
		if source ~= nil and source > 0 then
			local ping = GetPlayerPing(source)
        
				if ping ~= nil and ping > 0 then
					local sourceplayername = GetPlayerName(source)
					local targetplayername = GetPlayerName(source)
						for k,v in ipairs(GetPlayerIdentifiers(source))do
							if string.sub(v, 1, string.len("steam:")) == "steam:" then
								identifier = v
							elseif string.sub(v, 1, string.len("license:")) == "license:" then
								license = v
							elseif string.sub(v, 1, string.len("live:")) == "live:" then
								liveid = v
							elseif string.sub(v, 1, string.len("xbl:")) == "xbl:" then
								xblid  = v
							elseif string.sub(v, 1, string.len("discord:")) == "discord:" then
								discord = v
							elseif string.sub(v, 1, string.len("ip:")) == "ip:" then
								playerip = v
							end
						end
				
						ban(source,identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,duree,reason,1)
						DropPlayer(source, _U('you_have_been_permabanned') .. reason)
					end
		else
			TriggerEvent('bansql:sendMessage', source, _U('invalid_id'))
			TriggerEvent('bansql:sendMessage', source, _U('add'))
		end
end)

function ban(source,identifier,license,liveid,xblid,discord,playerip,sourceplayername,sourceplayername,duree,reason,permanent)

	local expiration = duree * 86400
	local timeat     = os.time()
	local message
	
	if expiration < os.time() then
		expiration = os.time()+expiration
	end
	
		table.insert(BanList, {
			identifier = identifier,
			license    = license,
			liveid     = liveid,
			xblid      = xblid,
			discord    = discord,
			playerip   = playerip,
			reason     = reason,
			expiration = expiration,
			permanent  = permanent
          })




		MySQL.Async.execute(
                'INSERT INTO banlist (identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@identifier,@license,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)',
                { 
				['@identifier']       = identifier,
				['@license']          = license,
				['@liveid']           = liveid,
				['@xblid']            = xblid,
				['@discord']          = discord,
				['@playerip']         = playerip,
				['@targetplayername'] = targetplayername,
				['@sourceplayername'] = sourceplayername,
				['@reason']           = reason,
				['@expiration']       = expiration,
				['@timeat']           = os.time(),
				['@permanent']        = permanent,
				},
				function ()
		end)

		if permanent == 0 then
			TriggerEvent('bansql:sendMessage', source, (targetplayername .. _U('banned_for') .. duree .. _U('days_for') .. reason))
			message = (targetplayername .. identifier .." | ".. license .." | ".. liveid .." | ".. xblid .." | ".. discord .." | ".. playerip .." " .. _U('banned_for') .. duree .. _U('days_for') .. reason.." ".. _U('by') .." ".. sourceplayername)
		else
			TriggerEvent('bansql:sendMessage', source, (targetplayername .. _U('permabanned_for') .. reason))
			message = (targetplayername .. identifier .. " | " .. license .. " | " .. liveid .. " | " .. xblid .. " | " .. discord .. " | " .. playerip .." " .. _U('permabanned_for') .. reason .. " " .. _U('by') .. " " .. sourceplayername)
		end
		if Config.EnableDiscordLink then
			sendToDiscord(Config.webhookban, "BanSql", message, Config.red)
		end

		MySQL.Async.execute(
                'INSERT INTO banlisthistory (identifier,license,liveid,xblid,discord,playerip,targetplayername,sourceplayername,reason,expiration,timeat,permanent) VALUES (@identifier,@license,@liveid,@xblid,@discord,@playerip,@targetplayername,@sourceplayername,@reason,@expiration,@timeat,@permanent)',
                { 
				['@identifier']       = identifier,
				['@license']          = license,
				['@liveid']           = liveid,
				['@xblid']            = xblid,
				['@discord']          = discord,
				['@playerip']         = playerip,
				['@targetplayername'] = targetplayername,
				['@sourceplayername'] = sourceplayername,
				['@reason']           = reason,
				['@expiration']       = expiration,
				['@timeat']           = os.time(),
				['@permanent']        = permanent,
				},
				function ()
		end)
		
		BanListHistoryLoad = false
end
]]

Citizen.CreateThread(function()
    while true do
        ProcessAces()
        Citizen.Wait(60000) -- lets check every minute
    end
end)

AddEventHandler("onResourceStart", function(name)
    if name == GetCurrentResourceName() then
        ProcessAces()
        if debug then print("[DEBUG][" .. GetCurrentResourceName() .. "] ^6Resource [ " .. GetCurrentResourceName() .. " ] was (re)started, syncing aces to all players.^0") end
    end
end)