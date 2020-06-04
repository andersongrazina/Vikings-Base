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

ESX                             = nil
local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local BlipEntrarServico = nil
local playerInService = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
	
	ScriptLoaded()
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
	playerInService = false
	CreateBlip()
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	playerInService = false
	CreateBlip()
end)


function ScriptLoaded()
	Citizen.Wait(1000)
	LoadMarkers()
end

local AnimalPositions = {
	{x = 2400.59, y = 4776.54, z = 33.52},
	{x = 2409.87, y = 4769.22, z = 33.31},
	{x = 2416.68, y = 4762.98, z = 33.31},
	{x = 2425.58, y = 4752.58, z = 33.31},
	{x = 2433.53, y = 4745.22, z = 33.31},
	{x = 2441.42, y = 4735.44, z = 33.31},
	{x = 2431.68, y = 4802.47, z = 33.85},
	{x = 2442.42, y = 4792.73, z = 33.69},
	{x = 2442.43, y = 4792.92, z = 33.52},
	{x = 2449.2, y = 4786.3, z = 33.65},
	{x = 2457.07, y = 4777.64, z = 33.5},
	{x = 2464.76, y = 4769.91, z = 33.38},
	{x = 2473.53, y = 4760.21, z = 33.31},
	{x = 2494.32, y = 4762.84, z = 33.38},
	{x = 2505.63, y = 4752.01, z = 33.31},
	{x = 2510.41, y = 4745.43, z = 33.31},
	{x = 2517.47, y = 4737.75, z = 33.31},
	{x = 2485.56, y = 4699.81, z = 32.94},
	{x = 2460.15, y = 4710.9, z = 33.24},
	{x = 2465.88, y = 4705.12, z = 33.29},
}

local AnimalsInSession = {}

local Positions = {
	['StartHunting'] = { ['hint'] = '[E] Começar Ordenhar', ['x'] = 1426.65, ['y'] = 1109.93, ['z'] = 114.32 },
	['Sell'] = { ['hint'] = '[E] Sell', ['x'] = 969.16375732422, ['y'] = -2107.9033203125, ['z'] = 31.475671768188 },
	['SpawnATV'] = { ['x'] = 1417.89, ['y'] = 1117.75, ['z'] = 114.82 }
}

local OnGoingHuntSession = false
local HuntCar = nil

function LoadMarkers()
	LoadModel('a_c_cow')
	LoadAnimDict('amb@medic@standing@kneel@base')
	LoadAnimDict('anim@gangops@facility@servers@bodysearch@')
end

function CreateBlip()
	if PlayerData.job ~= nil and PlayerData.job.name == 'leiteiro' then
		if BlipEntrarServico == nil then
			BlipEntrarServico = AddBlipForCoord(Config.Zones.EntrarServico.Pos.x, Config.Zones.EntrarServico.Pos.y, Config.Zones.EntrarServico.Pos.z)
			SetBlipSprite(BlipEntrarServico, Config.Zones.EntrarServico.BlipSprite)
			SetBlipColour(BlipEntrarServico, Config.Zones.EntrarServico.BlipColor)
			SetBlipAsShortRange(BlipEntrarServico, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.Zones.EntrarServico.BlipName)
			EndTextCommandSetBlipName(BlipEntrarServico)
		end
	else
		if BlipEntrarServico ~= nil then
			RemoveBlip(BlipEntrarServico)
			BlipEntrarServico = nil
		end
	end

	if PlayerData.job ~= nil and PlayerData.job.name == 'leiteiro' and playerInService then
		BlipVender = AddBlipForCoord(Config.Zones.Vender.Pos.x, Config.Zones.Vender.Pos.y, Config.Zones.Vender.Pos.z)
		SetBlipSprite(BlipVender, Config.Zones.Vender.BlipSprite)
		SetBlipColour(BlipVender, Config.Zones.Vender.BlipColor)
		SetBlipAsShortRange(BlipVender, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Zones.Vender.BlipName)
		EndTextCommandSetBlipName(BlipVender)

	else
		if BlipVender ~= nil then
			RemoveBlip(BlipVender)
			BlipVender = nil
		end
	end
	
	if PlayerData.job ~= nil and PlayerData.job.name == 'leiteiro' and playerInService then
		BlipProcessar = AddBlipForCoord(Config.Zones.ProcessarLeite.Pos.x, Config.Zones.ProcessarLeite.Pos.y, Config.Zones.ProcessarLeite.Pos.z)
		SetBlipSprite(BlipProcessar, Config.Zones.ProcessarLeite.BlipSprite)
		SetBlipColour(BlipProcessar, Config.Zones.ProcessarLeite.BlipColor)
		SetBlipAsShortRange(BlipProcessar, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Zones.ProcessarLeite.BlipName)
		EndTextCommandSetBlipName(BlipProcessar)

	else
		if BlipProcessar ~= nil then
			RemoveBlip(BlipProcessar)
			BlipProcessar = nil
		end
	end
