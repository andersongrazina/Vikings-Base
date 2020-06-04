ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('fineAmount')
AddEventHandler('fineAmount', function(mphspeed, maxspeed, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local truespeed = mphspeed
	if truespeed >= 91 and truespeed <= 101 then
		MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = xPlayer.identifier,
				['@sender']      = "Radar fixo",
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = ("Multa: Placa: %s, %s km/h em uma via de %s km/h"):format(plate, truespeed, maxspeed),
				['@amount']      = 400
			}, function(rowsChanged)
			end)
	end
	if truespeed >= 101 and truespeed <= 111 then
		MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = xPlayer.identifier,
				['@sender']      = "Radar fixo",
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = ("Multa: Placa: %s, %s km/h em uma via de %s km/h"):format(plate, truespeed, maxspeed),
				['@amount']      = 650
			}, function(rowsChanged)
		end)
	end
	if truespeed >= 111 and truespeed <= 121 then
		MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = xPlayer.identifier,
				['@sender']      = "Radar fixo",
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = ("Multa: Placa: %s, %s km/h em uma via de %s km/h"):format(plate, truespeed, maxspeed),
				['@amount']      = 850
			}, function(rowsChanged)
		end)
	end
	if truespeed >= 121 and truespeed <= 500 then
	MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = xPlayer.identifier,
				['@sender']      = "Radar fixo",
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = ("Multa: Placa: %s, %s km/h em uma via de %s km/h"):format(plate, truespeed, maxspeed),
				['@amount']      = 1200
			}, function(rowsChanged)
		end)
	end
	CancelEvent()
end)

RegisterServerEvent('fineAmount2')
AddEventHandler('fineAmount2', function(mphspeed, maxspeed, plate)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local truespeed = mphspeed
	if truespeed >= 111 and truespeed <= 121 then
		MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = xPlayer.identifier,
				['@sender']      = "Radar fixo",
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = ("Multa: Placa: %s, %s km/h em uma via de %s km/h"):format(plate, truespeed, maxspeed),
				['@amount']      = 400
			}, function(rowsChanged)
			end)
	end
	if truespeed >= 121 and truespeed <= 131 then
		MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = xPlayer.identifier,
				['@sender']      = "Radar fixo",
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = ("Multa: Placa: %s, %s km/h em uma via de %s km/h"):format(plate, truespeed, maxspeed),
				['@amount']      = 650
			}, function(rowsChanged)
		end)
	end
	if truespeed >= 131 and truespeed <= 141 then
		MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = xPlayer.identifier,
				['@sender']      = "Radar fixo",
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = ("Multa: Placa: %s, %s km/h em uma via de %s km/h"):format(plate, truespeed, maxspeed),
				['@amount']      = 850
			}, function(rowsChanged)
		end)
	end
	if truespeed >= 141 and truespeed <= 500 then
	MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
			{
				['@identifier']  = xPlayer.identifier,
				['@sender']      = "Radar fixo",
				['@target_type'] = 'society',
				['@target']      = 'society_police',
				['@label']       = ("Multa: Placa: %s, %s km/h em uma via de %s km/h"):format(plate, truespeed, maxspeed),
				['@amount']      = 1200
			}, function(rowsChanged)
		end)
	end
	CancelEvent()
end)
