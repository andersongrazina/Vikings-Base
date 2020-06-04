Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, 
	Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 1
Config.TimerBeforeNewRob    = 1800 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Banks = {
	["fleeca"] = {
		position = {x = 147.049, y = -1044.944, z = 29.368 },
		reward = math.random(100000, 200000),
		nameOfBank = "Banco Venus (Praça)",
		secondsRemaining = 350, -- segundos
		lastRobbed = 0
	},
	["banco_prefeitura"] = {
		position = {x = 311.47, y = -283.28, z = 54.16 },
		reward = math.random(100000, 200000),
		nameOfBank = "Banco Venus (Prefeitura)",
		secondsRemaining = 400, -- segundos
		lastRobbed = 0
	},
	["banco_shopping"] = {
		position = {x = -353.56, y = -54.18, z = 49.04 },
		reward = math.random(100000, 200000),
		nameOfBank = "Banco Venus (Shopping)",
		secondsRemaining = 450, -- segundos
		lastRobbed = 0
	},
	["banco_vinewoodhills"] = {
		position = {x = -1211.47, y = -335.68, z = 37.78 },
		reward = math.random(100000, 200000),
		nameOfBank = "Banco Venus (Vinewood Hills)",
		secondsRemaining = 450, -- segundos
		lastRobbed = 0
	},
	["banco_paleto"] = {
		position = {x = -103.69, y = 6477.85, z = 31.63 },
		reward = math.random(100000, 200000),
		nameOfBank = "Banco Venus (Paleto Bay)",
		secondsRemaining = 500, -- segundos
		lastRobbed = 0
	},
	["banco_interior"] = {
		position = {x = 1176.12, y = 2711.69, z = 38.09 },
		reward = math.random(100000, 200000),
		nameOfBank = "Banco Venus (Sandy Shores)",
		secondsRemaining = 450, -- segundos
		lastRobbed = 0
	},
	["banco_rodovia"] = {
		position = {x = -2957.69, y = 481.62, z = 15.7 },
		reward = math.random(100000, 200000),
		nameOfBank = "Banco Venus (Rodovia Praia)",
		secondsRemaining = 450, -- segundos
		lastRobbed = 0
	},
	["banco_joalheria"] = {
		position = {x = -622.53, y = -231.17, z = 38.05 },
		reward = math.random(150000, 300000),
		nameOfBank = "Joalheria Venus (Centro da Cidade)",
		secondsRemaining = 500, -- segundos
		lastRobbed = 0
	},
	["banco_central"] = {
		position = {x = 265.39, y = 213.68, z = 101.68 },
		reward = math.random(150000, 300000),
		nameOfBank = "Banco Venus Central (Centro da Cidade)",
		secondsRemaining = 500, -- segundos
		lastRobbed = 0
	}
}