end

function OpenServiceMenu()
		local elements = {
			{label = 'Colocar Roupa(Uniforme)',  value = 'entrar_servico'},
			{label = 'Tirar Roupa(Uniforme)',   value = 'sair_servico'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'leiteiro_service_menu', {
			title    = 'Serviço',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			if data.current.value == 'entrar_servico' then
				menu.close()
					ESX.ShowNotification('~y~Você entrou em serviço!')
					playerInService = true
					CreateBlip()
					ComecarOrdenhar()
						local Male = GetHashKey("mp_m_freemode_01")
						TriggerEvent('skinchanger:getSkin', function(skin)
							if GetHashKey(GetEntityModel(GetPlayerPed(-1))) == Male then
								local clothesSkin = {
									['tshirt_1'] = 15, ['tshirt_2'] = 0,
									['torso_1'] = 1, ['torso_2'] = 0,
									['arms'] = 0,
									['pants_1'] = 90, ['pants_2'] = 0,
									['shoes_1'] = 51, ['shoes_2'] = 0,
								}
								TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)

							else
								local clothesSkin = {
									['tshirt_1'] = 15, ['tshirt_2'] = 0,
									['torso_1'] = 1, ['torso_2'] = 0,
									['arms'] = 0,
									['pants_1'] = 90, ['pants_2'] = 0,
									['shoes_1'] = 51, ['shoes_2'] = 0,
								}
								TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
							end
						end)
			elseif data.current.value == 'sair_servico' then
				menu.close()
				playerInService = false
				PararOrdenhar()
				ESX.ShowNotification('~y~Você saiu do serviço!')
				RemoveBlip(BlipVender)
				RemoveBlip(BlipProcessar)
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
						ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
							TriggerEvent('skinchanger:loadSkin', skin)
							TriggerEvent('esx:restoreLoadout')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
			end

		end, function(data, menu)
			menu.close()

			CurrentAction     = 'leiteiro_service_menu'
			CurrentActionMsg  = 'Pressione ~INPUT_CONTEXT~ para ~y~trocar de roupa.'
			CurrentActionData = {}
		end)
end

function ComecarOrdenhar()
	
	OnGoingHuntSession = true


		Citizen.CreateThread(function()

				
			for index, value in pairs(AnimalPositions) do
				local Animal = CreatePed(5, GetHashKey('a_c_cow'), value.x, value.y, value.z, 0.0, true, false)
				SetEntityAsMissionEntity(Animal, true, true)
				FreezeEntityPosition(Animal, true)
				SetPedFleeAttributes(Animal, 0, 0)
				--Blips

				local AnimalBlip = AddBlipForEntity(Animal)
				SetBlipSprite(AnimalBlip, 141)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString('Vacas - Ordenhar')
				EndTextCommandSetBlipName(AnimalBlip)


				table.insert(AnimalsInSession, {id = Animal, x = value.x, y = value.y, z = value.z, Blipid = AnimalBlip})
			end

			while OnGoingHuntSession do
				local sleep = 500
				for index, value in ipairs(AnimalsInSession) do
					if DoesEntityExist(value.id) then
						local AnimalCoords = GetEntityCoords(value.id)
						local PlyCoords = GetEntityCoords(PlayerPedId())
						local AnimalHealth = GetEntityHealth(value.id)
						
						local PlyToAnimal = GetDistanceBetweenCoords(PlyCoords, AnimalCoords, true)
							if PlyToAnimal < 2.0 then
								sleep = 5

								ESX.Game.Utils.DrawText3D({x = AnimalCoords.x, y = AnimalCoords.y, z = AnimalCoords.z + 1}, '[E] Ordenhar a Vaca!', 0.4)

								if IsControlJustReleased(0, Keys['E']) then
									ESX.TriggerServerCallback('esx_leiteirojob:getItemAmount', function(qtti)
										if qtti > 0 then
											if DoesEntityExist(value.id) then
												table.remove(AnimalsInSession, index)
												SlaughterAnimal(value.id)
											else
												ESX.ShowNotification('Não há vacas próximas!')
											end
										else
										ESX.ShowNotification("Você não tem um ~y~Balde~s~!")
										end
									end, 'bucket')
								end

							end
						end
					end
				

				Citizen.Wait(sleep)

			end
				
		end)
end


function PararOrdenhar()
		OnGoingHuntSession = false
		for index, value in ipairs(AnimalsInSession) do
			if DoesEntityExist(value.id) then
				DeleteEntity(value.id)
			end
		end
end

function SlaughterAnimal(AnimalId)

	TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	
	local coords  = GetEntityCoords(GetPlayerPed(-1))
									local forward = GetEntityForwardVector(GetPlayerPed(-1))
									local x, y, z = table.unpack(coords + forward * 1.0)

									ESX.Game.SpawnObject('prop_bucket_02a', {
										x = x,
										y = y,
										z = z
									}, function(obj)
										SetEntityHeading(obj, GetEntityHeading(GetPlayerPed(-1)))
										PlaceObjectOnGroundProperly(obj)								
									end)
		
	
	Citizen.Wait(5000)
	
	TaskPlayAnim(GetPlayerPed(-1), "amb@medic@standing@kneel@base" ,"base" ,8.0, -8.0, -1, 1, 0, false, false, false )
	TaskPlayAnim(GetPlayerPed(-1), "anim@gangops@facility@servers@bodysearch@" ,"player_search" ,8.0, -8.0, -1, 48, 0, false, false, false )
	
	Citizen.Wait(5000)
	
	local object = GetClosestObjectOfType(coords.x, coords.y, coords.z, 3.0, GetHashKey('prop_bucket_02a'), false, false, false)

	DeleteEntity(object)

	ClearPedTasksImmediately(PlayerPedId())
	
	local AnimalWeight = math.random(10, 160) / 10

	ESX.ShowNotification('Você ordenhou a vaca. Aguarde ~y~25 segundos~s~ para ~y~ordenhá-la~s~ novamente!')

	TriggerServerEvent('esx_leiteirojob:reward', AnimalWeight)

	local vacacoords = GetEntityCoords(AnimalId)
	
	Citizen.Wait(25000)

	table.insert(AnimalsInSession, {id = AnimalId, x = vacacoords.x, y = vacacoords.y, z = vacacoords.z, Blipid = AnimalBlip})
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'leiteiro' then
			local coords = GetEntityCoords(GetPlayerPed(-1))

			for k,v in pairs(Config.Zones) do
				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
	end
end)

