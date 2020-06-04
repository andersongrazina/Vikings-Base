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

ESX                  = nil
local FirstSpawn     = true
local LastSkin       = nil
local PlayerLoaded   = false
local cam            = nil
local isCameraActive = false
local zoomOffset     = 0.0
local camOffset      = 0.0
local heading        = 90.0

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenMenu(submitCb, cancelCb, restrict)
	local playerPed = PlayerPedId()

	TriggerEvent('skinchanger:getSkin', function(skin)
		LastSkin = skin
	end)

	TriggerEvent('skinchanger:getData', function(components, maxVals)
		local elements    = {}
		local _components = {}

		-- Restrict menu
		if restrict == nil then
			for i=1, #components, 1 do
				_components[i] = components[i]
			end
		else
			for i=1, #components, 1 do
				local found = false

				for j=1, #restrict, 1 do
					if components[i].name == restrict[j] then
						found = true
					end
				end

				if found then
					table.insert(_components, components[i])
				end
			end
		end

		-- Insert elements
		for i=1, #_components, 1 do
			local value       = _components[i].value
			local componentId = _components[i].componentId

			if componentId == 0 then
				value = GetPedPropIndex(playerPed, _components[i].componentId)
			end

			local data = {
				label     = _components[i].label,
				name      = _components[i].name,
				value     = value,
				min       = _components[i].min,
				textureof = _components[i].textureof,
				zoomOffset= _components[i].zoomOffset,
				camOffset = _components[i].camOffset,
				type      = 'slider'
			}

			for k,v in pairs(maxVals) do
				if k == _components[i].name then
					data.max = v
					break
				end
			end

			table.insert(elements, data)
		end

		CreateSkinCam()
		zoomOffset = _components[1].zoomOffset
		camOffset = _components[1].camOffset

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin', {
			title    = 'Criação de Personagem',
			align    = 'top-left',
			elements = elements
		}, function(data, menu)
			TriggerEvent('skinchanger:getSkin', function(skin)
				LastSkin = skin
			end)

			submitCb(data, menu)
			DeleteSkinCam()
		end, function(data, menu)
			menu.close()
			DeleteSkinCam()
			TriggerEvent('skinchanger:loadSkin', LastSkin)

			if cancelCb ~= nil then
				cancelCb(data, menu)
			end
		end, function(data, menu)
			TriggerEvent('skinchanger:getSkin', function(skin)
				zoomOffset = data.current.zoomOffset
				camOffset = data.current.camOffset

				if skin[data.current.name] ~= data.current.value then
					-- Change skin element
					TriggerEvent('skinchanger:change', data.current.name, data.current.value)

					-- Update max values
					TriggerEvent('skinchanger:getData', function(components, maxVals)
						for i=1, #elements, 1 do
							local newData = {}

							newData.max = maxVals[elements[i].name]

							if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
								newData.value = 0
							end

							menu.update({name = elements[i].name}, newData)
						end

						menu.refresh()
					end)
				end
			end)
		end, function(data, menu)
			DeleteSkinCam()
		end)
	end)
end

function CreateSkinCam()
	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
	end

	SetCamActive(cam, true)
	RenderScriptCams(true, true, 500, true, true)

	isCameraActive = true
	SetCamRot(cam, 0.0, 0.0, 270.0, true)
	SetEntityHeading(playerPed, 90.0)
end

function DeleteSkinCam()
	isCameraActive = false
	SetCamActive(cam, false)
	RenderScriptCams(false, true, 500, true, true)
	cam = nil
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isCameraActive then
			DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)
			DisableControlAction(0, 25, true) -- Input Aim
			DisableControlAction(0, 24, true) -- Input Attack

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)

			local angle = heading * math.pi / 180.0
			local theta = {
				x = math.cos(angle),
				y = math.sin(angle)
			}

			local pos = {
				x = coords.x + (zoomOffset * theta.x),
				y = coords.y + (zoomOffset * theta.y)
			}

			local angleToLook = heading - 140.0
			if angleToLook > 360 then
				angleToLook = angleToLook - 360
			elseif angleToLook < 0 then
				angleToLook = angleToLook + 360
			end

			angleToLook = angleToLook * math.pi / 180.0
			local thetaToLook = {
				x = math.cos(angleToLook),
				y = math.sin(angleToLook)
			}

			local posToLook = {
				x = coords.x + (zoomOffset * thetaToLook.x),
				y = coords.y + (zoomOffset * thetaToLook.y)
			}

			SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
			PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)
			
			ESX.ShowHelpNotification(_U('use_rotate_view'))
		else
			Citizen.Wait(500)
		end
	end
