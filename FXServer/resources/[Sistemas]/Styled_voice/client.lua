local playerNamesDist = 10

Citizen.CreateThread(function()
    while true do
        for id = 0, 31 do
            if  ((NetworkIsPlayerActive( id )) and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) then
                ped = GetPlayerPed( id )
 
                x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
                distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
			local takeaway = 0.98

                if ((distance < playerNamesDist) and IsEntityVisible(GetPlayerPed(id))) ~= GetPlayerPed( -1 ) then
					if NetworkIsPlayerTalking(id) then
						DrawMarker(25,x2,y2,z2 - takeaway, 0, 0, 0, 0, 0, 0, 0.65, 0.65, 10.3, 255, 50, 50, 200, 0, 0, 2, 0, 0, 0, 0)
                    end
                end  
            end
        end
        Citizen.Wait(0)
    end
end)
