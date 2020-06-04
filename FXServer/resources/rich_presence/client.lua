local players = {}

Citizen.CreateThread(function()
	while true do
		
		for i = 0, 255 do
			if NetworkIsPlayerActive( i ) then
				table.insert( players, i )
			end
		end
        --This is the Application ID (Replace this with you own)
		SetDiscordAppId(509424303129755648)

        --Here you will have to put the image name for the "large" icon.
		SetDiscordRichPresenceAsset('ert')
        
        --(11-11-2018) New Natives:

        --Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Servidor de Roleplay!')
       
        --Here you will have to put the image name for the "small" icon.
		
		SetRichPresence("Jogadores: "..players..'/32')

        --Here you can add hover text for the "small" icon.
        SetDiscordRichPresenceAssetSmallText('https://discord.gg/k2mQHZn')

        --It updates every one minute just in case.
		Citizen.Wait(60000)
	end
end)