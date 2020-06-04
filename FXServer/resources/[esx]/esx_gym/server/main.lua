ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

TriggerEvent('esx_society:registerSociety', 'aluguel', 'Aluguel', 'society_aluguel', 'society_aluguel', 'society_aluguel', {type = 'private'})

RegisterServerEvent('esx_gym:hireBmx')
AddEventHandler('esx_gym:hireBmx', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 250) then
		xPlayer.removeMoney(250)
			
		notification("Você alugou uma ~g~BMX")
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end	
end)

RegisterServerEvent('esx_gym:hireCruiser')
AddEventHandler('esx_gym:hireCruiser', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 300) then
		xPlayer.removeMoney(300)
			
		notification("Você alugou uma ~g~CRUISER")
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end	
end)

RegisterServerEvent('esx_gym:hireFixter')
AddEventHandler('esx_gym:hireFixter', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 350) then
		xPlayer.removeMoney(350)
			
		notification("Você alugou uma ~g~FIXTER")
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end	
end)

RegisterServerEvent('esx_gym:hireScorcher')
AddEventHandler('esx_gym:hireScorcher', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 400) then
		xPlayer.removeMoney(400)
			
		notification("Você alugou uma ~g~BMX")
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end	
end)

RegisterServerEvent("cobrarPlayer")
AddEventHandler("cobrarPlayer", function(chargeAmount)
     local xPlayer        = ESX.GetPlayerFromId(source)
     xPlayer.removeMoney(chargeAmount)
     CancelEvent()
end)


RegisterServerEvent('esx_gym:checkChip')
AddEventHandler('esx_gym:checkChip', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local oneQuantity = xPlayer.getInventoryItem('gym_membership').count
	
	if oneQuantity > 0 then
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	else
		TriggerClientEvent('esx_gym:falseMembership', source) -- false
	end
end)

--ESX.RegisterUsableItem('gym_bandage', function(source)
	--local _source = source
	--local xPlayer = ESX.GetPlayerFromId(source)

	--xPlayer.removeInventoryItem('gym_bandage', 1)	
	
	--TriggerClientEvent('esx_gym:useBandage', source)
--end)

--RegisterServerEvent('esx_gym:buyBandage')
--AddEventHandler('esx_gym:buyBandage', function()
	--local _source = source
	--local xPlayer = ESX.GetPlayerFromId(_source)
	
	--if(xPlayer.getMoney() >= 1900) then
		--xPlayer.removeMoney(1900)
		
		--xPlayer.addInventoryItem('gym_bandage', 1)		
		--notification("Você comprou uma ~g~Bandage")
	--else
		--notification("Você não tem ~r~dinheiro suficiente")
	--end	
--end)

RegisterServerEvent('esx_gym:buyMembership')
AddEventHandler('esx_gym:buyMembership', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 0) then
		xPlayer.removeMoney(0)
		
		xPlayer.addInventoryItem('gym_membership', 1)		
		notification("Agora você é um ~g~Membro")
		
		TriggerClientEvent('esx_gym:trueMembership', source) -- true
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end	
end)


RegisterServerEvent('esx_gym:buyProteinshake')
AddEventHandler('esx_gym:buyProteinshake', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 6) then
		xPlayer.removeMoney(6)
		
		xPlayer.addInventoryItem('protein_shake', 1)
		
		notification("Você comprou um  ~g~Shake Proteico")
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end	
end)

RegisterServerEvent("esx_gym:Faturadedanos")
AddEventHandler("esx_gym:Faturadedanos", function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	MySQL.Async.execute('INSERT INTO billing (identifier, sender, target_type, target, label, amount) VALUES (@identifier, @sender, @target_type, @target, @label, @amount)',
		{
			['@identifier']  = xPlayer.identifier,
			['@sender']      = 'steam:1100001128b7f4b',
			['@target_type'] = 'society',
			['@target']      = 'society_aluguel',
			['@label']       = 'Danos ao veículo alugado',
			['@amount']      = 500
		}, function(rowsChanged)
				TriggerClientEvent('esx:showNotification', xPlayer.source, 'Você recebeu uma fatura devido a danos no veículo!')
	end)
end)

ESX.RegisterUsableItem('protein_shake', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('protein_shake', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 350000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Você bebeu um ~g~shake de proteína')

end)

RegisterServerEvent('esx_gym:buyWater')
AddEventHandler('esx_gym:buyWater', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 1) then
		xPlayer.removeMoney(1)
		
		xPlayer.addInventoryItem('water', 1)
		
		notification("Você comprou uma ~g~Água")
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end		
end)

RegisterServerEvent('esx_gym:buySportlunch')
AddEventHandler('esx_gym:buySportlunch', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 22) then
		xPlayer.removeMoney(22)
		
		xPlayer.addInventoryItem('sportlunch', 1)
		
		notification("Você comprou um ~g~Almoço Esportivo")
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end		
end)

ESX.RegisterUsableItem('sportlunch', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('sportlunch', 1)

	TriggerClientEvent('esx_status:add', source, 'hunger', 350000)
	TriggerClientEvent('esx_basicneeds:onEat', source)
	TriggerClientEvent('esx:showNotification', source, 'Você comeu um ~g~Almoço Esportivo')

end)

RegisterServerEvent('esx_gym:buyPowerade')
AddEventHandler('esx_gym:buyPowerade', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	if(xPlayer.getMoney() >= 18) then
		xPlayer.removeMoney(18)
		
		xPlayer.addInventoryItem('powerade', 1)
		
		notification("Você comprou um ~g~powerade")
	else
		notification("Você não tem ~r~dinheiro suficiente")
	end		
end)

ESX.RegisterUsableItem('powerade', function(source)

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('powerade', 1)

	TriggerClientEvent('esx_status:add', source, 'thirst', 700000)
	TriggerClientEvent('esx_basicneeds:onDrink', source)
	TriggerClientEvent('esx:showNotification', source, 'Você bebeu um ~g~powerade')

end)

ESX.RegisterServerCallback('esx_gym:rentBlista', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 250 then
		xPlayer.removeMoney(250)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_gym:rentIssi', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 300 then
		xPlayer.removeMoney(300)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_gym:rentDilettante', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 350 then
		xPlayer.removeMoney(350)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_gym:rentAsea', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 400 then
		xPlayer.removeMoney(400)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_gym:rentScania', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 2500 then
		xPlayer.removeMoney(2500)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_gym:rentPhantom', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 4000 then
		xPlayer.removeMoney(4000)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_gym:rentPhantom2', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 3500 then
		xPlayer.removeMoney(3500)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('esx_gym:rentPacker', function (source, cb)
	local xPlayer     = ESX.GetPlayerFromId(source)

	if xPlayer.getMoney() >= 3000 then
		xPlayer.removeMoney(3000)
		cb(true)
	else
		cb(false)
	end
end)


-- FUNCTIONS IN THE FUTURE (COMING SOON...)

--RegisterServerEvent('esx_gym:trainArms')
--AddEventHandler('esx_gym:trainArms', function()
	
--end)

--RegisterServerEvent('esx_gym:trainChins')
--AddEventHandler('esx_gym:trainArms', function()
	
--end)

--RegisterServerEvent('esx_gym:trainPushups')
--AddEventHandler('esx_gym:trainPushups', function()
	
--end)

--RegisterServerEvent('esx_gym:trainYoga')
--AddEventHandler('esx_gym:trainYoga', function()
	
--end)

--RegisterServerEvent('esx_gym:trainSitups')
--AddEventHandler('esx_gym:trainSitups', function()
	
--end)

function notification(text)
	TriggerClientEvent('esx:showNotification', source, text)
end