AddEventHandler('esx_leiteirojob:hasEnteredMarker', function(zone)
	if zone == 'EntrarServico' then
		CurrentAction     = 'leiteiro_service_menu'
		CurrentActionMsg  = ('Pressione ~INPUT_CONTEXT~ para ~y~trocar de roupa.')
		CurrentActionData = {}
	elseif zone == 'Vender' then
		CurrentAction     = 'vender_leite'
		CurrentActionMsg  = ('Pressione ~INPUT_CONTEXT~ para vender ~y~leite.')
		CurrentActionData = {}
	elseif zone == 'ProcessarLeite' then
		CurrentAction     = 'processar_leite'
		CurrentActionMsg  = ('Pressione ~INPUT_CONTEXT~ para engarrafar o ~y~leite.')
		CurrentActionData = {}
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if PlayerData.job ~= nil and PlayerData.job.name == 'leiteiro' then

			local coords      = GetEntityCoords(GetPlayerPed(-1))
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
				TriggerEvent('esx_leiteirojob:hasEnteredMarker', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('esx_leiteirojob:hasExitedMarker', LastZone)
			end

		end
	end
end)

AddEventHandler('esx_leiteirojob:hasExitedMarker', function(zone)
	if zone == 'Vender' then
		TriggerServerEvent('esx_leiteirojob:stopSell')
	elseif zone == 'ProcessarLeite' then
		TriggerServerEvent('esx_leiteirojob:stopProcess')
	end
	
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'leiteiro' then

			if CurrentAction == 'leiteiro_service_menu' then
				OpenServiceMenu()
			elseif CurrentAction == 'vender_leite' then
				if playerInService then
				TriggerServerEvent('esx_leiteirojob:startSell')
				else
				ESX.ShowNotification('Você não está em serviço!')
				end
			elseif CurrentAction == 'processar_leite' then
				if playerInService then
				TriggerServerEvent('esx_leiteirojob:startProcess')
				else
				ESX.ShowNotification('Você não está em serviço!')
				end
			end
			end
		end
	end
end)

AddEventHandler('esx:onPlayerDeath', function()
	IsDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	IsDead = false
end)

function LoadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Citizen.Wait(10)
    end    
end

function LoadModel(model)
    while not HasModelLoaded(model) do
          RequestModel(model)
          Citizen.Wait(10)
    end
end

function DrawM(hint, type, x, y, z)
	ESX.Game.Utils.DrawText3D({x = x, y = y, z = z + 1.0}, hint, 0.4)
	DrawMarker(type, x, y, z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 255, 255, 100, false, true, 2, false, false, false, false)
end