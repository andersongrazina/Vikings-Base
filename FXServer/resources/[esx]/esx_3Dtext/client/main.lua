function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.2*scale, 0.7*scale)
        SetTextFont(1)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150) 
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function CreateBlipCircle(coords, text, radius, color, sprite)
	local blip = AddBlipForRadius(coords, radius)

	SetBlipHighDetail(blip, true)
	SetBlipColour(blip, 3)
	SetBlipAlpha (blip, 128)

	-- create a blip in the middle
	blip = AddBlipForCoord(coords)

	SetBlipHighDetail(blip, true)
	SetBlipSprite (blip, sprite)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, color)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(text)
	EndTextCommandSetBlipName(blip)
end

Citizen.CreateThread(function()
	for k,zone in pairs(Config.CircleZones) do

		CreateBlipCircle(zone.coords, zone.name, zone.radius, zone.color, zone.sprite)
	end
end)

Citizen.CreateThread(function()
	while true do
	Citizen.Wait(1)
	local coords = GetEntityCoords(GetPlayerPed(-1))
	
	for i=1, #Config.Zones do
		if GetDistanceBetweenCoords(coords, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z, true) < 12 then
			Draw3DText(Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z+0.35, tostring(Config.Zones[i].text))
			DrawMarker(Config.Zones[i].type, Config.Zones[i].x, Config.Zones[i].y, Config.Zones[i].z-0.99, 0, 0, 0, 0, 0, 0, 1.501, 1.5001, 0.7001, Config.Zones[i].r, Config.Zones[i].g, Config.Zones[i].b, 200, 0, 0, 0, 0)
		end
	end
	end
end)