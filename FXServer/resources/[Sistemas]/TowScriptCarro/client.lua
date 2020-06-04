-- Created by Asser90 - modified by Deziel0495 and IllusiveTea - further modified by Vespura --

-- These vehicles will be registered as "allowed/valid" tow trucks.
-- Change the x, y and z offset values for the towed vehicles to be attached to the tow truck.
-- x = left/right, y = forwards/backwards, z = up/down
local allowedtowModels = { 
	['pounder2'] = {x = 0.0, y = 0.00, z = 1.0},
	['pounder'] = {x = 0.0, y = 0.00, z = 1.0},
	['mule'] = {x = 0.0, y = 0.00, z = 0.90},
	['mule2'] = {x = 0.0, y = 0.00, z = 0.90},
	['mule3'] = {x = 0.0, y = 0.00, z = 0.90},
	['mule4'] = {x = 0.0, y = 0.00, z = 0.90},
}


local allowtowingBoats = false -- Set to true if you want to be able to tow boats.
local allowtowingPlanes = false -- Set to true if you want to be able to tow planes.
local allowtowingHelicopters = false -- Set to true if you want to be able to tow helicopters.
local allowtowingTrains = false -- Set to true if you want to be able to tow trains.
local allowtowingTrailers = true -- Disables trailers. NOTE: THIS ALSO DISABLES THE AIRTUG, towTRUCK, SADLER, AND ANY OTHER VEHICLE THAT IS IN THE UTILITY CLASS.

local currentlytowedVehicle = nil

RegisterCommand("towcarro", function()
	TriggerEvent("towcarro")
end,false)



function isTargetVehicleATrailer(modelHash)
    if GetVehicleClassFromName(modelHash) == 11 then
        return true
    else
        return false
    end
end

local xoff = 0.0
local yoff = 0.0
local zoff = 0.0

function isVehicleAtowTruck(vehicle)
    local isValid = false
    for model,posOffset in pairs(allowedtowModels) do
        if IsVehicleModel(vehicle, model) then
            xoff = posOffset.x
            yoff = posOffset.y
            zoff = posOffset.z
            isValid = true
            break
        end
    end
    return isValid
end

RegisterNetEvent('towcarro')
AddEventHandler('towcarro', function()
	
	local playerped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(playerped, true)
	
	local isVehicletow = isVehicleAtowTruck(vehicle)

	if isVehicletow then

		local coordA = GetEntityCoords(playerped, 1)
		local coordB = GetOffsetFromEntityInWorldCoords(playerped, 0.0, 5.0, 0.0)
		local targetVehicle = getVehicleInDirection(coordA, coordB)
        

		Citizen.CreateThread(function()
			while true do
				Citizen.Wait(0)
				isVehicletow = isVehicleAtowTruck(vehicle)
				local roll = GetEntityRoll(GetVehiclePedIsIn(PlayerPedId(), true))
				if IsEntityUpsidedown(GetVehiclePedIsIn(PlayerPedId(), true)) and isVehicletow or roll > 70.0 or roll < -70.0 then
					DetachEntity(currentlytowedVehicle, false, false)
					currentlytowedVehicle = nil
					ShowNotification("~o~~h~tow Service:~n~~s~Looks like the cables holding on the vehicle have broke!")
				end
                
			end
		end)

		if currentlytowedVehicle == nil then
			if targetVehicle ~= 0 then
                local targetVehicleLocation = GetEntityCoords(targetVehicle, true)
                local towTruckVehicleLocation = GetEntityCoords(vehicle, true)
                local distanceBetweenVehicles = GetDistanceBetweenCoords(targetVehicleLocation, towTruckVehicleLocation, false)
                -- print(tostring(distanceBetweenVehicles)) -- debug only
		-- Distance allowed (in meters) between tow truck and the vehicle to be towed			
                if distanceBetweenVehicles > 12.0 then
                    ShowNotification("~o~~h~tow Service:~n~~s~Your cables can't reach this far. Move your tow truck closer to the vehicle.")
                else
                    local targetModelHash = GetEntityModel(targetVehicle)
                    -- Check to make sure the target vehicle is allowed to be towed (see settings at lines 8-12)
                    if not ((not allowtowingBoats and IsThisModelABoat(targetModelHash)) or (not allowtowingHelicopters and IsThisModelAHeli(targetModelHash)) or (not allowtowingPlanes and IsThisModelAPlane(targetModelHash)) or (not allowtowingTrains and IsThisModelATrain(targetModelHash)) or (not allowtowingTrailers and isTargetVehicleATrailer(targetModelHash))) then 
                        if not IsPedInAnyVehicle(playerped, true) then
                            if vehicle ~= targetVehicle and IsVehicleStopped(vehicle) then
                                -- TriggerEvent('chatMessage', '', {255,255,255}, xoff .. ' ' .. yoff .. ' ' .. zoff) -- debug line
                                AttachEntityToEntity(targetVehicle, vehicle, GetEntityBoneIndexByName(vehicle, 'bodyshell'), 0.0 + xoff, -1.5 + yoff, 0.0 + zoff, 0, 0, 0, 1, 1, 0, 1, 0, 1)
                                currentlytowedVehicle = targetVehicle
                                ShowNotification("~o~~h~tow Service:~n~~s~Vehicle has been loaded onto the flatbed.")
                            else
                                ShowNotification("~o~~h~tow Service:~n~~s~There is currently no vehicle on the flatbed.")
                            end
                        else
                            ShowNotification("~o~~h~tow Service:~n~~s~You need to be outside of your vehicle to load or unload vehicles.")
                        end
                    else
                        ShowNotification("~o~~h~tow Service:~n~~s~Your tow truck is not equipped to tow this vehicle.")
                    end
                end
            else
                ShowNotification("~o~~h~tow Service:~n~~s~No towable vehicle detected.")
			end
		elseif IsVehicleStopped(vehicle) then
            DetachEntity(currentlytowedVehicle, false, false)
            local vehiclesCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -10.0, 0.0)
			SetEntityCoords(currentlytowedVehicle, vehiclesCoords["x"], vehiclesCoords["y"], vehiclesCoords["z"], 1, 0, 0, 1)
			SetVehicleOnGroundProperly(currentlytowedVehicle)
			currentlytowedVehicle = nil
			ShowNotification("~o~~h~tow Service:~n~~s~Vehicle has been unloaded from the flatbed.")
		end
	else
        ShowNotification("~o~~h~tow Service:~n~~s~Your vehicle is not registered as an official tow truck.")
    end
end)

function getVehicleInDirection(coordFrom, coordTo)
	local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
	local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
	return vehicle
end

function ShowNotification(text)
	SetNotificationTextEntry("STRING")
    AddTextComponentSubstringPlayerName(text)
	DrawNotification(false, false)
end
