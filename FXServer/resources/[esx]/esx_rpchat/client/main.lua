--[[

  ESX RP Chat

--]]



RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
    TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
  end
end)

--[[
AddEventHandler('esx-qalle-chat:me', function(id, name, message)
    local myId = PlayerId()
    local pid = GetPlayerFromServerId(id)

    if pid == myId then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(86, 125, 188, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i> {0}:<br> {1}</div>',
            args = { name, message }
        })
    elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 15.4 then
        TriggerEvent('chat:addMessage', {
            template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(86, 125, 188, 0.6); border-radius: 3px;"><i class="fas fa-user-circle"></i> {0}:<br> {1}</div>',
            args = { name, message }
        })
    end
end)--]]