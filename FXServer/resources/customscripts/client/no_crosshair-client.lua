Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local isSniper = false
		
		local currentWeaponHash = GetSelectedPedWeapon(PlayerPedId())

			if currentWeaponHash == GetHashKey('WEAPON_SNIPERRIFLE') then
			isSniper = true
			elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER') then
			isSniper = true
			elseif currentWeaponHash == GetHashKey('WEAPON_HEAVYSNIPER_MK2') then
			isSniper = true
			elseif currentWeaponHash == GetHashKey('WEAPON_MARKSMANRIFLE') then
			isSniper = true
			elseif currentWeaponHash == GetHashKey('WEAPON_MARKSMANRIFLE_MK2') then
			isSniper = true
			else
			isSniper = false
			end
			
			if not isSniper then
				HideHudComponentThisFrame(14) -- hide crosshair
			end
	end
end)