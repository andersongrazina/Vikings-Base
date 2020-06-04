local timeAndDateString = nil
local hour
local minute
local dayOfWeek

function RGBRainbow( frequency )
	local result = {}
	local curtime = GetGameTimer() / 1000

	result.r = math.floor( math.sin( curtime * frequency + 0 ) * 127 + 128 )
	result.g = math.floor( math.sin( curtime * frequency + 2 ) * 127 + 128 )
	result.b = math.floor( math.sin( curtime * frequency + 4 ) * 127 + 128 )
	
	return result
end

Citizen.CreateThread(function()
	while true do
		Wait(1)
			CalculateTimeToDisplay()
			CalculateDayOfWeekToDisplay()
			timeAndDateString = dayOfWeek .. " | " .. hour .. ":" .. minute
		
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.50, 0.30)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextWrap(0,0.95)
		SetTextEntry("STRING")
		
		AddTextComponentString(timeAndDateString)
		DrawText(0.46, 0.040)
	end
end)

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()

	if hour <= 9 then
		hour = "0" .. hour
	end
	if minute <= 9 then
		minute = "0" .. minute
	end
end

function CalculateDayOfWeekToDisplay()
	dayOfWeek = GetClockDayOfWeek()
	
	if dayOfWeek == 0 then
		dayOfWeek = "Domingo"
	elseif dayOfWeek == 1 then
		dayOfWeek = "Segunda"
	elseif dayOfWeek == 2 then
		dayOfWeek = "Terça"
	elseif dayOfWeek == 3 then
		dayOfWeek = "Quarta"
	elseif dayOfWeek == 4 then
		dayOfWeek = "Quinta"
	elseif dayOfWeek == 5 then
		dayOfWeek = "Sexta"
	elseif dayOfWeek == 6 then
		dayOfWeek = "Sábado"
	end
end

local rainbow = RGBRainbow(1)

Citizen.CreateThread( function()
	while true do
		Wait(0)
		SetTextFont(1)
		SetTextScale( 0.75, 0.75 )
		local rainbow = RGBRainbow(1)
		SetTextColour( rainbow.r, rainbow.g, rainbow.b, 255 )
		SetTextOutline()
		SetTextEntry( "STRING" )
		AddTextComponentString( "Venus Roleplay" )
		DrawText( 0.435, 0.005 )
	end
end)