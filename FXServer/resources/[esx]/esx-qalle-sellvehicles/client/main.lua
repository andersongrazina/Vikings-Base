ESX = nil

PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

        TriggerEvent("esx:getSharedObject", function(response)
            ESX = response
        end)
    end

    if ESX.IsPlayerLoaded() then
		PlayerData = ESX.GetPlayerData()

		RemoveVehicles()

		Citizen.Wait(500)

		LoadSellPlace()

		SpawnVehicles()
    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	PlayerData = response
	
	LoadSellPlace()

	SpawnVehicles()
end)

RegisterNetEvent("esx-qalle-sellvehicles:refreshVehicles")
AddEventHandler("esx-qalle-sellvehicles:refreshVehicles", function()
	RemoveVehicles()

	Citizen.Wait(500)

	SpawnVehicles()
end)

function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local p = GetGameplayCamCoords()
    local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov
    if onScreen then
        SetTextScale(0.0*scale, 0.6*scale)
        SetTextFont(0)
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

function LoadSellPlace()
	Citizen.CreateThread(function()

		local SellPos = Config.SellPosition

		local Blip = AddBlipForCoord(SellPos["x"], SellPos["y"], SellPos["z"])
		SetBlipSprite (Blip, 384)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 1.0)
		SetBlipColour (Blip, 69)
		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Feirão de Carros Usados")
		EndTextCommandSetBlipName(Blip)

		while true do
			local sleepThread = 500

			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)

			local dstCheck = GetDistanceBetweenCoords(pedCoords, SellPos["x"], SellPos["y"], SellPos["z"], true)

			if dstCheck <= 25.0 then
				DrawMarker(27, SellPos["x"], SellPos["y"], SellPos["z"], 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 50, 50, 149, 255, 0, 0, 0, 1)
			DrawMarker(36, SellPos["x"], SellPos["y"], SellPos["z"], 0, 0, 0, 0, 0, 0, 1.15, 1.15, 1.0, 50, 50, 149, 255, 0, 1, 0, 0)
				sleepThread = 5

				if dstCheck <= 1.2 then
					ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para colocar seu ~b~veículo~s~ à ~y~venda~s~!')
					if IsControlJustPressed(0, 38) then
						if IsPedInAnyVehicle(ped, false) then
							OpenSellMenu(GetVehiclePedIsUsing(ped))
						else
							ESX.ShowNotification("Você deve estar dentro de um veículo!")
						end
					end
				end
			end

			for i = 1, #Config.VehiclePositions, 1 do
				if Config.VehiclePositions[i]["entityId"] ~= nil then
					local pedCoords = GetEntityCoords(ped)
					local vehCoords = GetEntityCoords(Config.VehiclePositions[i]["entityId"])

					local dstCheck = GetDistanceBetweenCoords(pedCoords, vehCoords, true)

					if dstCheck <= 7.5 then
						sleepThread = 5
			
						Draw3DText(vehCoords.x, vehCoords.y, vehCoords.z+1.7, tostring("~y~Valor:~s~ ~g~R$ ".. Config.VehiclePositions[i]["price"]))
						if dstCheck <= 2.0 then
							ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para ~y~comprar o veículo~s~!')
						end

						if IsControlJustPressed(0, 38) then
							if IsPedInVehicle(ped, Config.VehiclePositions[i]["entityId"], false) then
								OpenSellMenu(Config.VehiclePositions[i]["entityId"], Config.VehiclePositions[i]["price"], true, Config.VehiclePositions[i]["owner"])
							else
								ESX.ShowNotification("Você deve estar dentro de um veículo!")
							end
						end
					end
				end
			end

			Citizen.Wait(sleepThread)
		end
	end)
end

function OpenSellMenu(veh, price, buyVehicle, owner)
	local elements = {}

	if not buyVehicle then
		if price ~= nil then
			table.insert(elements, { ["label"] = "Alterar Valor: R$ " .. price .. "", ["value"] = "price" })
			table.insert(elements, { ["label"] = "Colocar Veículo à Venda", ["value"] = "sell" })
		else
			table.insert(elements, { ["label"] = "Valor de Venda", ["value"] = "price" })
		end
	else
		table.insert(elements, { ["label"] = "Comprar: R$ " .. price .. "", ["value"] = "buy" })

		if owner then
			table.insert(elements, { ["label"] = "Retirar veículo", ["value"] = "remove" })
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_veh',
		{
			title    = "Vehicle Menu",
			align    = 'top-right',
			elements = elements
		},
	function(data, menu)
		local action = data.current.value

		if action == "price" then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_veh_price',
				{
					title = "Preço do veículo"
				},
			function(data2, menu2)

				local vehPrice = tonumber(data2.value)

				menu2.close()
				menu.close()

				OpenSellMenu(veh, vehPrice)
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "sell" then
			local vehProps = ESX.Game.GetVehicleProperties(veh)

			ESX.TriggerServerCallback("esx-qalle-sellvehicles:isVehicleValid", function(valid)

				if valid then
					DeleteVehicle(veh)
					ESX.ShowNotification("Você colocou o ~g~veículo~s~ à venda por ~y~R$" .. price .. "~s~!")
					menu.close()
				else
					ESX.ShowNotification("Você precisa ser o ~r~dono~s~ do ~g~veículo~s~!")
				end
	
			end, vehProps, price)
		elseif action == "buy" then
			ESX.TriggerServerCallback("esx-qalle-sellvehicles:buyVehicle", function(isPurchasable, totalMoney)
				if isPurchasable then
					DeleteVehicle(veh)
					ESX.ShowNotification("Você ~g~comprou~s~ o veículo por ~y~R$" .. price .. "~s~!")
					menu.close()
				else
					ESX.ShowNotification("Você ~r~não tem dinheiro suficente~s~, faltam R$" .. price - totalMoney .. "~s~!")
				end
			end, ESX.Game.GetVehicleProperties(veh), price)
		elseif action == "remove" then
			ESX.TriggerServerCallback("esx-qalle-sellvehicles:buyVehicle", function(isPurchasable, totalMoney)
				if isPurchasable then
					DeleteVehicle(veh)
					ESX.ShowNotification("Você removeu o veículo")
					menu.close()
				end
			end, ESX.Game.GetVehicleProperties(veh), 0)
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function RemoveVehicles()
	local VehPos = Config.VehiclePositions

	for i = 1, #VehPos, 1 do
		local veh, distance = ESX.Game.GetClosestVehicle(VehPos[i])

		if DoesEntityExist(veh) and distance <= 1.0 then
			DeleteEntity(veh)
		end
	end
end

function SpawnVehicles()
	local VehPos = Config.VehiclePositions

	ESX.TriggerServerCallback("esx-qalle-sellvehicles:retrieveVehicles", function(vehicles)
		for i = 1, #vehicles, 1 do

			local vehicleProps = vehicles[i]["vehProps"]

			LoadModel(vehicleProps["model"])

			VehPos[i]["entityId"] = CreateVehicle(vehicleProps["model"], VehPos[i]["x"], VehPos[i]["y"], VehPos[i]["z"] - 0.975, VehPos[i]["h"], false)
			VehPos[i]["price"] = vehicles[i]["price"]
			VehPos[i]["owner"] = vehicles[i]["owner"]

			ESX.Game.SetVehicleProperties(VehPos[i]["entityId"], vehicleProps)

			FreezeEntityPosition(VehPos[i]["entityId"], true)

			SetEntityAsMissionEntity(VehPos[i]["entityId"], true, true)
			SetModelAsNoLongerNeeded(vehicleProps["model"])
		end
	end)

end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)

		Citizen.Wait(1)
	end
end
