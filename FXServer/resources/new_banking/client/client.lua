--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
ESX				= nil
inMenu			= true
local showblips	= true
local atbank	= false
local bankMenu	= true
local banks = {
	{name="Banco", id=108,  x = 150.12,   y = -1040.39,  z = 29.37},
	{name="Banco", id=108, x = -350.85,    y = -49.46,    z = 49.04},
	{name="Banco", id=108, x = 314.37,    y = -278.7,    z = 54.17},
	{name="Banco", id=108, x = 1175.0,    y = 2706.42,    z = 38.09},
	{name="Banco", id=108, x = -112.45,    y = 6468.86,    z = 31.63},
	{name="Banco", id=108, x = -2962.93,    y = 482.95,    z = 15.7},
	{name="Banco Central", id=106, x = 243.08,   y = 224.25,  z = 106.29, principal = true},
	{name="Banco", id=108, x = -1212.77,    y = -330.33,    z = 37.79}
}	

--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		CalculateTimeToDisplay()
	end
end)

function CalculateTimeToDisplay()
	hour = GetClockHours()
	minute = GetClockMinutes()
end




--===============================================
--==             Core Threading                ==
--===============================================
if bankMenu then
	Citizen.CreateThread(function()
	while true do
		Wait(0)
	if nearBank() then
			DisplayHelpText("Pressione ~INPUT_PICKUP~ para acessar sua conta ~b~")
		if IsControlJustPressed(1, 38) then
			if hour > 6 and hour < 22 then
				 ESX.TriggerServerCallback('jsfour-atm:getUser', function( dataUser )
					inMenu = true
					SetNuiFocus(true, true)
					SendNUIMessage({type = 'openGeneral', code = dataUser[1].code})
					TriggerServerEvent('bank:balance')
					local ped = GetPlayerPed(-1)
				end)
			else
				ESX.ShowAdvancedNotification('Banco Venus', 'Horário de Funcionamento', 'O Banco está fechado, volte entre as 7:00hrs e às 22:00hrs!', 'CHAR_BANK_MAZE', 9)
			end
		end
	end
				
		if IsControlJustPressed(1, 322) then
		inMenu = false
			SetNuiFocus(false, false)
			SendNUIMessage({type = 'close'})
		end
	end
	end)
end


--===============================================
--==             Map Blips	                   ==
--===============================================
Citizen.CreateThread(function()
	if showblips then
		for k,v in ipairs(banks)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite(blip, v.id)
		SetBlipScale(blip, 1.0)
		SetBlipColour(blip, 25)
		SetBlipAsShortRange(blip, true)
		if v.principal ~= nil and v.principal then
			SetBlipColour(blip, 77)
		end
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(tostring(v.name))
		EndTextCommandSetBlipName(blip)
		end
	end
end)



--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('currentbalance1')
AddEventHandler('currentbalance1', function(balance)
	local id = PlayerId()
	local playerName = GetPlayerName(id)
	
	SendNUIMessage({
		type = "balanceHUD",
		balance = balance,
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('bank:deposit', tonumber(data.amount))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('bank:withdraw', tonumber(data.amountw))
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('bank:balance')
end)

RegisterNetEvent('balance:back')
AddEventHandler('balance:back', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('bank:transfer', data.to, data.amountt)
	TriggerServerEvent('bank:balance')
end)

--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('bank:result')
AddEventHandler('bank:result', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)

--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
	SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)
	
	for _, search in pairs(banks) do
		local distance = GetDistanceBetweenCoords(search.x, search.y, search.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
		
		if distance <= 2 then
			return true
		end
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end