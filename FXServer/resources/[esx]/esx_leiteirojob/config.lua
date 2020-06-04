Config                            = {}
Config.nameJobLabel 			  = 'Leiteiro' 
Config.DrawDistance               = 100.0

Config.Zones = {
	
	EntrarServico = {
		Pos   = { x = 2416.08, y = 4993.51, z = 45.23 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		BlipSprite 	= 478,
		BlipColor 	= 0,
		BlipName 	= Config.nameJobLabel.." : Vestiário",
		Type  = 1,
	},
	
	ProcessarLeite = {
		Pos   = { x = 2886.53, y = 4385.56, z = 49.66 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		BlipSprite 	= 478,
		BlipColor 	= 0,
		BlipName 	= Config.nameJobLabel.." : Processamento",
		Type  = 1,
	},
	
	Vender = {
		Pos   = { x = 2567.92, y = 4685.04, z = 33.06 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		BlipSprite 	= 478,
		BlipColor 	= 0,
		BlipName 	= Config.nameJobLabel.." : Venda",
		Type  = 1,
	},
}