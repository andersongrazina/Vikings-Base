Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

-- Created by Asser90 - modified by Deziel0495 and IllusiveTea - further modified by Vespura --

-- These vehicles will be registered as "allowed/valid" tow trucks.
-- Change the x, y and z offset values for the towed vehicles to be attached to the tow truck.
-- x = left/right, y = forwards/backwards, z = up/down
local allowedtowModels = { 
	['sandking'] = {x = 0.0, y = -0.5, z = 0.93}, -- default GTA V flatbed
	['rebel'] = {x = 0.0, y = 0.05, z = 0.90},
	['rebel2'] = {x = 0.0, y = 0.05, z = 0.90},
	['dloader'] = {x = 0.0, y = 0.0, z = 0.90},
	['bodhi2'] = {x = 0.0, y = -0.20, z = 0.45},
	['yosemite'] = {x = 0.0, y = 0.03, z = 0.55},
	['riata'] = {x = 0.0, y = -0.1, z = 0.90},
    ['sandking2'] = {x = 0.0, y = -0.5, z = 1.25}, -- default GTA V flatbed
	['bobcatxl'] = {x = 0.0, y = -0.5, z = 0.5}, -- default GTA V flatbed
	['guardian'] = {x = 0.0, y = -0.5, z = 0.60}, -- default GTA V flatbed
	['bison3'] = {x = 0.0, y = 0.2, z = 1.95},
}


local allowtowingBoats = true -- Set to true if you want to be able to tow boats.
local allowtowingPlanes = false -- Set to true if you want to be able to tow planes.
local allowtowingHelicopters = false -- Set to true if you want to be able to tow helicopters.
local allowtowingTrains = false -- Set to true if you want to be able to tow trains.
local allowtowingTrailers = true -- Disables trailers. NOTE: THIS ALSO DISABLES THE AIRTUG, towTRUCK, SADLER, AND ANY OTHER VEHICLE THAT IS IN THE UTILITY CLASS.

local currentlytowedVehicle = nil

RegisterCommand("towmoto", function()
	TriggerEvent("towmoto")
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

RegisterNetEvent('towmoto')
AddEventHandler('towmoto', function()
	
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
            local vehiclesCoords = GetOffsetFromEntityInWorldCoords(vehicle, 0.0, -5.0, 0.0)
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
