function setBleedingOn(ped)

    SetEntityHealth(ped,GetEntityHealth(ped)-2)
    ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 1.0)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
    Wait(7000)
 
 end
 
 function setBleedingOff(ped)
    SetPlayerHealthRechargeMultiplier(PlayerId(), 1.0)
 end
 
 Citizen.CreateThread(function()
 while true do
 Wait(0)
 local player = GetPlayerPed(-1)
 local Health = GetEntityHealth(player)
 
  if Health <= 139  then
     setBleedingOn(player)
      
  elseif Health > 140 then
    setBleedingOff(player)
  end
 end
 end)
  
 function InfoRanny(text)
 SetNotificationTextEntry("STRING")
 AddTextComponentString(text)
 DrawNotification(false, false)
 end