Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 1.0 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = true
Config.EnableLicenses             = false -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = false -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'br'

Config.MafiaStations = {

	Mafia = {

		Blip = {
			Pos     = { x = -807.72, y = 179.13, z = 83.43 },
			Sprite  = 124,
			Display = 4,
			Scale   = 1.0,
			Colour  = 27,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
			{ name = 'WEAPON_PISTOL',     price = 3000 },
			{ name = 'WEAPON_MACHINEPISTOL',     price = 6000 },
			{ name = 'WEAPON_HEAVYPISTOL',       price = 8500 },
			{ name = 'WEAPON_REVOLVER',       price = 10000 },
			{ name = 'WEAPON_DOUBLEACTION',       price = 18000 },
			{ name = 'WEAPON_DBSHOTGUN',     price = 20000 },
			{ name = 'WEAPON_SAWNOFFSHOTGUN',     price = 22000 },
			{ name = 'WEAPON_MICROSMG',      price = 22500 },
			{ name = 'WEAPON_MINISMG',      price = 25000 },
			{ name = 'WEAPON_SMG',      price = 30000 },
			{ name = 'WEAPON_ASSAULTSMG',     price = 32000 },
			{ name = 'WEAPON_ASSAULTRIFLE',         price = 45000 },
			{ name = 'WEAPON_GUSENBERG',         price = 40000 },
			{ name = 'WEAPON_MG',         price = 67500 },
			{ name = 'WEAPON_MOLOTOV',        price = 750 },
		},

		Cloakrooms = {
			{ x = -811.71, y = 175.1, z = 75.742 },
		},

		Armories = {
			{ x = -808.51, y = 175.39, z = 75.742 },
		},

		Vehicles = {
			{
				Spawner    = { x = -805.45, y = 162.98, z = 70.542 },
				SpawnPoints = {
					{ x = -820.98, y = 158.28, z = 70.35, heading = 107.0, radius = 6.0 }
				}
			}
		},

		VehicleDeleters = {
			{ x = -819.89, y = 184.29, z = 71.152 }
		},

		BossActions = {
			{ x = -799.94, y = 169.99, z = 71.842 }
		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
		{
			model = 'pounder2',
			label = 'Caminhão'
		}
	},

	recruit = {},
	
	sociado = {},

	gerente = {},
	
	chef = {},

	boss = {}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {

	recruit_wear = {
		male = {
			['tshirt_1'] = 22,  ['tshirt_2'] = 2,
			['torso_1'] = 28,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 28,   ['pants_2'] = 1,
			['shoes_1'] = 21,   ['shoes_2'] = 11,
			['helmet_1'] = 7,  ['helmet_2'] = 2,
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
			['helmet_1'] = 7,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	
	sociado_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 26,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 28,   ['pants_2'] = 1,
			['shoes_1'] = 21,   ['shoes_2'] = 11,
			['helmet_1'] = 7,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
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
	
	gerente_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1'] = 42,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 11,
			['pants_1'] = 28,   ['pants_2'] = 1,
			['shoes_1'] = 21,   ['shoes_2'] = 11,
			['helmet_1'] = 7,  ['helmet_2'] = 2,
			['chain_1'] = 0,    ['chain_2'] = 0,
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
	
	chef_wear = {
		male = {
			['tshirt_1'] = 26,  ['tshirt_2'] = 9,
			['torso_1'] = 10,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 28,   ['pants_2'] = 1,
			['shoes_1'] = 21,   ['shoes_2'] = 11,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
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
	
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 26,  ['tshirt_2'] = 9,
			['torso_1'] = 10,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 12,
			['pants_1'] = 28,   ['pants_2'] = 1,
			['shoes_1'] = 21,   ['shoes_2'] = 11,
			['helmet_1'] = 12,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
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
	}

}