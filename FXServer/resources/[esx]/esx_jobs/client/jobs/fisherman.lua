Config.Jobs.fisherman = {

	BlipInfos = {
		Sprite = 68,
		Color = 38
	},

	Vehicles = {},

	Zones = {

		CloakRoom = {
			Pos   = {x = 868.39, y = -1639.75, z = 29.33},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker= 1,
			Blip  = true,
			Name  = _U('fm_fish_locker'),
			Type  = "cloakroom",
			Hint  = _U('cloak_change'),
			GPS = {x = 880.74, y = -1663.96, z = 29.37}
		},

		FishingSpot = {
			Pos   = {x = 4435.21, y = 4829.60, z = 0.34},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 110.0, y = 110.0, z = 10.0},
			Marker= 1,
			Blip  = true,
			Name  = _U('fm_fish_area'),
			Type  = "work",
			Hint  = _U('fm_fish_button'),
			GPS   = {x = 3859.43, y = 4448.83, z = 0.39},
			Item = {
				{
					name   = _U('fm_fish'),
					db_name= "fish",
					time   = 2000,
					max    = 100,
					add    = 1,
					remove = 1,
					requires = "nothing",
					requires_name = "Nothing",
					drop   = 100
				}
			},

		},

		BoatSpawner = {
			Pos   = {},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker= 1,
			Blip  = true,
			Name  = _U('fm_spawnboat_title'),
			Type  = "vehspawner",
			Spawner = 2,
			Hint  = _U('fm_spawnboat'),
			Caution = 0,
			GPS = {}
		},

		BoatSpawnPoint = {
			Pos   = {},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Marker= -1,
			Blip  = false,
			Name  = _U('fm_boat_title'),
			Type  = "vehspawnpt",
			Spawner = 2,
			GPS = 0,
			Heading = 270.1
		},

		BoatDeletePoint = {
			Pos   = {},
			Size  = {x = 10.0, y = 10.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker= 1,
			Blip  = false,
			Name  = _U('fm_boat_return_title'),
			Type  = "vehdelete",
			Hint  = _U('fm_boat_return_button'),
			Spawner = 2,
			Caution = 0,
			GPS = {x = -1012.64, y = -1354.62, z = 5.54},
			Teleport = {x = 3867.44, y = 4463.62, z = 1.72}
		},

		VehicleSpawner = {
			Pos = {},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U("spawn_veh"),
			Type = "vehspawner",
			Spawner = 1,
			Hint = _U("spawn_veh_button"),
			Caution = 2000,
			GPS = {}
		},

		VehicleSpawnPoint = {
			Pos = {},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 1,
			Heading = 90.1,
			GPS = 0
		},

		VehicleDeletePoint = {
			Pos = {},
			Size = {x = 5.0, y = 5.0, z = 1.0},
			Color = {r = 255, g = 0, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U("return_vh"),
			Type = "vehdelete",
			Hint = _U("return_vh_button"),
			Spawner = 1,
			Caution = 2000,
			GPS = 0,
			Teleport = 0
		},

		Delivery = {
			Pos   = {x = -1012.64, y = -1354.62, z = 5.54},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Marker= 1,
			Blip  = true,
			Name  = _U('delivery_point'),
			Type  = "delivery",
			Spawner = 2,
			Hint  = _U('fm_deliver_fish'),
			GPS   = {x = 3867.44, y = 4463.62, z = 1.72},
			Item = {
				{
				name   = _U('delivery'),
				time   = 500,
				remove = 1,
				max    = 100, -- if not present, probably an error at itemQtty >= item.max in esx_jobs_sv.lua
				price  = 11,
				requires = "fish",
				requires_name = _U('fm_fish'),
				drop   = 100
				}
			}
		}

	}
}
