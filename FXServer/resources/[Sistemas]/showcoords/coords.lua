inCinema = false

function DrawTxt(text, x, y)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

AddEventHandler('esx_cinema:enteredCinema', function()
	inCinema = true
end)

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		
    	roundx = tonumber(string.format("%.2f", x))
    	roundy = tonumber(string.format("%.2f", y))
		roundz = tonumber(string.format("%.2f", z-0.99))
		
		if not inCinema then
		DrawTxt("~r~X:~s~ "..roundx, 0.32, 0.00)
		DrawTxt("~r~Y:~s~ "..roundy, 0.38, 0.00)
		DrawTxt("~r~Z:~s~ "..roundz, 0.445, 0.00)

		heading = GetEntityHeading(GetPlayerPed(-1))
		roundh = tonumber(string.format("%.2f", heading))
		DrawTxt("~r~H:~s~ "..roundh, 0.50, 0.00)
		end
    end
end)

AddEventHandler('esx_cinema:exitedCinema', function()
	inCinema = false
end)
