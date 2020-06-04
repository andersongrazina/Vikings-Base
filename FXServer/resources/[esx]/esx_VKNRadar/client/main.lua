--===============================================--===============================================
--= stationary radars based on  https://github.com/DreanorGTA5Mods/StationaryRadar           =
--===============================================--===============================================



ESX              = nil
local multado = false
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end
	while ESX.GetPlayerData() ~= nil do
		Citizen.Wait(250)
		PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local radares = {
    {x = 379.68807983398, y = -1048.3527832031, z = 29.250692367554},
    {x = -253.10794067383, y = -630.20385742188, z = 33.002685546875},
	{x = -2253.63 , y = 234.67   , z =  173.62},
	{x = 1121.96  , y = -645.86  , z =  55.82},
	{x = 144.37   , y = -130.35  , z =  53.84},
	{x = -429.39  , y = -1727.91 , z =  18.79},
	{x =-936.07   , y = -1523.37 , z =  4.19},
	{x =-1665.91  , y = -1084.25 , z =  12.23},
	{x =  806.83  , y = -1812.18 , z =  28.39},
	{x =  787.18  , y = -2074.23 , z =  28.35},
	{x = -31.97   , y =-948.51   , z =  28.42},
	{x = -1079.75 , y =-763.0    , z =  18.36},
	{x =  277.71  , y = 168.2    , z =  103.51},
	{x =  -843.5  , y = 219.0    , z =  72.82},
	{x =  -769.3  , y =-1117.2   , z =  9.71},
	{x = -1285.19 , y = -913.86  , z =  10.41},
	{x = -258.75  , y = -46.15   , z =  48.55},
	{x =  -716.94 , y =  1050.03 , z =  244.95},
	{x =  223.99  , y = 1394.55  , z =  238.88},
	{x =  1295.62 , y = 1182.33  , z =  105.93},
	{x =  -1959.5 , y = 305.59   , z =  87.7},
	{x = -1503.87 , y = 1726.17  , z =  9171},
	{x =  858.17  , y = 983.02   , z =  240.15},
	{x =  1311.95 , y = 2683.12  , z =  36.7},
	{x = -781.34  , y = 2773.99  , z =  23.23},
	{x =  1036.0  , y = 3536.0   , z =  33.1},
	{x = 3272.02 , y = 4999.35 , z = 21.85},
	
}

local radares2  = {
    {x = -1023.93 ,y = 5365.2  ,z = 41.71},
{x = -2588.34 ,y = 3225.27 ,z = 12.66},
{x = -3149.5  ,y = 888.5   ,z = 13.75},
{x = -1396.42 ,y = -745.26 ,z = 10.16},
{x = -1391.33 ,y = -768.13 ,z = 10.14},
{x = 37.0     ,y = -524.25 ,z = 33.09},
{x = 37.05    ,y = -496.14 ,z = 33.08},
{x = -396.53  ,y = -987.68 ,z = 36.24},
{x = -414.13  ,y = -985.13 ,z = 36.29},
{x = -184.13  ,y =-2477.56 ,z = 51.04},
{x = -191.36  ,y =-2489.5  ,z = 50.96},
{x = 1220.56  ,y =-1971.49 ,z = 40.96},
{x = 1202.76  ,y =-1988.1  ,z = 41.69},
{x = 825.28   ,y = -687.22 ,z = 41.37},
{x = 1664.16  ,y = -928.74 ,z = 64.22},
{x = 2565.9   ,y = 104.28  ,z = 96.12},
{x = 2535.77  ,y = 447.23  ,z = 112.63},
{x = 2009.29  ,y = 1554.64 ,z = 74.46},
{x = 1936.0   ,y = 1830.75 ,z = 60.68},
{x = -752.93  ,y =-2190.85 ,z = 14.38},
{x = -889.68  ,y =-2278.82 ,z = 18.49},
{x = -1159.12, y = -663.45, z = 9.96},
{x = -1166.2, y = -651.51, z = 10.0},
}

