local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                           = nil
local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local Blips                   = {}
local carros = false
local quimicos = false
local vinho = false
local carne = false
local cameras = false
local documentos = false
local frango = false
local militar = false
local petroleo = false
local leite = false
local open = false
local carga = false
local coords = GetEntityCoords(PlayerPedId())
local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
local modelo = GetEntityModel(vehicle)
local classe  = GetVehicleClassFromName(vehicle)
local displaytext = GetDisplayNameFromVehicleModel(modelo)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	CreateBlip()
end)


RegisterCommand('cancelarentrega', function()
	local playerPed = GetPlayerPed(-1)
	local vehicle          = GetVehiclePedIsIn(playerPed, false)
	if IsPedInAnyVehicle(playerPed, false) then
		local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(vehicle, CarTrailer)
		local carros = false
		local quimicos = false
		local vinho = false
		local carne = false
		local cameras = false
		local documentos = false
		local frango = false
		local militar = false
		local petroleo = false
		local leite = false
		local open = false
		local carga = false
		DetachVehicleFromTrailer(veiculo)
		RemoveBlip(CurrentBlip)
		Citizen.Wait(750)
		ESX.Game.DeleteVehicle(CarTrailer)
		ESX.ShowNotification('Sua entrega foi cancelada!')
	else
		ESX.ShowNotification('~r~Você não está em um veículo!')
	end	
end)


AddEventHandler('esx_caminhoneirojob:hasEnteredMarker', function(zone)
	if zone == 'CaminhoneiroActions' then
		CurrentAction     = 'caminhoneiro_actions_menu'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para ~y~abrir o menu~s~ de Cargas.'
		CurrentActionData = {}
	elseif
		zone == 'SpawnTrailer' then
		CurrentAction     = 'spawn_trailer_menu'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para ~y~Pegar a~s~ Carga.'
		CurrentActionData = {}
	elseif
		zone == 'EntregarCarga' then
		CurrentAction     = 'entregar_trailer_menu'
		CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para ~y~Entregar~s~ a Carga.'
		CurrentActionData = {}
	end
end)

AddEventHandler('esx_caminhoneirojob:hasExitedMarker', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)


-- Create Blips
function CreateBlip()
	if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' then
		local blip = AddBlipForCoord(Config.Zones.CaminhoneiroActions.Pos.x, Config.Zones.CaminhoneiroActions.Pos.y, Config.Zones.CaminhoneiroActions.Pos.z)

		SetBlipSprite (blip, 318)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipColour (blip, 5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Cargas - Caminhoneiro")
		EndTextCommandSetBlipName(blip)
	end
end

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' then
			local coords = GetEntityCoords(PlayerPedId())

			for k,v in pairs(Config.Zones) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
				isInMarker  = true
				currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('esx_caminhoneirojob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_caminhoneirojob:hasExitedMarker', LastZone)
			end

		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' then

				if CurrentAction == 'caminhoneiro_actions_menu' then
					ESX.TriggerServerCallback('esx_license:checkLicense', function(hasCommercialLicense)
							if hasCommercialLicense then
								open = true
								SetNuiFocus( true, true )
								SendNUIMessage({
									action = "open"
								})
							else
								ESX.ShowNotification('Você não possui Carteira de motorista de caminhão, portanto não poderá pegar cargas!')
							end
						end, GetPlayerServerId(PlayerId()), 'drive_truck')
				elseif CurrentAction == 'spawn_trailer_menu' then
					if IsPedInAnyVehicle(GetPlayerPed(-1)) then
							SpawnVehicle('trailers3')
							carga = true
							Citizen.Wait(1000)
								if carga == true then
									ESX.ShowNotification('A Carga está indicada no GPS. Passe na cabine para pegar o endereço de entrega!')
								else
									ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
								end
					else
						ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
					end
				elseif CurrentAction == 'entregar_trailer_menu' then
					DetachVehicleFromTrailer(vehicle)
					Citizen.Wait(2000)
					ESX.Game.DeleteVehicle(vehTrailer)
				end
				CurrentAction = nil
			end
		end
	end
end)


