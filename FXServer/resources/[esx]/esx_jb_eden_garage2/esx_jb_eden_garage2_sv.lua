ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_eden_garage:loadLicenses', source, licenses)
	end)
end)

function LoadLicenses (source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_eden_garage:loadLicenses', source, licenses)
	end)
end

RegisterServerEvent('esx_eden_garage:ServerLoadLicenses')
AddEventHandler('esx_eden_garage:ServerLoadLicenses', function()
	local _source = source
	LoadLicenses(_source)
end)
--Recupere les véhicules
ESX.RegisterServerCallback('eden_garage:getVehicles', function(source, cb, KindOfVehicle)
	local _source = source
	local vehicules = {}
	local identifier = ""
	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	else
		identifier = GetPlayerIdentifiers(_source)[1]
	end

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier}, function(data) 
		for _,v in pairs(data) do
			table.insert(vehicules, {vehicle = v.vehicle, state = v.state, fourrieremecano = v.fourrieremecano, plate = v.plate, vehiclename = v.vehiclename})
		end
		cb(vehicules)
	end)
end)

ESX.RegisterServerCallback('eden_garage:getVehiclesRemote', function(source, cb)
	local _source = source
	local vehiculesRemote = {}
	local identifier = GetPlayerIdentifiers(_source)[1]

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier",{['@identifier'] = identifier}, function(data) 
		for _,v in pairs(data) do
			table.insert(vehiculesRemote, {vehicle = v.vehicle, state = v.state, fourrieremecano = v.fourrieremecano, plate = v.plate, vehiclename = v.vehiclename})
		end
		cb(vehiculesRemote)
	end)
end)
-- Fin --Recupere les véhicules$

--Recupere les véhicules
ESX.RegisterServerCallback('eden_garage:getVehiclesMecano', function(source, cb)
	local _source = source
	local vehicules = {}

	MySQL.Async.fetchAll("SELECT * from owned_vehicles inner join characters on owned_vehicles.owner = characters.identifier where fourrieremecano=@fourrieremecano",{['@fourrieremecano'] = true}, function(data) 
		for _,v in pairs(data) do
			table.insert(vehicules, {vehicle = v.vehicle, state = v.state, fourrieremecano = v.fourrieremecano, firstname = v.firstname, lastname = v.lastname, plate = v.plate})
		end
		cb(vehicules)
	end)
end)
-- Fin --Recupere les véhicules

--Stock les véhicules
ESX.RegisterServerCallback('eden_garage:stockv',function(source,cb, vehicleProps, KindOfVehicle)
	local identifier = ""
	local _source = source
	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	else
		identifier = GetPlayerIdentifiers(_source)[1]
	end
	local vehplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles where plate=@plate and owner=@identifier",{['@plate'] = vehplate, ['@identifier'] = identifier}, function(result)  
		if result[1] ~= nil then
			local vehprop = json.encode(vehicleProps)
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle =@vehprop WHERE plate=@plate",{['@vehprop'] = vehprop, ['@plate'] = vehplate})
				cb(true)
			else
				DropPlayer(_source, "Você foi kickado do servidor, é o que acontece quando tenta usar cheat.")
				print("[esx_eden_garage] player "..identifier..' tried to spawn a vehicle with hash:'..vehiclemodel..". his original vehicle: "..originalvehprops.model)
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)
--Fin stock les vehicules

ESX.RegisterServerCallback('eden_garage:stockvmecano',function(source,cb, vehicleProps)
	local _source = source
	local plate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local vehiclemodel = vehicleProps.model
	local identifier = GetPlayerIdentifiers(_source)[1]
	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles where plate=@plate",{['@plate'] = plate}, function(result) 
		if result[1] ~= nil then
			local vehprop = json.encode(vehicleProps)
			local originalvehprops = json.decode(result[1].vehicle)
			if originalvehprops.model == vehiclemodel then
				MySQL.Sync.execute("UPDATE owned_vehicles SET vehicle =@vehprop WHERE plate=@plate",{['@vehprop'] = vehprop, ['@plate'] = plate})
				cb(true)
			else
				DropPlayer(_source, "Você foi kickado do servidor, é o que acontece quando tenta usar cheat.")
				print("[esx_eden_garage] player "..identifier..' tried to spawn a vehicle with hash:'..vehiclemodel..". his original vehicle: "..originalvehprops.model)
				cb(false)
			end
		else
			cb(false)
		end
	end)
