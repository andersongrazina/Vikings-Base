local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local defaults = {
    height = 2.0,
    color = {255,255,255,60},
    fade = 100,
    threshold = 3.25,
}

local DEBUGVALUE = nil

local function sanityCheck(area)
    --TODO actually sanity check
    return true
end

local function _wall(p1,p1a,p2,p2a,R,G,B,A,compare)
    if A > 0 then
        if not compare then
            DrawPoly(p1,p1a,p2,R,G,B,A)
            DrawPoly(p1a,p2a,p2,R,G,B,A)
            DrawPoly(p2,p2a,p1a,R,G,B,A)
            DrawPoly(p2,p1a,p1,R,G,B,A)
        else
            local outerProduct = (compare.x-p1.x)*(p2.y-p1.y) - (compare.y-p1.y)*(p2.x-p1.x)
            if outerProduct <= 0 then
                DrawPoly(p1,p1a,p2,R,G,B,A)
                DrawPoly(p1a,p2a,p2,R,G,B,A)
            else
                DrawPoly(p2,p2a,p1a,R,G,B,A)
                DrawPoly(p2,p1a,p1,R,G,B,A)
            end
        end
    end
end

local function _drawLabel(where,what,r,g,b,a)
    --SetDrawOrigin(where,0) -- Acts funny if set more than 32 times (?) in a frame
    local onScreen,x,y = GetScreenCoordFromWorldCoord(where.x,where.y,where.z)
    if onScreen then
        SetTextColour(r,g,b,a)
        SetTextScale(0.5,0.5)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(what)
        DrawText(x,y)
    end
end

local function _draw(area,comparePoint)
    if not comparePoint and area.fade ~= 0 then
        if IsGameplayCamRendering() or IsCinematicCamRendering() then
            comparePoint = GetGameplayCamCoord()
        else
            comparePoint = GetCamCoord(GetRenderingCam())
        end
    end


    if #area.points > 2 then
        local alphaFraction = 1.0
        if area.fade > 0 then
            local distance = #(area.center - comparePoint)
            alphaFraction = 1.0 - ((1 / area.fade) * distance)
        end

        local bR,bG,bB,bA = table.unpack(area.border)
        local borderAlpha = math.ceil(bA * alphaFraction)
        borderAlpha = math.max(borderAlpha,0)
        borderAlpha = math.min(borderAlpha,255)

        local wR,wG,wB,wA = table.unpack(area.color)
        local wallAlpha = math.ceil(wA * alphaFraction)
        wallAlpha = math.max(wallAlpha,0)
        wallAlpha = math.min(wallAlpha,255)


        if wallAlpha > 0 or borderAlpha > 0 then
            if area.label then
                _drawLabel(area.center,area.label,bR,bG,bB,borderAlpha)
            end
            local lastPoint = nil
            local lastAbove = nil
            local firstPoint = nil
            local firstAbove = nil
            for i,point in ipairs(area.points) do
                local above = point + area.aboveOffset
                DrawLine(point,above,bR,bG,bB,borderAlpha)
                if area.numbered then
                    local middle = point + (area.aboveOffset / 2)
                    _drawLabel(middle,i,bR,bG,bB,borderAlpha)
                end
                if lastPoint then
                    _wall(point,above,lastPoint,lastAbove,wR,wG,wB,wallAlpha,comparePoint)
                    DrawLine(lastPoint,point,bR,bG,bB,borderAlpha)
                    DrawLine(lastAbove,above,bR,bG,bB,borderAlpha)
                else
                    firstAbove = above
                    firstPoint = point
                end
                lastAbove = above
                lastPoint = point
            end
            DrawLine(lastPoint,firstPoint,bR,bG,bB,borderAlpha)
            DrawLine(lastAbove,firstAbove,bR,bG,bB,borderAlpha)
            _wall(lastPoint,lastAbove,firstPoint,firstAbove,wR,wG,wB,wallAlpha,comparePoint)
            return true
        end
    end
    return false
end

