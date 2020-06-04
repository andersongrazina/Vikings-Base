Config = {}
Config.Locale = 'br'

Config.DrawDistance = 100.0
Config.MarkerColor  = { r = 120, g = 120, b = 240 }

Config.EnableOwnedVehicles = true -- If true then it will set the Vehicle Owner to the Player who bought it.
Config.ResellPercentage    = 75 -- Sets the Resell Percentage | Example: $100 Car will resell for $75
Config.LicenseEnable       = true -- Require people to own a Commercial License when buying vehicles? Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 4
Config.PlateUseSpace = true

Config.Zones = {
	ShopEntering = { -- Marker for Accessing Shop
		Pos   = { x = -830.21, y = -1255.83, z = 5.60 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Type  = 1
	},
	ShopInside = { -- Marker for Viewing Vehicles
		Pos     = { x = -1267.05, y = -3013.02, z = -49.45 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 102.93,
		Type    = -1
	},
	ShopOutside = { -- Marker for Purchasing Vehicles
		Pos     = { x = -836.29, y = -1286.78, z = 4.02 },
		Size    = { x = 1.5, y = 1.5, z = 1.0 },
		Heading = 93.19,
		Type    = -1
	},
	ResellVehicle = { -- Marker for Selling Vehicles
		Pos   = { x = -828.47, y = -1263.89, z = 4.02 },
		Size  = { x = 3.0, y = 3.0, z = 1.0 },
		Type  = 1
	}
}
