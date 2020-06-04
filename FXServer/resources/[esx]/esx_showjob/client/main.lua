PlayerData                = {}

ESX                             = nil

local id = GetPlayerServerId(PlayerId())

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

Citizen.CreateThread(function()
	Citizen.Wait(2000)
	while true do
		Citizen.Wait(1)
			if IsControlPressed(0, 10) then
				Show()
				 ShowId()
			end
	end
end)

function Show()
		SetTextFont(1)
		SetTextProportional(1)
		SetTextScale(0.5, 0.5)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString('~y~Trabalho: ~s~' .. PlayerData.job.label .. " - " .. PlayerData.job.grade_label..'\n~y~Dinheiro Carteira: ~s~R$ '..PlayerData.money)
		DrawText(0.17, 0.83)
end

function ShowId()
		SetTextFont(1)
		SetTextProportional(1)
		SetTextScale(0.5, 0.5)
		SetTextDropshadow(1, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString('~y~Seu ID:~s~ '..id)
		DrawText(0.17, 0.90)
end