local function _recalc(area)
    local totalX = 0.0
    local totalY = 0.0
    local totalZ = 0.0
    for i,p in ipairs(area.points) do
        totalX = totalX + p.x
        totalY = totalY + p.y
        totalZ = totalZ + p.z
        if p.z + area.height > area.maxZ then
            area.maxZ = p.z + area.height
        end
        if p.z < area.minZ then
            area.minZ = p.z
        end
    end

    area.center = vector3(totalX/#area.points,totalY/#area.points,(totalZ/#area.points)+(area.height/2))

    -- Yes, I realize this iterates the points list *twice*
    -- If you have suggestions on ways to avoid this, please make a pull request.
    for i,point in ipairs(area.points) do
        local pointDistance = #( area.center - point)
        if pointDistance > area.radius then
            area.radius = pointDistance
        end
    end
end

local function _add(area,point)
    if type(point) == 'vector3' then
        table.insert(area.points,point)
    end
end

local function _dotProduct(A,B,C)
    local BAx = A.x - B.x
    local BAy = A.y - B.y
    local BCx = C.x - B.x
    local BCy = C.y - B.y
    return (BAx * BCx + BAy * BCy)
end
local function _crossProduct(A,B,C)
    local BAx = A.x - B.x
    local BAy = A.y - B.y
    local BCx = C.x - B.x
    local BCy = C.y - B.y
    return (BAx * BCy - BAy * BCx)
end

local function _angle(A,B,C)
    local dotProduct = _dotProduct(A,B,C)
    local crossProduct = _crossProduct(A,B,C)
    return math.atan(crossProduct,dotProduct)
end

local function _isInside(area,candidate)

    if #area.points <= 2 then
        return false
    end

    if not candidate then
        candidate = GetEntityCoords(PlayerPedId())
    end

    if type(candidate) == 'vector3' then
        local centerDistance = #( candidate - area.center )
        if centerDistance <= area.radius then
            if candidate.z <= area.maxZ and candidate.z >= area.minZ then
                local first = area.points[1]
                local last = area.points[#area.points]
                local total = _angle(last,candidate,first)
                for i,point in ipairs(area.points) do
                    if i < #area.points then
                        total = total + _angle(point,candidate,area.points[i+1])
                    else
                        total = total + _angle(point,candidate,first)
                    end
                end
                total = math.abs(total)
                return total > area.threshold
            else
                return false
            end
        else
            return false
        end
    else
        return false
    end
end

function pArea(spec)
    spec = spec or {}
    local area = {
        height = (spec.height or defaults.height) * 1.0,
        color = spec.color or defaults.color,
        border = spec.border or spec.color or defaults.color,
        fade = (spec.fade or defaults.fade) * 1.0,
        threshold = spec.threshold or defaults.threshold,
        numbered = spec.numbered or defaults.numbered,
        label = spec.label, -- No default.
        points = {},
        maxZ = -math.huge,
        minZ = math.huge,
        radius = 0.0,
        center = vector3(0,0,0),
    }
    area.aboveOffset = vector3(0.0,0.0,area.height)
    if sanityCheck(area) then
        function area.draw(comparePoint)
            return _draw(area,comparePoint)
        end
        function area.addPoint(point)
            _add(area,point)
            _recalc(area)
        end
        function area.addBulk(...)
            for i,point in ipairs({...}) do
                _add(area,point)
            end
            _recalc(area)
        end
        function area.isInside(candidate)
            return _isInside(area,candidate)
        end
    end
    return area
end

function DrawSub(text, time)
	ClearPrints()
	SetTextEntry_2('STRING')
	AddTextComponentString(text)
	DrawSubtitleTimed(time, 1)
end

exports('create',pArea)

if true then -- Change to true for "demo mode"
    Citizen.CreateThread(function()

        local demoTextBeginY = 0.1
        local demoTextY = 0.3
        local demoTextX = 0.5
        local demoTextSpacing = 0.01

        local function demoText(text)
            SetTextEntry('STRING')
            SetTextCentre(true)
            SetTextOutline()
            SetTextScale(0.2,0.2)
            AddTextComponentString(text)
            DrawText(demoTextX,demoTextY)
            demoTextY = demoTextY + demoTextSpacing
        end

        local praca = pArea({
            fade = 1, -- The alpha value goes from the specified value to zero, where zero is reached when you are this many meters from the center point
            height = 7.0, -- Height of the area
            color = {10,255,10,128},
            border = {10,255,10,255},
        })
        praca.addBulk( -- You usually want to add points in bulk!
            -- These points define the inner fence of Bolingbroke Penitentiary
            vector3(121.42,-996.91,23.42),
			vector3(211.78,-1028.16,23.38),
			vector3(237.11,-958.48,23.17),
			vector3(270.29,-868.04,23.14),
			vector3(230.63,-853.52,23.88),
			vector3(180.27,-835.49,25.11),
			vector3(152.15,-912.48,24.04)
        )

        while true do
            demoTextY = demoTextBeginY
            praca.draw() -- The draw call is relatively heavy, and should only ever be used for debugging purposes!
            if praca.isInside() then
				local player = GetPlayerPed(-1)
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(GetPlayerPed(-1))
				DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
				DisableControlAction(0, 22, true) -- disable weapon wheel (Tab)
				DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
                DrawSub('~g~Você está em uma safezone!', 100)
            end

            Citizen.Wait(0)
        end
    end)
end
