ESX                = nil
local InService    = {}
local MaxInService = {}
local playerJobs = {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

function GetInServiceCount(name)
	local count = 0

	for k,v in pairs(InService[name]) do
		if v == true then
			count = count + 1
		end
	end

	return count
end

function GetInServiceAmbulanceCount(name)
	local countAmbulance = 0

	for k,v in pairs(InService['ambulance']) do
		if v == true then
			countAmbulance = countAmbulance + 1
		end
	end

	return countAmbulance
end

function GetInServicePoliceCount(name)
	local countPolice = 0

	for k,v in pairs(InService['police']) do
		if v == true then
			countPolice = countPolice + 1
		end
	end

	return countPolice
end

function GetInServiceTaxiCount(name)
	local countTaxi = 0

	for k,v in pairs(InService['taxi']) do
		if v == true then
			countTaxi = countTaxi + 1
		end
	end

	return countTaxi
end

function GetInServiceMecanoCount(name)
	local countMecano = 0

	for k,v in pairs(InService['mecano']) do
		if v == true then
			countMecano = countMecano + 1
		end
	end

	return countMecano
end

RegisterCommand('trabalhos', function(src, args, raw)
	local EMSConnected = 0
	local PoliceConnected = 0
	local TaxiConnected = 0
	local MechanicConnected = 0
	local CardealerConnected = 0
	local EstateConnected = 0
	local inServicePoliceCount = GetInServicePoliceCount(name)
	local inServiceAmbulanceCount = GetInServiceAmbulanceCount(name)
	local inServiceMecanoCount = GetInServiceMecanoCount(name)
	local inServiceTaxiCount = GetInServiceTaxiCount(name)
	

	local xPlayers, xPlayer = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do

		xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayer.job.name == 'ambulance' then
			EMSConnected = EMSConnected + 1
		elseif xPlayer.job.name == 'police' then
			PoliceConnected = PoliceConnected + 1
		elseif xPlayer.job.name == 'taxi' then
			TaxiConnected = TaxiConnected + 1
		elseif xPlayer.job.name == 'mecano' then
			MechanicConnected = MechanicConnected + 1
		elseif xPlayer.job.name == 'cardealer' then
			CardealerConnected = CardealerConnected + 1
		elseif xPlayer.job.name == 'realestateagent' then
			EstateConnected = EstateConnected + 1
		end
	end
	TriggerClientEvent('chat:addMessage', src, { args = { '^8TRABALHOS: ', 'Ambulância: '..EMSConnected..'(Em serviço: '..inServiceAmbulanceCount..')' } })
		TriggerClientEvent('chat:addMessage', src, { args = { '^8TRABALHOS: ', 'Polícia: '..PoliceConnected..'(Em serviço: '..inServicePoliceCount..')' } })
		TriggerClientEvent('chat:addMessage', src, { args = { '^8TRABALHOS: ', 'Táxi: '..TaxiConnected..'(Em serviço: '..inServiceTaxiCount..')' } })
		TriggerClientEvent('chat:addMessage', src, { args = { '^8TRABALHOS: ', 'Mecânico: '..MechanicConnected..'(Em serviço: '..inServiceMecanoCount..')' } })
		TriggerClientEvent('chat:addMessage', src, { args = { '^8TRABALHOS: ', 'Concessionária: '..CardealerConnected} })
		TriggerClientEvent('chat:addMessage', src, { args = { '^8TRABALHOS: ', 'Agente Imobiliário: '..EstateConnected } })
end)

AddEventHandler('esx_service:activateService', function(name, max)
	InService[name]    = {}
	MaxInService[name] = max
end)

RegisterServerEvent('esx_service:disableService')
AddEventHandler('esx_service:disableService', function(name)
	InService[name][source] = nil
end)

RegisterServerEvent('esx_service:notifyAllInService')
AddEventHandler('esx_service:notifyAllInService', function(notification, name)
	for k,v in pairs(InService[name]) do
		if v == true then
			TriggerClientEvent('esx_service:notifyAllInService', k, notification, source)
		end
	end
end)

ESX.RegisterServerCallback('esx_service:contarTrabalhadores', function(source, cb, amount, name)
	local inServiceCount = GetInServiceCount(name)

	if inServiceCount >= amount then
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_service:enableService', function(source, cb, name)
	local inServiceCount = GetInServiceCount(name)

	if inServiceCount >= MaxInService[name] then
		cb(false, MaxInService[name], inServiceCount)
	else
		InService[name][source] = true
		cb(true, MaxInService[name], inServiceCount)
	end
end)

ESX.RegisterServerCallback('esx_service:isInService', function(source, cb, name)
	local isInService = false

	if InService[name][source] then
		isInService = true
	end
	cb(isInService)
end)

ESX.RegisterServerCallback('esx_service:getInServiceList', function(source, cb, name)
	cb(InService[name])
end)

AddEventHandler('playerDropped', function()
	local _source = source
		
	for k,v in pairs(InService) do
		if v[_source] == true then
			v[_source] = nil
		end
	end
end)