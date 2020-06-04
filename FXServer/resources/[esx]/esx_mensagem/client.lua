Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler("onClientMapStart", function()
  ESX.Scaleform.ShowFreemodeMessage('~b~Venus Roleplay', '~w~Seja bem-vindo a Venus Roleplay', 2)
  ESX.ShowAdvancedNotification('Venus City', 'Bem-vindo', 'Estamos felizes por você estar aqui, aproveite sua estadia em nossa cidade. Temos muito a oferecer!', 'CHAR_AMANDA', 8)
end)

