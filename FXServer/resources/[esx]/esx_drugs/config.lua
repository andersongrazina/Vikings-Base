Config              = {}
Config.MarkerType   = 1
Config.DrawDistance = 100.0
Config.ZoneSize     = {x = 8.5, y = 8.5, z = 0.8}
Config.MarkerColor  = {r = 100, g = 204, b = 100}
Config.ShowBlips   = false  --markers visible on the map? (false to hide the markers on the map)

Config.RequiredCopsCoke  = 0
Config.RequiredCopsMeth  = 0
Config.RequiredCopsWeed  = 0
Config.RequiredCopsOpium = 0

Config.TimeToFarm    = 2 * 1000
Config.TimeToProcess = 2 * 1000
Config.TimeToSell    = 2  * 1000

Config.Locale = 'br'

Config.Zones = {
	CokeField =			{x = 3693.08, y = 4561.83, z = 24.10,	name = _U('coke_field'),		sprite = 501,	color = 40},
	CokeProcessing =	{x = 173.88, y = 2778.45,z= 45.085,	name = _U('coke_processing'),       sprite = 501,	color = 40},
	CokeDealer =		{x = 1258.19, y = -1612.52, z =52.325,	name = _U('coke_dealer'),		sprite = 500,	color = 75},
	MethField =			{x = 3562.45, y = 3671.78, z = 27.125,	name = _U('meth_field'),		sprite = 499,	color = 26},
	MethProcessing =	{x = 2433.98, y = 4968.9, z = 41.355,	name = _U('meth_processing'),	sprite = 499,	color = 26},
	MethDealer =		{x = -1146.54, y = 4939.93, z = 221.275,	name = _U('meth_dealer'),		sprite = 500,	color = 75},
	WeedField =			{x = 2223.79, y = 5577.14, z = 52.84,	name = _U('weed_field'),		sprite = 496,	color = 52},
	WeedProcessing =	{x = 1442.86, y = 6333.03, z = 22.985,	name = _U('weed_processing'),    sprite = 496,	color = 52},
	WeedDealer =		{x = -130.56, y = -1464.56, z = 32.775,	name = _U('weed_dealer'),		sprite = 500,	color = 75},
	OpiumField =		{x = -826.22,	y = 4422.21, z = 17.095,	name = _U('opium_field'),		sprite = 51,	color = 60},
	OpiumProcessing =	{x = 1391.96,	y = 3605.48, z = 37.82,	name = _U('opium_processing'),	sprite = 51,	color = 60},
	OpiumDealer =		{x = 2331.08,	y = 2570.22, z = 45.30,	name = _U('opium_dealer'),		sprite = 500,	color = 75}
}