end)

--Change le state du véhicule
RegisterServerEvent('eden_garage:modifystate')
AddEventHandler('eden_garage:modifystate', function(plate, state)
	MySQL.Sync.execute("UPDATE owned_vehicles SET state =@state WHERE plate=@plate",{['@state'] = state , ['@plate'] = plate:match("^%s*(.-)%s*$")})
end)	
--Fin change le state du véhicule

RegisterServerEvent('eden_garage:ChangeStateFromFourriereMecano')
AddEventHandler('eden_garage:ChangeStateFromFourriereMecano', function(vehicleProps, fourrieremecano)
	local _source = source
	local vehicleplate = vehicleProps.plate:match("^%s*(.-)%s*$")
	local fourrieremecano = fourrieremecano
	
	MySQL.Sync.execute("UPDATE owned_vehicles SET fourrieremecano =@fourrieremecano WHERE plate=@plate",{['@fourrieremecano'] = fourrieremecano , ['@plate'] = vehicleplate})
end)

RegisterServerEvent('eden_garage:payhealth')
AddEventHandler('eden_garage:payhealth', function(price)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= price then
		xPlayer.removeMoney(price)
		TriggerClientEvent('esx:showNotification', source, 'Você pagou R$'.. price..'!')
	else
		TriggerClientEvent('esx:showNotification', source, 'Você não tem dinheiro suficiente para pagar os reparos do veículo.')
	end
end)


RegisterServerEvent('eden_garage:renamevehicle')
AddEventHandler('eden_garage:renamevehicle', function(vehicleplate, name)
	MySQL.Sync.execute("UPDATE owned_vehicles SET vehiclename =@vehiclename WHERE plate=@plate",{['@vehiclename'] = name , ['@plate'] = vehicleplate:match("^%s*(.-)%s*$")})
end)

ESX.RegisterServerCallback('eden_garage:getOutVehicles',function(source, cb, KindOfVehicle)	
	local _source = source
	local vehicules = {}
	local identifier = ""
	if KindOfVehicle ~= "personal" then
		identifier = KindOfVehicle
	else
		identifier = GetPlayerIdentifiers(_source)[1]
	end

	MySQL.Async.fetchAll("SELECT * FROM owned_vehicles WHERE owner=@identifier AND (state=false OR fourrieremecano=true)",{['@identifier'] = identifier}, function(data) 
		for _,v in pairs(data) do
			table.insert(vehicules, {vehicle = v.vehicle, fourrieremecano = v.fourrieremecano, vehiclename =  v.vehiclename})
		end
		cb(vehicules)
	end)
end)

ESX.RegisterServerCallback('eden_garage:checkMoneyRemote', function(source, cb)

	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= 3000 then
		xPlayer.removeMoney(3000)
		cb(true)
	else
		cb(false)
	end
end)

--Foonction qui check l'argent
ESX.RegisterServerCallback('eden_garage:checkMoney', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.get('money') >= Config.Price then
		xPlayer.removeMoney(Config.Price)
		cb(true)
	else
		cb(false)
	end
end)
--Fin Foonction qui check l'argent

-- Fonction qui change les etats sorti en rentré lors d'un restart
-- AddEventHandler('onMySQLReady', function()

	-- MySQL.Sync.execute("UPDATE owned_vehicles SET state=true WHERE state=false", {})

-- end)
-- Fin Fonction qui change les etats sorti en rentré lors d'un restart

function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end