end)

Citizen.CreateThread(function()
	local angle = 90

	while true do
		Citizen.Wait(0)

		if isCameraActive then
			if IsControlPressed(0, Keys['N4']) then
				angle = angle - 1
			elseif IsControlPressed(0, 109) then
				angle = angle + 1
			end

			if angle > 360 then
				angle = angle - 360
			elseif angle < 0 then
				angle = angle + 360
			end

			heading = angle + 0.0
		else
			Citizen.Wait(500)
		end
	end
end)

function OpenSaveableMenu(submitCb, cancelCb, restrict)
	TriggerEvent('skinchanger:getSkin', function(skin)
		LastSkin = skin
	end)

	OpenMenu(function(data, menu)
		menu.close()
		DeleteSkinCam()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm',
		{
			title = 'Deseja confirmar a criação de personagem?',
			align = 'top-left',
			elements = {
				{label = 'Não', value = 'no'},
				{label = 'Sim', value = 'yes'}
			}
		}, function(data2, menu2)
			menu2.close()
			if data2.current.value == 'yes' then
					TriggerEvent('skinchanger:getSkin', function(skin)
					TriggerServerEvent('esx_skin:save', skin)
					
					if submitCb ~= nil then
						submitCb(data, menu)
					end
				end, cancelCb, restrict)
				TriggerServerEvent('esx_skin:darCelular')
			elseif data2.current.value == 'no' then
				ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
					TriggerEvent('skinchanger:loadSkin', skin)
				end)
				OpenSaveableMenu(submitCb, cancelCb, restrict)
			end
		end, function(data2, menu2)
		menu2.close()
		end)
	end, function(data, menu)
	menu.close()
	end)
end

function DrawSpecialText(m_text, showtime)
	SetTextEntry_2("STRING")
	AddTextComponentString(m_text)
	DrawSubtitleTimed(showtime, 1)
