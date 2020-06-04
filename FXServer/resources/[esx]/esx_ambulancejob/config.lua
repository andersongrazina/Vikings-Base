Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 102, g = 0, b = 102 }
Config.MarkerSize                 = { x = 1.0, y = 1.0, z = 0.8}
Config.ReviveReward               = 1200  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = false -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders
Config.Locale                     = 'br'

Config.MaxInService               = 6

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 3 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 150

Config.Blip = {
	Pos     = { x = 307.76, y = -1433.47, z = 28.97 },
	Sprite  = 80,
	Display = 4,
	Scale   = 1.2,
	Colour  = 49
}

Config.HelicopterSpawner = {
	SpawnPoint = { x = 351.22, y = -587.25, z = 73.18 },
	Heading    = 0.0
}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {

	{
		model = 'ambulance',
		label = 'Ambulância'
	},
	
	{
		model = 'hiluxpc',
		label = 'Hilux SAMU'
	},
	
	{
		model = 'policeb',
		label = 'Moto SAMU'
	}

}

Config.Zones = {

	HospitalRespawnPed = { -- Main entrance
		Pos	= { x = 341.9, y = -580.34, z = 42.35},
		Type = -1
	},

	HospitalInteriorEntering1 = { -- Main entrance
		Pos	= { x = 360.2, y = -585.14, z = 28.83 },
		Type = 22
	},

	HospitalInteriorInside1 = {
		Pos	= { x = 336.95, y = -591.24, z = 42.29 },
		Type = -1
	},

	HospitalInteriorOutside1 = {
		Pos	= { x = 358.06, y = -596.98, z = 27.64 },
		Type = -1
	},
	
	Helicopter = { -- Main entrance
		Pos	= { x = 351.38, y = -575.9, z = 74.18},
		Type = 22
	},

	HospitalInteriorExit1 = {
		Pos	= { x = 340.04, y = -592.72, z = 43.29},
		Type = 22
	},

	HospitalInteriorEntering2 = { -- Lift go to the roof
		Pos	= { x = 247.1, y = -1371.4, z = 23.5 },
		Type = 1
	},

	HospitalInteriorInside2 = { -- Roof outlet
		Pos	= { x = 333.1,	y = -1434.9, z = 45.5 },
		Type = -1
	},

	HospitalInteriorOutside2 = { -- Lift back from roof
		Pos	= { x = 249.1,	y = -1369.6, z = 23.5 },
		Type = -1
	},

	HospitalInteriorExit2 = { -- Roof entrance
		Pos	= { x = 335.5, y = -1432.0, z = 45.5 },
		Type = 22
	},

	AmbulanceActions = { -- Cloakroom
		Pos	= { x = 324.29, y = -580.24, z = 43.33},
		Type = 22
	},
	
	Cloakroom = { -- Cloakroom
		Pos	= { x = 319.52, y = -573.65, z = 43.33},
		Type = 22
	},

	VehicleSpawner = {
		Pos	= { x = 329.21, y = -558.44, z = 28.75 },
		Type = 22
	},

	VehicleSpawnPoint = {
		Pos	= { x = 350.88, y = -545.67, z = 27.75 },
		Type = -1
	},

	VehicleDeleter = {
		Pos	= { x = 340.56, y = -560.85, z = 28.75 },
		Type = 24
	},

	Pharmacy = {
		Pos	= { x = 310.51, y = -599.08, z = 43.3 },
		Type = 22
	},

	ParkingDoorGoOutInside = {
		Pos	= { x = 234.56, y = -1373.77, z = 20.97 },
		Type = 1
	},

	ParkingDoorGoOutOutside = {
		Pos	= { x = 320.98, y = -1478.62, z = 28.81 },
		Type = -1
	},

	ParkingDoorGoInInside = {
		Pos	= { x = 238.64, y = -1368.48, z = 23.53 },
		Type = -1
	},

	ParkingDoorGoInOutside = {
		Pos	= { x = 317.97, y = -1476.13, z = 28.97 },
		Type = 22
	},

	StairsGoTopTop = {
		Pos	= { x = 341.24, y = -584.56, z = 73.18 },
		Type = -1
	},

	StairsGoTopBottom = {
		Pos	= { x = 325.26, y = -598.71, z = 43.3 },
		Type = 22
	},

	StairsGoBottomTop = {
		Pos	= { x = 339.3, y = -584.04, z = 74.18 },
		Type = 22
	},

	StairsGoBottomBottom = {
		Pos	= { x = 336.95, y = -591.24, z = 42.29 },
		Type = -1
	},
	
	StairsGoTopTop2 = {
		Pos	= { x = 333.63, y = -571.51, z = 42.33 },
		Type = -1
	},

	StairsGoTopBottom2 = {
		Pos	= { x = 319.42, y = -559.68, z = 28.75 },
		Type = 22
	},

	StairsGoBottomTop2 = {
		Pos	= { x = 334.17, y = -569.71, z = 43.33 },
		Type = 22
	},

	StairsGoBottomBottom2 = {
		Pos	= { x = 319.07, y = -557.12, z = 27.75 },
		Type = -1
	}

}