function SpawnVehicle(request, xvehicle, yvehicle, zvehicle, hvehicle)
			local hash = GetHashKey(request)

			RequestModel(hash)

			while not HasModelLoaded(hash) do
				RequestModel(hash)
				Citizen.Wait(0)
			end

			local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
			local vehicle = CreateVehicle(hash, xvehicle, yvehicle, zvehicle, hvehicle, true, false)
			local BlipCar = AddBlipForEntity(vehicle)
				SetBlipSprite(BlipCar, 479)
				SetBlipScale(BlipCar, 0.8)
			SetVehicleDoorsLocked(vehicle, 1)
			CarPlate = (' CARGAS ')
			SetVehicleNumberPlateText(vehicle, CarPlate)
end

RegisterNUICallback('LEITE', function(data, cb)
		
		local xempresa = 460.5 
		local yempresa = -1946.11
		local zempresa = 23.66
		
		local xentrega = 2552.42
		local yentrega = 4672.93
		local zentrega = 32.94
		
		leite = true
		
		local blipleite = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipleite, 569)
		SetBlipDisplay(blipleite, 4)
		SetBlipScale  (blipleite, 1.0)
		SetBlipAsShortRange(blipleite, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Leite')
		EndTextCommandSetBlipName(blipleite)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and leite == true then
						local coords = GetEntityCoords(PlayerPedId())
						local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) and leite == true and carga == false then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and leite == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('trailers2', 500.02, -1972.3, 24.93, 122.83)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipleite, 569)
															SetBlipDisplay(blipleite, 4)
															SetBlipScale  (blipleite, 1.0)
															SetBlipAsShortRange(blipleite, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Leite')
															EndTextCommandSetBlipName(blipleite)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
													end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and leite == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and leite == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 1400, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														leite = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('CARNE', function(data, cb)
		
		local xempresa = 2321.37 
		local yempresa = 4926.29
		local zempresa = 40.41
		
		local xentrega = 945.86
		local yentrega = -2184.21
		local zentrega = 29.56
		
		carne = true
		
		local blipcarne = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipcarne, 569)
		SetBlipDisplay(blipcarne, 4)
		SetBlipScale  (blipcarne, 1.0)
		SetBlipAsShortRange(blipcarne, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Carne')
		EndTextCommandSetBlipName(blipcarne)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and carne == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and carne == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('trailers2', 2301.19, 4885.96, 41.82, 44.78)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipcarne, 569)
															SetBlipDisplay(blipcarne, 4)
															SetBlipScale  (blipcarne, 1.0)
															SetBlipAsShortRange(blipcarne, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Carne')
															EndTextCommandSetBlipName(blipcarne)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
													end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and carne == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and carne == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 1500, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														carne = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('PETROLEO', function(data, cb)
		
		local xempresa = 1724.17 
		local yempresa = -1615.27
		local zempresa = 111.47
		
		local xentrega = 2726.03
		local yentrega = 1411.83
		local zentrega = 23.43
		
		petroleo = true
		
		local blippetroleo = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blippetroleo, 569)
		SetBlipDisplay(blippetroleo, 4)
		SetBlipScale  (blippetroleo, 1.0)
		SetBlipAsShortRange(blippetroleo, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Petróleo')
		EndTextCommandSetBlipName(blippetroleo)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and petroleo == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) and petroleo == true and carga == false then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and petroleo == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('tanker', 1739.87, -1539.85, 112.7, 250.81)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blippetroleo, 569)
															SetBlipDisplay(blippetroleo, 4)
															SetBlipScale  (blippetroleo, 1.0)
															SetBlipAsShortRange(blippetroleo, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Petróleo')
															EndTextCommandSetBlipName(blippetroleo)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and petroleo == true and carga == true  then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and petroleo == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 1300, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														petroleo = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('VINHO', function(data, cb)
		
		local xempresa = -1878.29
		local yempresa = 2040.03
		local zempresa = 139.52
		
		local xentrega = -549.56
		local yentrega = 301.7
		local zentrega = 82.08
		
		vinho = true
		
		local blipvinho = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipvinho, 569)
		SetBlipDisplay(blipvinho, 4)
		SetBlipScale  (blipvinho, 1.0)
		SetBlipAsShortRange(blipvinho, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Vinho')
		EndTextCommandSetBlipName(blipvinho)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and vinho == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and vinho == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('trailers2', -1913.68, 2042.83, 139.75, 263.93)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipvinho, 569)
															SetBlipDisplay(blipvinho, 4)
															SetBlipScale  (blipvinho, 1.0)
															SetBlipAsShortRange(blipvinho, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Produtos Quimicos')
															EndTextCommandSetBlipName(blipvinho)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and vinho == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and vinho == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:successFragil', 1550, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														vinho = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('QUIMICOS', function(data, cb)
		
		local xempresa = 3430.83 
		local yempresa = 3759.98
		local zempresa = 29.51
		
		local xentrega = -2359.42
		local yentrega = 282.25
		local zentrega = 166.68
		
		quimicos = true
		
		local blipquimicos = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipquimicos, 569)
		SetBlipDisplay(blipquimicos, 4)
		SetBlipScale  (blipquimicos, 1.0)
		SetBlipAsShortRange(blipquimicos, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Produtos Quimicos')
		EndTextCommandSetBlipName(blipquimicos)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and quimicos == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) and quimicos == true and carga == false then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and quimicos == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('trailers', 3634.23, 3764.69, 28.52, 93.57)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipquimicos, 569)
															SetBlipDisplay(blipquimicos, 4)
															SetBlipScale  (blipquimicos, 1.0)
															SetBlipAsShortRange(blipquimicos, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Produtos Quimicos')
															EndTextCommandSetBlipName(blipquimicos)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and quimicos == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and quimicos == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:successFragil', 1780, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														quimicos = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('MILITAR', function(data, cb)
		
		local xempresa = 479.18
		local yempresa = -3107.81
		local zempresa = 5.08
		
		local xentrega = -2238.97
		local yentrega = 3272.91
		local zentrega = 31.82
		
		militar = true
		
		local blipmilitar = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipmilitar, 569)
		SetBlipDisplay(blipmilitar, 4)
		SetBlipScale  (blipmilitar, 1.0)
		SetBlipAsShortRange(blipmilitar, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa Militar')
		EndTextCommandSetBlipName(blipmilitar)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and militar == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and militar == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
														SpawnVehicle('armytrailer', 484.18, -3353.11, 5.08, 265.53)
														carga = true
														Citizen.Wait(1000)
															if carga == true then
																ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
																CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
																SetBlipSprite (blipmilitar, 569)
																SetBlipDisplay(blipmilitar, 4)
																SetBlipScale  (blipmilitar, 1.0)
																SetBlipAsShortRange(blipmilitar, true)
																BeginTextCommandSetBlipName("STRING")
																AddTextComponentString('Entrega Militar')
																EndTextCommandSetBlipName(blipmilitar)
																SetBlipRoute(CurrentBlip, 1)
															else
																ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
															end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and militar == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and militar == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 1850, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														militar = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('ROUPAS', function(data, cb)
		
		local xempresa = 1087.48
		local yempresa = -3323.11
		local zempresa = 4.93
		
		local xentrega = -236.38
		local yentrega = -269.9
		local zentrega = 48.08
		
		roupas = true
		
		local bliproupas = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (bliproupas, 569)
		SetBlipDisplay(bliproupas, 4)
		SetBlipScale  (bliproupas, 1.0)
		SetBlipAsShortRange(bliproupas, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Roupas')
		EndTextCommandSetBlipName(bliproupas)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and roupas == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and roupas == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('tvtrailer', 1201.43, -3186.9, 4.99, 181.73)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (bliproupas, 569)
															SetBlipDisplay(bliproupas, 4)
															SetBlipScale  (bliproupas, 1.0)
															SetBlipAsShortRange(bliproupas, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Roupas')
															EndTextCommandSetBlipName(bliproupas)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and roupas == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and roupas == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 1285, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														roupas = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('FRANGO', function(data, cb)
		
		local xempresa = -38.13
		local yempresa = 6284.44
		local zempresa = 30.23
		
		local xentrega = -574.63
		local yentrega = -876.47
		local zentrega = 24.71
		
		frango = true
		
		local blipmadeira = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipmadeira, 569)
		SetBlipDisplay(blipmadeira, 4)
		SetBlipScale  (blipmadeira, 1.0)
		SetBlipAsShortRange(blipmadeira, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Frango')
		EndTextCommandSetBlipName(blipmadeira)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and frango == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and frango == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('trailers2', 22.75, 6285.05, 30.25, 121.42)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipfrango, 569)
															SetBlipDisplay(blipfrango, 4)
															SetBlipScale  (blipfrango, 1.0)
															SetBlipAsShortRange(blipfrango, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Frango')
															EndTextCommandSetBlipName(blipfrango)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and frango == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and frango == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 2150, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														frango = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('CAMERAS', function(data, cb)
		
		local xempresa = 884.83
		local yempresa = -1217.9
		local zempresa = 24.61
		
		local xentrega = 2493.94
		local yentrega = -445.24
		local zentrega = 92.0
		
		cameras = true
		
		local blipcameras = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipcameras, 569)
		SetBlipDisplay(blipcameras, 4)
		SetBlipScale  (blipcameras, 1.0)
		SetBlipAsShortRange(blipcameras, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Câmeras')
		EndTextCommandSetBlipName(blipcameras)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and cameras == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and cameras == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('trailers', 913.16, -1259.91, 24.58, 34.39)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipcameras, 569)
															SetBlipDisplay(blipcameras, 4)
															SetBlipScale  (blipcameras, 1.0)
															SetBlipAsShortRange(blipcameras, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Câmeras')
															EndTextCommandSetBlipName(blipcameras)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and cameras == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and cameras == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 1450, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														cameras = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('DOCUMENTOS', function(data, cb)
		
		local xempresa = -2325.31
		local yempresa = 3268.31
		local zempresa = 31.84
		
		local xentrega = 2450.95
		local yentrega = -397.25
		local zentrega = 92.0
		
		documentos = true
		
		local blipdocumentos = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipdocumentos, 569)
		SetBlipDisplay(blipdocumentos, 4)
		SetBlipScale  (blipdocumentos, 1.0)
		SetBlipAsShortRange(blipdocumentos, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Documentos')
		EndTextCommandSetBlipName(blipdocumentos)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and documentos == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and documentos == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('trailers', -2344.94,3245.96, 31.84, 325.38)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipdocumentos, 569)
															SetBlipDisplay(blipdocumentos, 4)
															SetBlipScale  (blipdocumentos, 1.0)
															SetBlipAsShortRange(blipdocumentos, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Documentos')
															EndTextCommandSetBlipName(blipdocumentos)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and documentos == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and documentos == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 1550, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														documentos = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
				documentos = false 
				carga = false
			end)
		
		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('MADEIRA', function(data, cb)
		
		local xempresa = -847.57
		local yempresa = 5412.18
		local zempresa = 33.75
		
		local xentrega = 1202.42
		local yentrega = -1315.89
		local zentrega = 34.24
		
		madeira = true
		
		local blipmadeira = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipmadeira, 569)
		SetBlipDisplay(blipmadeira, 4)
		SetBlipScale  (blipmadeira, 1.0)
		SetBlipAsShortRange(blipmadeira, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Madeira')
		EndTextCommandSetBlipName(blipmadeira)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and madeira == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and madeira == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('trailerlogs', -547.0, 5377.61, 69.54, 62.71)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipmadeira, 569)
															SetBlipDisplay(blipmadeira, 4)
															SetBlipScale  (blipmadeira, 1.0)
															SetBlipAsShortRange(blipmadeira, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Madeira')
															EndTextCommandSetBlipName(blipmadeira)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and madeira == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and madeira == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:success', 2750, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														madeira = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('CARROS', function(data, cb)
		
		local xempresa = 1088.06
		local yempresa = -3329.72
		local zempresa = 4.93
		
		local xentrega = -15.12
		local yentrega = -1096.73
		local zentrega = 25.68
		
		carros = true
		
		local blipcarros = AddBlipForCoord(xempresa, yempresa, zempresa)

		SetBlipSprite (blipcarros, 569)
		SetBlipDisplay(blipcarros, 4)
		SetBlipScale  (blipcarros, 1.0)
		SetBlipAsShortRange(blipcarros, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Empresa de Carros')
		EndTextCommandSetBlipName(blipcarros)
			
		SetNewWaypoint(xempresa, yempresa)
		
		ESX.ShowNotification('A empresa foi indicada no seu GPS. Vá até ela para pegar a carga!')
		
			Citizen.CreateThread(function()
				while true do
					Citizen.Wait(10)
					if PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and carros == true then
						local coords = GetEntityCoords(PlayerPedId())

							if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < Config.DrawDistance) then
								DrawMarker(1, xempresa, yempresa, zempresa, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
									if(GetDistanceBetweenCoords(coords, xempresa, yempresa, zempresa, true) < 3.5) then
										ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para pegar a carga.')
											if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and carros == true and carga == false then
												if IsPedInAnyVehicle(GetPlayerPed(-1)) then
													SpawnVehicle('tr4', 1201.01, -3234.15, 5.50, 10.54)
													carga = true
													Citizen.Wait(1000)
														if carga == true then
															ESX.ShowNotification('A Carga está indicada no GPS. E o Enderço da entrega foi informado no seu mapa!')
															CurrentBlip = AddBlipForCoord(xentrega, yentrega, zentrega)
															SetBlipSprite (blipcarros, 569)
															SetBlipDisplay(blipcarros, 4)
															SetBlipScale  (blipcarros, 1.0)
															SetBlipAsShortRange(blipcarros, true)
															BeginTextCommandSetBlipName("STRING")
															AddTextComponentString('Entrega de Carros')
															EndTextCommandSetBlipName(blipcarros)
															SetBlipRoute(CurrentBlip, 1)
														else
															ESX.ShowNotification('Você não trabalho disponível conosco, solicite uma de nossas cargas primeiro!')
														end
												else
													ESX.ShowNotification("Você não está em um ~r~caminhão~s~!")
												end
											end
										end
							end
							if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < Config.DrawDistance) and carros == true and carga == true then
									DrawMarker(1, xentrega, yentrega, zentrega, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.5, 3.5, 1.25, 204, 204, 0, 100, false, true, 2, false, false, false, false)
										if(GetDistanceBetweenCoords(coords, xentrega, yentrega, zentrega, true) < 3.5) then
											ESX.ShowHelpNotification('Pressione ~INPUT_CONTEXT~ para entregar a carga.')
												if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'caminhoneiro' and carros == true and carga == true then
												local veiculo = GetVehiclePedIsIn(GetPlayerPed(-1), false)
												local TemTrailer, CarTrailer = GetVehicleTrailerVehicle(veiculo, CarTrailer)
												local VidaCarga = GetVehicleBodyHealth(CarTrailer)
												local plate = GetVehicleNumberPlateText(CarTrailer)
													if plate == " CARGAS " then
														if VidaCarga > 0 then
														Citizen.Wait(1250)
														DetachVehicleFromTrailer(veiculo)
														RemoveBlip(CurrentBlip)
														Citizen.Wait(1250)
														TriggerServerEvent('esx_caminhoneirojob:successFragil', 1210, VidaCarga)
														ESX.Game.DeleteVehicle(CarTrailer)
														carros = false 
														carga = false
														end
													else
														ESX.ShowNotification('Está carga não pertence a nossa empresa!')
													end
												end
										end
							end
					end
				end
				carros = false 
				carga = false
			end)

		SetNuiFocus(false, false)
		SendNUIMessage({
			action = "close"
		})
  	cb('ok')
end)

RegisterNUICallback('escape', function(data, cb)
	SetNuiFocus(false, false)
	SendNUIMessage({
		action = "close"
	})
	open = false
	cb('ok')
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)
