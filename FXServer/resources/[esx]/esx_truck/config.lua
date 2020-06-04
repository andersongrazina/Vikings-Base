--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 25000

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 0



-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
	bread = 125,
	water = 330,
	stone = 2000,
	washed_stone = 1000,
	copper = 500,
	iron = 800,
	gold = 1000,
	diamond = 2000,
	alive_chicken = 1500,
	bandage = 250,
	blowpipe = 800,
	carokit = 15000,
	carotool = 2500,
	cerveja = 800,
	clothe = 875,
	coke = 500,
	coke_pooch = 1000,
	cola = 650,
	compansator = 150,
	cutted_wood = 2000,
	essence = 2000,
	extended_magazine = 250,
	fabric = 375,
	fish = 1000,
	fixkit = 2000,
	flashlight = 200,
	gazbottle = 2000,
	gps = 200,
	grip = 200,
	leiteg = 1000,
	leitep = 250,
	medikit = 1000,
	meth_pooch = 1000,
	meth = 500,
	nitro = 2500,
	opium_pooch = 1000,
	opium = 500,
	oxygen_mask = 10000,
	packaged_chicken = 1500,
	packaged_plank = 1000,
	petrol = 2000,
	petrol_raffin = 1000,
	phone = 150,
	powerade = 250,
	protein_shake = 150,
	redgull = 250,
	rose = 50,
	scope = 150,
	silent = 250,
	slaughtered_chicken = 1000,
	umbrellablue = 150,
	umbrellagrey = 150,
	weed = 500,
	weed_pooch = 1000,
	wood = 2500,
	wool = 500,
	WEAPON_COMBATPISTOL = 2200,
	WEAPON_DAGGER = 500,
	WEAPON_BAT = 1900,
	WEAPON_BOTTLE = 250,
	WEAPON_CROWBAR = 850,
	WEAPON_FLASHLIGHT = 500,
	WEAPON_GOLFCLUB = 950,
	WEAPON_HAMMER = 1100,
	WEAPON_HATCHET = 1500,
	WEAPON_KNUCKLE = 500,
	WEAPON_MACHETE = 750,
	WEAPON_SWITCHBLADE = 800,
	WEAPON_NIGHTSTICK = 500,
	WEAPON_WRENCH = 900,
	WEAPON_BATTLEAXE = 1500,
	WEAPON_POOLCUE = 500,
	WEAPON_STONE_HATCHET = 2200,
	WEAPON_PISTOL_MK2 = 1200,
	WEAPON_PISTOL = 1000,
	WEAPON_APPISTOL = 1200,
	WEAPON_STUNGUN = 1000,
	WEAPON_PISTOL50 = 1400,
	WEAPON_SNSPISTOL = 1000,
	WEAPON_SNSPISTOL_MK2 = 1000,
	WEAPON_HEAVYPISTOL = 1200,
	WEAPON_VINTAGEPISTOL = 1200,
	WEAPON_FLAREGUN = 800,
	WEAPON_MARKSMANPISTOL = 1800,
	WEAPON_REVOLVER = 1700,
	WEAPON_REVOLVER_MK2 = 1700,
	WEAPON_DOUBLE_ACTION = 1200,
	WEAPON_RAYPISTOL = 1000,
	WEAPON_PUMPSHOTGUN = 2200,
	WEAPON_PUMPSHOTGUN_MK2 = 2250,
	WEAPON_SAWOFFSHOTGUN = 2200,
	WEAPON_ASSAULTSHOTGUN = 2500,
	WEAPON_BULLPUPSHOTGUN = 2700,
	WEAPON_MUSKET = 2100,
	WEAPON_HEAVYSHOTGUN = 2500,
	WEAPON_DBSHOTGUN = 2000,
	WEAPON_AUTOSHOTGUN = 2100,
	WEAPON_MG = 4000,
	WEAPON_COMBATMG = 4200,
	WEAPON_COMBATMG_MK2 = 4500,
	WEAPON_GUSENBERG = 3000,
	WEAPON_SNIPERRIFLE = 3100,
	WEAPON_HEAVYSNIPER = 3400,
	WEAPON_HEAVYSNIPER_MK2 = 3500,
	WEAPON_MARKSMANRIFLE = 3300,
	WEAPON_MARKSMANRIFLE_MK2 = 3450,
	WEAPON_GRENADE = 700,
	WEAPON_BZGAS = 750,
	WEAPON_MOLOTOV = 650,
	WEAPON_STICKYBOMB = 850,
	WEAPON_PROXIMINE = 775,
	WEAPON_SNOWBALL = 50,
	WEAPON_PIPEBOMB = 850,
	WEAPON_BALL = 250,
	WEAPON_SMOKEGRENADE = 750,
	WEAPON_FLARE = 200,
	WEAPON_MICROSMG = 2200,
	WEAPON_SMG = 2300,
	WEAPON_SMG_MK2 = 2300,
	WEAPON_ASSAULTSMG = 2300,
	WEAPON_COMBATPDW = 2300,
	WEAPON_MACHINEPISTOL = 2200,
	WEAPON_MINISMG = 2200,
	WEAPON_RAYCARABINE = 4000,
	WEAPON_ASSAULTRIFLE = 3000,
	WEAPON_ASSAULTRIFLE_MK2 = 3200,
	WEAPON_CARBINERIFLE = 3200,
	WEAPON_CARBINERIFLE_MK2 = 3200,
	WEAPON_ADVANCEDRIFLE = 3200,
	WEAPON_SPECIALCARABINE = 3200,
	WEAPON_SPECIALCARABINE_MK2 = 3200,
	WEAPON_BULLPUPRIFLE = 3200,
	WEAPON_BULLPUPRIFLE_MK2 = 3200,
	WEAPON_COMPACTRIFLE = 2800,
	WEAPON_RPG = 8000,
	WEAPON_GRENADELAUNCHER_SMOKE = 8000,
	WEAPON_MINIGUN = 9000,
	WEAPON_FIREWORK = 9000,
	WEAPON_RAILGUN = 9000,
	WEAPON_HOMINGLAUNCHER = 9000,
	WEAPON_COMPACTLAUNCHER = 9000,
	WEAPON_RAYMINIGUN = 9000,
	WEAPON_PETROLCAN = 2000,
	WEAPON_FIREEXTINGUISHER = 1500,
	black_money = 0.02, -- poids pour un argent
 
}

Config.VehicleLimit = {
    [0] = 35000, --Compact
    [1] = 35000, --Sedans
    [2] = 50000, --SUV
    [3] = 40000, --Coupes
    [4] = 30000, --Muscle
    [5] = 35000, --Sports Classics
    [6] = 35000, --Sports
    [7] = 35000, --Super
    [8] = 10000, --Motorcycles
    [9] = 60000, --Off-road
    [10] = 200000, --Industrial
    [11] = 110000, --Utility
    [12] = 70000, --Vans
    [13] = 0, --Cycles
    [14] = 50000, --Boats
    [15] = 30000, --Helicopters
    [16] = 0, --Planes
    [17] = 40000, --Service
    [18] = 10000, --Emergency
    [19] = 0, --Military
    [20] = 400000, --Commercial
    [21] = 0, --Trains
}

Config.VehicleModel = {

    guardian    = 200000, --Vans
	contender   = 200000, --Vans

}

Config.VehiclePlate = {
	taxi        = "TAXI",
	cop         = "LSPD",
	ambulance   = "EMS0",
	mecano	    = "MECA",
}