Citizen.CreateThread(function()
    while true do
        Wait(0)
        for i,j in pairs(radares2) do
            local player = GetPlayerPed(-1)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if (GetDistanceBetweenCoords(coords, radares2[i].x, radares2[i].y, radares2[i].z, true) < 15) then
                if PlayerData.job ~= nil and not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
                    checkSpeed2()
                end
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        for k,v in pairs(radares) do
            local player = GetPlayerPed(-1)
            local coords = GetEntityCoords(GetPlayerPed(-1))
            if (GetDistanceBetweenCoords(coords, radares[k].x, radares[k].y, radares[k].z, true) < 15) then
                if PlayerData.job ~= nil and not (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance') then
                    checkSpeed()
                end
            end
        end
    end
end)

function checkSpeed()
    local pP = GetPlayerPed(-1)
    local speed = GetEntitySpeed(pP)
    local vehicle = GetVehiclePedIsIn(pP, false)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local plate = GetVehicleNumberPlateText(vehicle)
    local maxspeed = (25*3.6)
    local mphspeed = math.ceil(speed*3.6)
	local fineamount = nil
	local finelevel = nil
	local truespeed = mphspeed
	local model = GetEntityModel(vehicle)
	local displaytext = GetDisplayNameFromVehicleModel(model)
    if mphspeed > maxspeed and driver == pP then
        Citizen.Wait(250)
        TriggerServerEvent('fineAmount', mphspeed, maxspeed, plate)
	if truespeed >= 91 and truespeed <= 101 then
	fineamount = Config.Fine
	finelevel = '10mph Over Limit'
	end
	if truespeed >= 101 and truespeed <= 111 then
	fineamount = Config.Fine2
	finelevel = '20mph Over Limit'
	end
	if truespeed >= 111 and truespeed <= 121 then
	fineamount = Config.Fine3
	finelevel = '30mph Over Limit'
	end
	if truespeed >= 121 and truespeed <= 500 then
	fineamount = Config.Fine4
	finelevel = '40mph Over Limit'
	end
		if multado == false then
			multado = true
		StartScreenEffect('RaceTurbo',  0,  false)
		PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
		Citizen.Wait(500)
        ESX.ShowNotification('~o~Radar Fixo\n~y~Carro: ~s~'..displaytext..'\n~y~Placa: ~s~'..plate..'\n~y~Vel. ~s~'..mphspeed..'KM/H\n~y~Valor: ~s~R$'.. fineamount)
		end
		
	Citizen.Wait(2500)
	multado = false
    end
end

function checkSpeed2()
    local pP = GetPlayerPed(-1)
    local speed = GetEntitySpeed(pP)
    local vehicle = GetVehiclePedIsIn(pP, false)
    local driver = GetPedInVehicleSeat(vehicle, -1)
    local plate = GetVehicleNumberPlateText(vehicle)
    local maxspeed = (30.5*3.6)
    local mphspeed = math.ceil(speed*3.6)
	local fineamount = nil
	local finelevel = nil
	local truespeed = mphspeed
	local model = GetEntityModel(vehicle)
	local displaytext = GetDisplayNameFromVehicleModel(model)
    if mphspeed > maxspeed and driver == pP then
        Citizen.Wait(250)
        TriggerServerEvent('fineAmount2', mphspeed, maxspeed, plate)
	if truespeed >= 111 and truespeed <= 121 then
	fineamount = Config.Fine
	finelevel = '10mph Over Limit'
	end
	if truespeed >= 121 and truespeed <= 131 then
	fineamount = Config.Fine2
	finelevel = '20mph Over Limit'
	end
	if truespeed >= 131 and truespeed <= 141 then
	fineamount = Config.Fine3
	finelevel = '30mph Over Limit'
	end
	if truespeed >= 141 and truespeed <= 500 then
	fineamount = Config.Fine4
	finelevel = '40mph Over Limit'
	end
		if multado == false then
			multado = true
		StartScreenEffect('RaceTurbo',  0,  false)
		PlaySound(-1, "RACE_PLACED", "HUD_AWARDS", 0, 0, 1)
		Citizen.Wait(500)
        ESX.ShowNotification('~o~Radar Fixo\n~y~Carro: ~s~'..displaytext..'\n~y~Placa: ~s~'..plate..'\n~y~Vel. ~s~'..mphspeed..'KM/H\n~y~Valor: ~s~R$'.. fineamount)
		end
		
	Citizen.Wait(2500)
	multado = false
    end
end

