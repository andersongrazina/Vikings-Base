Config = {}
Config.Locale = 'en'

Config.Marker = {
	r = 250, g = 0, b = 0, a = 100,  -- red color
	x = 1.0, y = 1.0, z = 1.5,       -- tiny, cylinder formed circle
	DrawDistance = 15.0, Type = 1    -- default circle type, low draw distance due to indoors area
}

Config.PoliceNumberRequired = 1
Config.TimerBeforeNewRob    = 1800 -- The cooldown timer on a store after robbery was completed / canceled, in seconds

Config.MaxDistance    = 20   -- max distance from the robbary, going any longer away from it will to cancel the robbary
Config.GiveBlackMoney = true -- give black money? If disabled it will give cash instead

Stores = {
	["paleto_twentyfourseven"] = {
		position = { x = 1736.32, y = 6419.47, z = 35.03 },
		reward = math.random(5000, 20000),
		nameOfStore = "24/7. (Paleto Bay)",
		secondsRemaining = 400, -- seconds
		lastRobbed = 0
	},
	["sandyshores_twentyfoursever"] = {
		position = { x = 1961.24, y = 3749.46, z = 32.34 },
		reward = math.random(5000, 20000),
		nameOfStore = "24/7. (Sandy Shores)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["littleseoul_twentyfourseven"] = {
		position = { x = -709.17, y = -904.21, z = 19.21 },
		reward = math.random(5000, 20000),
		nameOfStore = "24/7. (Little Seoul)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["bar_one"] = {
		position = { x = 1990.57, y = 3044.95, z = 47.21 },
		reward = math.random(5000, 25000),
		nameOfStore = "Bar One. (Interior)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["ocean_liquor"] = {
		position = { x = -2959.33, y = 388.21, z = 14.00 },
		reward = math.random(5000, 18000),
		nameOfStore = "Robs Liquor. (Great Ocean Highway)",
		secondsRemaining = 200, -- seconds
		lastRobbed = 0
	},
	["rancho_liquor"] = {
		position = { x = 1126.80, y = -980.40, z = 45.41 },
		reward = math.random(5000, 18000),
		nameOfStore = "Robs Liquor. (Montanhas do Helipa)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["sanandreas_liquor"] = {
		position = { x = -1219.85, y = -916.27, z = 11.32 },
		reward = math.random(5000, 18000),
		nameOfStore = "Robs Liquor. (San Andreas Avenue)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["grove_ltd"] = {
		position = { x = -43.40, y = -1749.20, z = 29.42 },
		reward = math.random(5000, 15000),
		nameOfStore = "LTD Gasoline. (Grove Street)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["detran_twentyfourseven"] = {
		position = { x = 29.0, y = -1340.05, z = 29.5 },
		reward = math.random(5000, 20000),
		nameOfStore = "Twenty Four Seven. (Detran)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["wood_twentyfourseven"] = {
		position = { x = -1483.24, y = -375.94, z = 40.16 },
		reward = math.random(5000, 20000),
		nameOfStore = "Twenty Four Seven. (Morning Wood)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["glen_ltd"] = {
		position = { x = -1829.12, y = 799.08, z = 138.18 },
		reward = math.random(5000, 15000),
		nameOfStore = "LTD Gasoline. (Richman Glen)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["paraiso_ltd"] = {
		position = { x = 1707.84, y = 4920.22, z = 42.06 },
		reward = math.random(5000, 15000),
		nameOfStore = "LTD Gasoline. (Jardim Paraíso)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["praia_twentyfourseven"] = {
		position = { x = -3047.65, y = 585.66, z = 7.91 },
		reward = math.random(5000, 20000),
		nameOfStore = "Twenty Four Seven. (Praia)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["enseada_twentyfourseven"] = {
		position = { x = -3249.82, y = 1004.43, z = 12.83 },
		reward = math.random(5000, 20000),
		nameOfStore = "Twenty Four Seven. (Enseada)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["centro_twentyfourseven"] = {
		position = { x = 378.20, y = 333.20, z = 103.57 },
		reward = math.random(5000, 30000),
		nameOfStore = "Twenty Four Seven. (Centro da Cidade)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	},
	["deserto_twentyfourseven"] = {
		position = { x = 546.39, y = 2662.88, z = 42.16 },
		reward = math.random(5000, 30000),
		nameOfStore = "Twenty Four Seven. (Deserto)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["tataviam_twentyfourseven"] = {
		position = { x = 2549.43, y = 384.93, z = 108.62 },
		reward = math.random(5000, 20000),
		nameOfStore = "Twenty Four Seven. (Montanhas Tataviam)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["br_twentyfourseven"] = {
		position = { x = 2673.01, y = 3286.49, z = 55.24 },
		reward = math.random(5000, 20000),
		nameOfStore = "Twenty Four Seven. (BR-217)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["interior_twentyfourseven"] = {
		position = { x = 1166.21, y = 2714.33, z = 38.16 },
		reward = math.random(5000, 20000),
		nameOfStore = "Robs Liquor. (Sandy Shores)",
		secondsRemaining = 350, -- seconds
		lastRobbed = 0
	},
	["mirror_ltd"] = {
		position = { x = 1160.67, y = -314.40, z = 69.20 },
		reward = math.random(5000, 15000),
		nameOfStore = "LTD Gasoline. (Mirror Park Boulevard)",
		secondsRemaining = 300, -- seconds
		lastRobbed = 0
	}
}
