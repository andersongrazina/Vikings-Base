--[[ 
local mph = 2.2369
local kph = 3.6 
]]

function DrawTxt(content)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextScale(1.1, 1.1)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(content.." ~g~km/h")
    DrawText(0.88,0.87)
end
    
Citizen.CreateThread(function()

    while true do
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsUsing(playerPed)
        Citizen.Wait(1)
        local speed = (GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1), false))*3.6)
        -- Condition to check if the ped is in a vehicle
        if(IsPedInAnyVehicle(GetPlayerPed(-1), true)) and GetPedInVehicleSeat(vehicle, -1) == playerPed then
            DrawTxt(math.floor(speed))
        end
    end
end)