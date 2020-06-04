--[[

  ESX RP Chat

--]]

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

 AddEventHandler('chatMessage', function(source, name, message)
      if string.sub(message, 1, string.len("/")) ~= "/" then
          local name = getIdentity(source)
		TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, message)
      end
      CancelEvent()
  end)
  
  -- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  --    local name = getIdentity(source)
  --    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 



  --- TriggerEvent('es:addCommand', 'me', function(source, args, user)
  ---    local name = getIdentity(source)
  ---    TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, table.concat(args, " "))
  -- end) 
  TriggerEvent('es:addCommand', 'me', function(source, args, user)
    local name = getIdentity(source)
    table.remove(args, 2)
    TriggerClientEvent('esx-qalle-chat:me', -1, source, name.firstname, table.concat(args, " "))
end)


 RegisterCommand('tt', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(3)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.5vw; color: #66a3ff; border-radius: 3px;"><i class="fab fa-twitter"></i> @{0}:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)

 RegisterCommand('olx', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.5vw; border-radius: 3px;"><i class="fas fa-car"></i> [OLX] {0}: {1}<br></div>',
        args = { fal, msg }
    })
end, false)

 RegisterCommand('frp', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.5vw; color: #00b300; border-radius: 3px;"><i class="fas fa-user"> {0} </i> [Fora do RP] : {1}<br></div>',
        args = { playerName, msg }
    })
end, false)

RegisterCommand('ilegal', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(7)
    local name = getIdentity(source)

    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.5vw; border-radius: 3px;"><i class="fas fa-user-secret"></i> Anônimo: {1}</div>',
        args = { playerName, msg }
    })
end, false)

RegisterCommand('190', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
	fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.5vw; color: #1a75ff; border-radius: 3px;"><i class="fas fa-address-card"></i> [190] {0}: {1}</div>',
        args = { fal, msg }
    })
end, false)

RegisterCommand('192', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
	fal = name.firstname .. " " .. name.lastname
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.1vw; margin: 0.5vw; color: #ff0000; border-radius: 3px;"><i class="fas fa-heartbeat" style="color:#ff0000;"></i></i> [192] {0}: {1}</div>',
        args = { fal, msg }
    })
end, false)


function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end
