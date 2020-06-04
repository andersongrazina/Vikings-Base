ESX                = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('es:addGroupCommand', 'viprefresh', 'admin', function (source, args, user)
	loadWhiteList(function()
		TriggerEvent('esx_vip:sendMessage', source, 'VIP', 'VIP reloaded')
	end)
end, function (source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Permissões insuficientes!' } })
end, { help = _U('help_whitelist_load') })

TriggerEvent('es:addGroupCommand', 'vipadd', 'admin', function (source, args, user)
	local steamID = 'steam:' .. args[1]:lower()
	local vip = tonumber(args[2])

	if string.len(steamID) ~= 21 then
		TriggerClientEvent('chat:addMessage', source , { args = { '^8SISTEMA: ', 'steam ID Invalida!' } })
		return
	end

	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = steamID
	}, function(result)
		if result[1] ~= nil and result[1].vip > 0 then
			TriggerClientEvent('chat:addMessage', source , { args = {'^1SISTEMA', ' Esse Jogador ja possui VIP, peça para o Nego2K resolver isso!'} })
		else
			MySQL.Async.execute('UPDATE users SET vip = @vip WHERE `identifier`=@identifier', {
				['@identifier'] = steamID,
				['vip'] = vip
			}, function (rowsChanged)
				TriggerClientEvent('chat:addMessage', source , { args = { '^8VIP', ' O player foi setado de VIP nível '..vip..'!' } })
				--[[
					if vip == 1 then
						xPlayer.addAccountMoney('dinheiro_vip', 9500)
					elseif vip == 2 then
						xPlayer.addAccountMoney('dinheiro_vip', 15000)
					elseif vip == 3 then
						xPlayer.addAccountMoney('dinheiro_vip', 25000)
					elseif vip == 4 then
						xPlayer.addAccountMoney('dinheiro_vip', 50000)
					elseif vip == 5 then
						xPlayer.addAccountMoney('dinheiro_vip', 150000)
					end
					]]
			end)
		end
	end)
end, function (source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = { '^1SYSTEM', 'Insufficienct permissions!' } })
end, {help = _U('vip_add'), params = {{name = "identifier", help = _U('id_param')}, {name = "vip", help = _U('vip_nivel')}}})

ESX.RegisterServerCallback('esx_vip:checkVIP', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll(
		'SELECT identifier, vip FROM users WHERE identifier ="'.. xPlayer.identifier ..'"',
		{},function(result)
		for i=1, #result, 1 do
			if xPlayer.identifier == result[i].identifier then
				if result[i].vip > 0 then
					cb(true)
				else
					cb(false)
				end
			end
		end
	end)
end)