local thirst, hunger = 0, 0

Citizen.CreateThread(function()
	while true do 
		Citizen.Wait(1)	
		drawRct(0.0149, 0.9677, 0.1408,0.028,20,20,20,255) -- FUNDO PRETO
		drawRct(0.0163, 0.97, 0.06880,0.01,188,188,188,80) -- VIDA	
		drawRct(0.0865, 0.97, 0.06795,0.01,188,188,188,80) -- COLETE
		drawRct(0.0165, 0.982, 0.06815,0.01,188,188,188,80) -- FOME
		drawRct(0.0865, 0.982, 0.06805,0.01,188,188,188,80) -- SEDE
		
		-- Vida
		local health = GetEntityHealth(GetPlayerPed(-1)) - 100			
		local varSet = 0.06880 * (health / 100)			
		drawRct(0.0163, 0.97, varSet,0.01,55,115,55,255)
		drawTxt(0.545, 1.4612, 1.0,1.0,0.18, "Vida", 255, 255, 255, 255)			
			
		-- Colete
		armor = GetPedArmour(GetPlayerPed(-1))
		if armor > 100.0 then armor = 100.0 end
		local varSet = 0.06795 * (armor / 100)			
		drawRct(0.0865, 0.97, varSet,0.01,75,75,255,250)
		drawTxt(0.61, 1.461, 1.0,1.0,0.18, "Colete", 255, 255, 255, 255)
		
		-- Fome
		if hunger > 100.0 then hunger = 100.0 end
		local varSet = 0.06815 * (hunger / 100)			
		drawRct(0.0165, 0.982, varSet,0.01,217,217,25,250)
		drawTxt(0.5431, 1.474, 1.0,1.0,0.18, "Fome", 255, 255, 255, 255)	
		
		
		-- Sede
		if thirst > 100.0 then thirst = 100.0 end
		local varSet = 0.06805 * (thirst / 100)		
		drawRct(0.0865, 0.982, varSet,0.01,50,153,204,250)
		drawTxt(0.6118, 1.474, 1.0,1.0,0.18, "Sede", 255, 255, 255, 255)	
		
	end
end)

AddEventHandler("esx_2KNhud:updateBasics", function(basics)
    hunger, thirst = basics[1].percent, basics[2].percent
end)

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end