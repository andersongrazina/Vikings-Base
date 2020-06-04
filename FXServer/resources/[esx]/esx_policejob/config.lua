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

Config.MaxInService               = 8
Config.Locale                     = 'br'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Pos     = { x = 425.130, y = -979.558, z = 30.711 },
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_NIGHTSTICK',       price = 200 },
			{ name = 'WEAPON_STUNGUN',          price = 500 },
			{ name = 'WEAPON_BZGAS',      price = 750 },
			{ name = 'WEAPON_COMBATPISTOL',     price = 1200 },
			{ name = 'WEAPON_APPISTOL',      price = 2350 },
			{ name = 'WEAPON_PUMPSHOTGUN',      price = 3500 },
			{ name = 'WEAPON_SMG',       		price = 4200 },
			{ name = 'WEAPON_ADVANCEDRIFLE',    price = 5000 },
			{ name = 'WEAPON_SPECIALCARBINE',      price = 7500 },
			{ name = 'WEAPON_COMBATMG',      price = 8500 },
			{ name = 'WEAPON_SNIPERRIFLE',      price = 11500 },
			
			
		},

		Cloakrooms = {
			{ x = 452.600, y = -993.306, z = 29.750 },
		},

		Armories = {
			{ x = 451.699, y = -980.356, z = 29.689 },
		},

		Vehicles = {
			{
				Spawner    = { x = 454.69, y = -1017.40, z = 27.43 },
				SpawnPoints = {
					{ x = 438.42, y = -1018.30, z = 27.75, heading = 90.0, radius = 6.0 },
					{ x = 441.08, y = -1024.23, z = 28.30, heading = 90.0, radius = 6.0 },
					{ x = 453.53, y = -1022.20, z = 28.02, heading = 90.0, radius = 6.0 },
					{ x = 450.97, y = -1016.55, z = 28.10, heading = 90.0, radius = 6.0 }
				}
			},

			{
				Spawner    = { x = 473.38, y = -1018.43, z = 27.00 },
				SpawnPoints = {
					{ x = 475.98, y = -1021.65, z = 28.06, heading = 276.11, radius = 6.0 },
					{ x = 484.10, y = -1023.19, z = 27.57, heading = 302.54, radius = 6.0 }
				}
			}
		},

		Helicopters = {
			{
				Spawner    = { x = 466.477, y = -982.819, z = 42.691 },
				SpawnPoint = { x = 450.04, y = -981.14, z = 42.691 },
				Heading    = 0.0
			}
		},

		VehicleDeleters = {
			{ x = 462.74, y = -1014.4, z = 27.065 },
			{ x = 462.40, y = -1019.7, z = 27.104 },
			{ x = 469.12, y = -1024.52, z = 27.20 }
		},

		BossActions = {
			{ x = 448.417, y = -973.208, z = 29.689 }
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'pbus',
			label = 'Transporte de presos'
		}
	},

	recruit = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		}
	},
	
	soldado = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	},

	officer = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	},

	sergeant = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	},

	intendent = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	},

	lieutenant = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	},
	
	major = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	},
	
	tencoronel = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	},

	chef = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	},

	boss = {
		{
			model = 'bcalamo',
			label = 'ALAMO PMV'
		},
		{
			model = 'police22',
			label = 'BUFFALO PMV'
		}
	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 1,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
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
	soldado_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 1,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
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
	officer_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 1,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 1,
            ['torso_1'] = 55,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 25,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
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
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 222,   ['torso_2'] = 20,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 107,  ['helmet_2'] = 20,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
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
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 222,   ['torso_2'] = 20,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 107,  ['helmet_2'] = 20,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	major_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 222,   ['torso_2'] = 20,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 107,  ['helmet_2'] = 20,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 106,  ['helmet_2'] = 20,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	tencoronel_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 107,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 106,  ['helmet_2'] = 20,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
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
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 107,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 106,  ['helmet_2'] = 20,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
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
	rocam_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 139,   ['torso_2'] = 3,
            ['decals_1'] = 8,   ['decals_2'] = 3,
            ['arms'] = 44,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 72,  ['helmet_2'] = 9,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 139,   ['torso_2'] = 3,
            ['decals_1'] = 8,   ['decals_2'] = 3,
            ['arms'] = 44,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 72,  ['helmet_2'] = 9,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	swat_wear = {
		male = {
			['tshirt_1'] = 122,  ['tshirt_2'] = 0,
            ['torso_1'] = 53,   ['torso_2'] = 0,
            ['decals_1'] = 0,   ['decals_2'] = 0,
			['mask_1'] = 52,   ['mask_2'] = 0,
            ['arms'] = 17,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 39,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
			['glasses_1'] = 26,    ['glasses_2'] = 0,
            ['ears_1'] = -1,     ['ears_2'] = 0
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
	paisana_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
            ['torso_1'] = 13,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 11,
            ['pants_1'] = 13,   ['pants_2'] = 0,
            ['shoes_1'] = 10,   ['shoes_2'] = 0,
            ['chain_1'] = 125,    ['chain_2'] = 0
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
	aguia_wear = {
		male = {
			['tshirt_1'] =58,  ['tshirt_2'] = 0,
            ['torso_1'] = 228,   ['torso_2'] = 2,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 92,   ['pants_2'] = 2,
            ['shoes_1'] = 61,   ['shoes_2'] = 3,
            ['helmet_1'] = -1,  ['helmet_2'] = 0,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
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
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
            ['torso_1'] = 107,   ['torso_2'] = 1,
            ['decals_1'] = 0,   ['decals_2'] = 0,
            ['arms'] = 41,
            ['pants_1'] = 31,   ['pants_2'] = 0,
            ['shoes_1'] = 25,   ['shoes_2'] = 0,
            ['helmet_1'] = 106,  ['helmet_2'] = 20,
            ['chain_1'] = 0,    ['chain_2'] = 0,
            ['ears_1'] = 2,     ['ears_2'] = 0
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
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	bullet_avanc_wear = {
		male = {
			['bproof_1'] = 16,  ['bproof_2'] = 2
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	}

}