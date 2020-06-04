local ESX = nil

-- ESX
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


ESX.RegisterServerCallback('skill:get', function(source, cb)
  local identifier = ESX.GetPlayerFromId(source).identifier
  MySQL.Async.fetchAll(
    'SELECT gym, gymstatus FROM skill WHERE identifier = @identifier',{['@identifier'] = identifier},
    function(result)
    	cb(result)
    if result[1] == nil then
      MySQL.Async.execute('INSERT INTO skill (identifier, gym, gymstatus) VALUES (@identifier, @gym, @gymstatus)',
        {
          ['@identifier']    = identifier,
          ['@gymstatus']        = 1,
          ['@gym']         = 1,
        }
      )
    end
  end)
end)


RegisterServerEvent('skill:GymUpdate')
AddEventHandler('skill:GymUpdate', function()
  local identifier = ESX.GetPlayerFromId(source).identifier
  MySQL.Async.fetchAll(
    'SELECT * FROM skill WHERE identifier = @identifier ', {['@identifier'] = identifier},
    function (result)
        MySQL.Sync.execute('UPDATE skill SET gym = @gym WHERE identifier = @identifier',
        {
          ['@identifier']    = identifier,
          ['@gym']        = result[1].gym + 3
        }
      )
  end)
end)
