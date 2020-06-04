ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_chave:giveKey')
AddEventHandler('esx_chave:giveKey', function(target, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local _target = target
	local tPlayer = ESX.GetPlayerFromId(_target)
	local result = MySQL.Sync.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @identifier AND plate = @plate', {
			['@identifier'] = xPlayer.identifier,
			['@plate'] = plate
		})
	if result[1] ~= nil then
		MySQL.Async.execute('INSERT INTO chave_carros (owner, plate) VALUES (@owner, @plate)', {
			['@owner'] = tPlayer.identifier,
			['@plate'] = plate
		}, function (rowsChanged)
			if rowsChanged ~= 0 then
				TriggerClientEvent('esx_contract:showAnim', _source)
				Wait(10000)
				TriggerClientEvent('esx_contract:showAnim', _target)
				Wait(10000)
				TriggerClientEvent('esx:showNotification', _source, 'Você deu uma cópia de chave do seu veículo com o número de registro ' ..plate)
				TriggerClientEvent('esx:showNotification', _target, 'Você recebeu uma cópia de chave do veículo com o número de registro ' ..plate)
				xPlayer.removeInventoryItem('chave', 1)
			end
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, 'Este veículo não é seu')
	end
end)

ESX.RegisterUsableItem('chave', function(source)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	TriggerClientEvent('esx_chave:getVehicle', _source)
end)