end
--[[
function TutorialFunction() -- Tutorial Menu and Majic ( DO NOT EDIT UNLESS YOU KNOW WHAT YOU ARE DOING )

    local elements = {
        { label = 'Sim', value = "basic_tutorial" },
		{ label = 'Não', value = "no" }
    }

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'civtutorial_menu',
        {
            title    = "<font color='lightblue' font-size='15px'>Deseja ver o Tutorial</font>",
            align    = 'center',
            elements = elements
        },
    function(data, menu)
		menu.close()

        local action = data.current.value

    if action == "basic_tutorial" then
       local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    TriggerEvent('chat:clear')  --- Clear current chat
    TriggerEvent('chat:toggleChat') --- Toggle chat chat
    createdCamera = cam --- Create Cam
    SetEntityVisible(playerPed, false, 0) --- Make Player Invisible
	FreezeEntityPosition(playerPed, true)
    SetEntityCoordsNoOffset(playerPed, -998.24, -2689.79, 39.76, false, false, false, true) --- Teleport Infront of Maze Bank IN Air --- Freeze The Player There
    SetFocusEntity(playerPed) ---- Focus on the player (To Render the building)
    SetCamCoord(cam,  -998.24, -2689.79, 39.76)
	SetCamRot(cam, 0.0, 0.0, 143.68, true)
	SetEntityHeading(playerPed, 143.68)	--- Set the camera there
    RenderScriptCams(1, 0, 0, 1, 1) --- Render Cams
    ESX.ShowHelpNotification('Bem-Vindo ao ~b~Venus City RolePlay~w~. Esperamos que tenha uma boa experiência em nossa cidade.')
    Citizen.Wait(250)
    Citizen.Wait(5000)
    ESX.ShowHelpNotification('Este tutorial irá auxiliá-lo a entender como nossa cidade funciona!')
    Citizen.Wait(6050)
    ESX.ShowHelpNotification('Vamos Lá!')
    Citizen.Wait(2000)
    DoScreenFadeOut(800) --- Fade Out the screen
    Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, -249.46, -991.05, 35.23, false, false, false, true) --- Teleport Player Infront Job Center
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -249.46, -991.05, 35.23)
	SetCamRot(cam, 0.0, 0.0, 16.94, true)
	SetEntityHeading(playerPed, 16.94)	-- Set the Camera Infront of the Job Cente
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~b~Agência de Empregos\n~w~Aqui você pode se candidatar a qualquer emprego disponível.')
    Citizen.Wait(5000)
    ESX.ShowNotification('Temos muitos muitos tipos de empregos disponíveis para você. Esperamos que possa conferir todos.')
    Citizen.Wait(2000)
    ESX.ShowNotification('Você tambem poderá montar sua empresa. ou até mesmo comprar escritórios para uso próprio.')
    Citizen.Wait(8000)
	DoScreenFadeIn(800) 
	Citizen.Wait(3000) --- Wait (3 Seconds)
    SetEntityCoordsNoOffset(playerPed, -249.46, -991.05, 35.23, false, false, false, true) --- Teleport Player Infront Job Center
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -249.46, -991.05, 35.23)
	SetCamRot(cam, 0.0, 0.0, 16.94, true)
	SetEntityHeading(playerPed, 16.94)	-- Set the Camera Infront of the Job Cente
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
	SetEntityCoordsNoOffset(playerPed,-331.47, -1018.24, 34.4, false, false, false, true) --- Teleport Player Infront Feirão de Carros
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -331.47, -1018.24, 34.4)
	RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
	SetCamRot(cam, 0.0, 0.0, 9.84, true)
	SetEntityHeading(playerPed, 9.84)
    ESX.ShowHelpNotification('~g~Lotéricas\n~w~As Lotéricas poderão ser usadas para o pagamento de contas.')
	Citizen.Wait(2000)
	ESX.ShowNotification('Os jogadores poderão ver suas faturas apertando ~y~F7~s~.')
    Citizen.Wait(10000)
	DoScreenFadeIn(800) --- Fade In Showing the Screen
    Citizen.Wait(1000)
	SetEntityCoordsNoOffset(playerPed, -55.28, -1719.3, 35.35, false, false, false, true) --- Teleport Player Infront Feirão de Carros
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, -55.28, -1719.3, 35.35)
	RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
	SetCamRot(cam, 0.0, 0.0, 342.86, true)
	SetEntityHeading(playerPed, 342.86)
    ESX.ShowHelpNotification('~b~Feirão de Carros Usados\n~w~Aqui você pode vender e comprar carros usados por jogadores.')
	Citizen.Wait(2000)
	ESX.ShowNotification('Os jogadores poderão colocar seus carros a venda, vale a pena conferir se há carros a venda.')
    Citizen.Wait(10000)
	DoScreenFadeIn(800)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(playerPed, 444.46, -1603.41, 39.23, false, false, false, true) --- Teleport Player Infront Feirão de Carros
    FreezeEntityPosition(playerPed, true) --- Freeze Player
    SetFocusEntity(playerPed) --- Focus on the player (To Render Building)
    Citizen.Wait(800) --- Wait 0.8 Seconds
    SetCamCoord(cam, 444.46, -1603.41, 39.23)
	RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
	SetCamRot(cam, 0.0, 0.0, 107.31, true)
	SetEntityHeading(playerPed, 107.31)
    ESX.ShowHelpNotification('~y~Seguradora\n~w~Aqui você pode recuperar seus carros que foram retirados da garagem.')
	Citizen.Wait(2000)
	ESX.ShowNotification('Se você possui mais de um carro fora da sua garagem, você não poderá retirar mais veículos.')
    Citizen.Wait(10000)
	DoScreenFadeIn(800)
	Citizen.Wait(1000)--- Fade In Showing the Screen
	SetEntityCoordsNoOffset(playerPed, -998.24, -2689.79, 39.76, false, false, false, true) --- Teleport Infront of Maze Bank IN Air --- Freeze The Player There
    SetFocusEntity(playerPed) ---- Focus on the player (To Render the building)
    SetCamCoord(cam,  -998.24, -2689.79, 39.76)
	SetCamRot(cam, 0.0, 0.0, 143.68, true)
	SetEntityHeading(playerPed, 143.68)	--- Set the camera there
    RenderScriptCams(1, 0, 0, 1, 1)
	Citizen.Wait(1000)--- Render Cams
    ESX.ShowHelpNotification('~b~Aluguel~w~\n Para começar sua vida em nossa cidade você poderá alugar carros e bicicletas.')
    Citizen.Wait(250)
    Citizen.Wait(5000)
    ESX.ShowHelpNotification('Para os veículos serão cobradas taxas para aluguel e danos!')
    Citizen.Wait(6050)
    ESX.ShowHelpNotification('Se preferir você poderá pedir um taxi, pelo chat, digitando ~y~/taxi~s~!')
    Citizen.Wait(3500)
	DoScreenFadeIn(800)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(playerPed, 239.16, -562.95, 57.29, false, false, false, true) --- Teleport Player Infront Feirão de Carros
	SetCamCoord(cam, 239.16, -562.95, 57.29)
	SetFocusEntity(playerPed)
	SetCamRot(cam, 0.0, 0.0, 246.74, true)-- Set the Camera Infront of the Job Center
	SetEntityHeading(playerPed, 246.74)
    RenderScriptCams(1, 0, 0, 1, 1) -- Render Cams
    Citizen.Wait(1000)
    ESX.ShowHelpNotification('~r~Hospital\n~w~Quando você estiver machucado você poderá pagar ao hospital e se recuperar!')
    Citizen.Wait(9000)
    ESX.ShowHelpNotification('Quando você morrer você será redirecionado ao Hospital para que tenha uma nova vida.')
    Citizen.Wait(8000)
	DoScreenFadeIn(800)
    ESX.ShowHelpNotification('Esperamos que esse tutorial tenha te ajudado. Tenha uma boa estadia em nossa cidade!')
    SetEntityCoordsNoOffset(playerPed, -1042.14, -2745.82, 20.37, false, false, false, true) --- Teleport Player Back to start
	SetEntityHeading(playerPed, 331.0)
    FreezeEntityPosition(playerPed, true) --- Freeze The Player There
    SetEntityVisible(playerPed, true, 0) --- set visable
    FreezeEntityPosition(playerPed, false) -- unfreeze
    DestroyCam(createdCamera, 0)
    DestroyCam(createdCamera, 0)
    RenderScriptCams(0, 0, 1, 1, 1)
    createdCamera = 0
    ClearTimecycleModifier("scanline_cam_cheap")
    SetFocusEntity(GetPlayerPed(PlayerId()))
    elseif action == "no" then
		ESX.ShowNotification('Seja bem-vindo a Venus City. Esperamos que tenha uma boa estadia em nossa cidade!')
    end

    end, function(data, menu)
        menu.close()
    end)

end
]]

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(10)
		end

		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
					TriggerEvent('skinchanger:loadSkin', {sex = 0}, OpenSaveableMenu)
				else
					TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)

			FirstSpawn = false
		end
	end)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

AddEventHandler('esx_skin:getLastSkin', function(cb)
	cb(LastSkin)
end)

AddEventHandler('esx_skin:setLastSkin', function(skin)
	LastSkin = skin
end)

RegisterNetEvent('esx_skin:openMenu')
AddEventHandler('esx_skin:openMenu', function(submitCb, cancelCb)
	OpenMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openRestrictedMenu')
AddEventHandler('esx_skin:openRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:openSaveableMenu')
AddEventHandler('esx_skin:openSaveableMenu', function(submitCb, cancelCb)
	OpenSaveableMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('esx_skin:openSaveableRestrictedMenu')
AddEventHandler('esx_skin:openSaveableRestrictedMenu', function(submitCb, cancelCb, restrict)
	OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('esx_skin:requestSaveSkin')
AddEventHandler('esx_skin:requestSaveSkin', function()
	TriggerEvent('skinchanger:getSkin', function(skin)
		TriggerServerEvent('esx_skin:responseSaveSkin', skin)
	end)
end)
