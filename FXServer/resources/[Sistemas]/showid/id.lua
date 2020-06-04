inCinema = false

function DrawTxt(text, x, y)
	SetTextFont(1)
	SetTextProportional(1)
	SetTextScale(0.5, 0.5)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

local id = GetPlayerServerId(PlayerId())

AddEventHandler('esx_cinema:enteredCinema', function()
	inCinema = true
end)

Citizen.CreateThread(function()
    while true do
    	Citizen.Wait(0)
		if not inCinema then
		DrawTxt("~y~Seu ID:~s~ "..id, 0.17, 0.90)
		end
    end
end)

AddEventHandler('esx_cinema:exitedCinema', function()
	inCinema = false
end)