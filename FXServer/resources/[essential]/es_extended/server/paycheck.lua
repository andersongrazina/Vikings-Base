ESX.StartPayCheck = function()

	function payCheck()
		local xPlayers = ESX.GetPlayers()

		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			local job     = xPlayer.job.grade_name
			local salary  = xPlayer.job.grade_salary

			if salary > 0 then
				if job == 'unemployed' or job == 'defensor' then -- unemployed
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_help', salary), 'CHAR_BANK_MAZE', 9)
				elseif Config.EnableSocietyPayouts then -- possibly a society
					TriggerEvent('esx_society:getSociety', xPlayer.job.name, function (society)
						if society ~= nil then -- verified society
							TriggerEvent('esx_addonaccount:getSharedAccount', society.account, function (account)
								if account.money >= salary then -- does the society money to pay its employees?
									xPlayer.addAccountMoney('bank', salary)
									account.removeMoney(salary)
									TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
								else
									TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), '', _U('company_nomoney'), 'CHAR_BANK_MAZE', 1)
								end
							end)
						else -- not a society
							xPlayer.addAccountMoney('bank', salary)
							TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
						end
					end)
				else -- generic job
					xPlayer.addAccountMoney('bank', salary)
					TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, _U('bank'), _U('received_paycheck'), _U('received_salary', salary), 'CHAR_BANK_MAZE', 9)
				end
			end
			MySQL.Async.fetchAll('SELECT * FROM  `billing` WHERE identifier = "'.. xPlayer.identifier ..'"', {}, function (result)
				if result ~= nil then
					for i=1, #result, 1 do
						local sender     = result[i].sender
						local targetType = result[i].target_type
						local target     = result[i].target
						local amount     = result[i].amount
						
						local xTarget = ESX.GetPlayerFromIdentifier(sender)
			
						if targetType == 'player' then
							if xTarget ~= nil then
									if xPlayer.identifier == result[i].identifier then
										xPlayer.removeAccountMoney('bank', result[i].amount)
											MySQL.Async.execute('DELETE from billing WHERE id = @id', {
												['@id'] = result[i].id
											}, function(rowsChanged)
												TriggerClientEvent('esx:showNotification', xPlayer.source, 'Você pagou uma conta por débito automático de '..result[1].amount..'!')
											end)
									end	
							end
						else
									
								TriggerEvent('esx_addonaccount:getSharedAccount', target, function(account)
										if xPlayer.identifier == result[i].identifier then
											if xPlayer.getBank() >= amount then
												xPlayer.removeAccountMoney('bank', result[i].amount)
												MySQL.Async.execute('DELETE from billing WHERE id = @id', {
													['@id'] = result[i].id
												}, function(rowsChanged)
													account.addMoney(amount)
													TriggerClientEvent('esx:showNotification', xPlayer.source, 'Você pagou uma conta por débito automático de R$'..result[1].amount..'!')
													if xTarget ~= nil then
														TriggerClientEvent('esx:showNotification', xTarget.source, 'Você recebeu um pagamento de R$'..ESX.Math.GroupDigits(amount))
													end
												end)
											end
										end
								end)	
						end
					end
			end
		end)
			MySQL.Async.fetchAll(
					'SELECT * FROM user_licenses WHERE type = "planosaude" AND owner="'.. xPlayer.identifier ..'"',
					{},
					function(result)
					for i=1, #result, 1 do
						if xPlayer.identifier == result[i].owner then
						  xPlayer.removeAccountMoney('bank', 250)
						  TriggerClientEvent('esx:showNotification', xPlayer.source, ('~o~Taxas:') .. '\n~s~Plano de Saúde: ~r~R$ 250')
						  TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
							  account.addMoney(950)
							end)
					end
						
				  end
				  end
			)
			MySQL.Async.fetchAll(
			'SELECT * FROM owned_properties WHERE rented = 1 AND owner="'.. xPlayer.identifier ..'"',
			{},
			function(result)

			  for i=1, #result, 1 do
				if xPlayer.identifier == result[i].owner then
				  xPlayer.removeAccountMoney('bank', result[i].price)
				  TriggerClientEvent('esx:showNotification', xPlayer.source, ('~o~Taxas') .. '\n~s~Aluguel: ~r~R$'.. result[i].price)
				end
			  end
			  end
			)
			MySQL.Async.fetchAll(
			'SELECT identifier, vip FROM users WHERE identifier ="'.. xPlayer.identifier ..'"',
			{},
			function(result)
			  for i=1, #result, 1 do
				if xPlayer.identifier == result[i].identifier then
					if result[i].vip == 1 then
						xPlayer.addAccountMoney('dinheiro_vip', 100)
						TriggerClientEvent('esx:showNotification', xPlayer.source, ('~o~Salário VIP:') .. '\n~s~Salário: ~r~VIP Coins: 100!')
					elseif result[i].vip == 2 then
						xPlayer.addAccountMoney('dinheiro_vip', 350)
						TriggerClientEvent('esx:showNotification', xPlayer.source, ('~o~Salário VIP:') .. '\n~s~Salário: ~r~VIP Coins: 350!')
					elseif result[i].vip == 3 then
						xPlayer.addAccountMoney('dinheiro_vip', 500)
						TriggerClientEvent('esx:showNotification', xPlayer.source, ('~o~Salário VIP:') .. '\n~s~Salário: ~r~VIP Coins: 500!')
					elseif result[i].vip == 4 then
						xPlayer.addAccountMoney('dinheiro_vip', 1000)
						TriggerClientEvent('esx:showNotification', xPlayer.source, ('~o~Salário VIP:') .. '\n~s~Salário: ~r~VIP Coins: 1.000!')
					elseif result[i].vip == 5 then
						xPlayer.addAccountMoney('dinheiro_vip', 2500)
						TriggerClientEvent('esx:showNotification', xPlayer.source, ('~o~Salário VIP:') .. '\n~s~Salário: ~r~VIP Coins: 2.500!')
					end
				end
			  end
			  end
			)
		end

		SetTimeout(Config.PaycheckInterval, payCheck)

	end

	SetTimeout(Config.PaycheckInterval, payCheck)

end