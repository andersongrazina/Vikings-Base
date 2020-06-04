Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'br'

Config.MilitarStations = {

	Zancudo = {

		Blip = {
			Pos     = { x = -2339.55, y = 3264.18, z = 32.83 },
			Sprite  = 565,
			Display = 4,
			Scale   = 1.6,
			Colour  = 52,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_FLAREGUN',         price = 60 },
			{ name = 'GADGET_PARACHUTE',        price = 300 },
			{ name = 'WEAPON_NIGHTSTICK',       price = 200 },
			{ name = 'WEAPON_STUNGUN',          price = 500 },
			{ name = 'WEAPON_BZGAS',      price = 750 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 1200 },
			{ name = 'WEAPON_ASSAULTSMG',       price = 1250 },
			{ name = 'WEAPON_ASSAULTRIFLE',     price = 1500 },
			{ name = 'WEAPON_APPISTOL',      price = 2350 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 3500 },
			{ name = 'WEAPON_SMG',       		price = 4200 },
			{ name = 'WEAPON_ADVANCEDRIFLE',    price = 5000 },
			{ name = 'WEAPON_SPECIALCARBINE',      price = 7500 },
			{ name = 'WEAPON_COMBATMG',      price = 8500 },
			{ name = 'WEAPON_SNIPERRIFLE',      price = 11500 },
		},

		Cloakrooms = {
			{ x = -2357.95, y = 3255.14, z = 31.82 },
		},

		Armories = {
			{ x = -2345.46, y = 3232.55, z = 33.742 },
		},

		Vehicles = {
			{
				Spawner    = { x = -2153.61, y = 3310.8, z = 31.83 },
				SpawnPoints = {
					{ x = -2169.16, y = 3303.78, z = 31.83, heading = 148.93, radius = 6.0 }
				}
			},

			{
				Spawner    = { x = -2438.55, y = 2998.177, z = 31.83 },
				SpawnPoints = {
					{ x = -2431.71, y = 2993.53, z = 31.83, heading = 327.8, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner    = { x = -1832.28, y = 3020.16, z = 31.83 },
				SpawnPoint = { x = -1835.0, y = 2979.13, z = 31.83 },
				Heading    = 65.0			}
		},

		VehicleDeleters = {
			{ x = -2457.02, y = 2984.57, z = 31.83 },
			{ x = -2193.98, y = 3306.4, z = 31.83 }
		},

		BossActions = {
			{ x = -2364.05, y = 3245.35, z = 91.91 }
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'crusader',
			label = 'Jeep Exército'
		},
		
		{
			model = 'caddy2',
			label = 'Carrinho Exército'
		}
	},

	recruit = {},
	
	soldado = {},

	cabo = {},

	sargento = {
		{
			model = 'barracks',
			label = 'Caminhão Exército'
		}
		
	},

	tenente = {
		{
			model = 'barracks',
			label = 'Caminhão Exército'
		},
		{
			model = 'barracks2',
			label = 'Caminhão Exército 2'
		}
	
	},
	
	medico = {
		{
			model = 'barracks',
			label = 'Caminhão Exército'
		},
		{
			model = 'barracks2',
			label = 'Caminhão Exército 2'
		},
		{
			model = 'riot2',
			label = 'Blindado Exército'
		}
	},

	capitao = {
		{
			model = 'barracks',
			label = 'Caminhão Exército'
		},
		{
			model = 'barracks2',
			label = 'Caminhão Exército 2'
		},
		{
			model = 'riot2',
			label = 'Blindado Exército'
		}
	},
	
	major = {
		{
			model = 'barracks',
			label = 'Caminhão Exército'
		},
		{
			model = 'barracks2',
			label = 'Caminhão Exército 2'
		},
		{
			model = 'insurgent2',
			label = 'SUV Blindado Exército'
		},
		{
			model = 'riot2',
			label = 'Blindado Exército Caminhão'
		}
	
	},
	
	tencoronel = {
		{
			model = 'barracks',
			label = 'Caminhão Exército'
		},
		{
			model = 'barracks2',
			label = 'Caminhão Exército 2'
		},
		{
			model = 'insurgent2',
			label = 'SUV Blindado Exército'
		},
		{
			model = 'riot2',
			label = 'Blindado Exército Caminhão'
		}
	
	},

	coronel = {
		{
			model = 'barracks',
			label = 'Caminhão Exército'
		},
		{
			model = 'barracks2',
			label = 'Caminhão Exército 2'
		},
		{
			model = 'insurgent2',
			label = 'SUV Blindado Exército'
		},
		{
			model = 'riot2',
			label = 'Blindado Exército Caminhão'
		}
	},

	boss = {
		{
			model = 'barracks',
			label = 'Caminhão Exército'
		},
		{
			model = 'barracks2',
			label = 'Caminhão Exército 2'
		},
		{
			model = 'insurgent2',
			label = 'SUV Blindado Exército'
		},
		{
			model = 'riot2',
			label = 'Blindado Exército Caminhão'
		}
	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {

	recruit_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 208,   ['torso_2'] = 18,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 18,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 89,  ['helmet_2'] = 4,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 86,   ['pants_2'] = 18,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	soldado_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 208,   ['torso_2'] = 18,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 86,   ['pants_2'] = 18,
			['shoes_1'] = 51,   ['shoes_2'] = 0,
			['helmet_1'] = 103,  ['helmet_2'] = 18,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	cabo_wear = {
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 208,   ['torso_2'] = 18,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 18,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 112,  ['helmet_2'] = 1,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 208,   ['torso_2'] = 18,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 18,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 112,  ['helmet_2'] = 1,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	
	sargento_wear = {
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 220,   ['torso_2'] = 18,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 87,   ['pants_2'] = 18,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 60,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 1,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	tenente_wear = {
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 208,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 6,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 107,  ['helmet_2'] = 6,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	capitao_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 220,   ['torso_2'] = 15,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 15,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 15,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	major_wear = {
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 222,   ['torso_2'] = 15,
			['decals_1'] = 8,   ['decals_2'] = 1,
			['arms'] = 11,
			['pants_1'] = 87,   ['pants_2'] = 15,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 15,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	tencoronel_wear = {
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 220,   ['torso_2'] = 17,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 0,
			['pants_1'] = 87,   ['pants_2'] = 17,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 17,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	coronel_wear = {
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 221,   ['torso_2'] = 17,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 6,
			['pants_1'] = 87,   ['pants_2'] = 17,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 17,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 222,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 87,   ['pants_2'] = 6,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 113,  ['helmet_2'] = 13,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 130,  ['tshirt_2'] = 0,
			['torso_1'] = 222,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 87,   ['pants_2'] = 6,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 113,  ['helmet_2'] = 13,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 1,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 15,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 15,  ['bproof_2'] = 1
		}
	}

}