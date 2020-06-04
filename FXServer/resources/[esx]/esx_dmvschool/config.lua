Config                 = {}
Config.DrawDistance    = 100.0
Config.MaxErrors       = 5
Config.SpeedMultiplier = 3.6
Config.Locale          = 'br'

Config.Prices = {
	dmv         = 150,
	drive       = 1200,
	drive_bike  = 850,
	drive_truck = 2100
}

Config.VehicleModels = {
	drive       = 'blista',
	drive_bike  = 'enduro',
	drive_truck = 'mule3'
}

Config.SpeedLimits = {
	residence = 50,
	town      = 80,
	freeway   = 120
}

Config.Zones = {

	DMVSchool = {
		Pos   = {x = 239.471, y = -1380.960, z = 32.741},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = {x = 249.409, y = -1407.230, z = 30.4094, h = 317.0},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}

}

Config.CheckPoints = {

	{
		Pos = {x = 255.139, y = -1400.731, z = 29.537},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('next_point_speed', Config.SpeedLimits['residence']), 5000)
		end
	},

	{
		Pos = {x = 271.874, y = -1370.574, z = 30.932},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 234.907, y = -1345.385, z = 29.542},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			Citizen.CreateThread(function()
				DrawMissionText(_U('stop_for_ped'), 5000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
				FreezeEntityPosition(vehicle, true)
				Citizen.Wait(4000)

				FreezeEntityPosition(vehicle, false)
				DrawMissionText(_U('good_lets_cont'), 5000)
			end)
		end
	},

	{
		Pos = {x = 217.821, y = -1410.520, z = 28.292},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')

			Citizen.CreateThread(function()
				DrawMissionText(_U('stop_look_left', Config.SpeedLimits['town']), 3000)
				PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
				FreezeEntityPosition(vehicle, true)
				Citizen.Wait(3000)

				FreezeEntityPosition(vehicle, false)
				Citizen.Wait(1000)
				DrawMissionText(_U('good_turn_right'), 5000)
			end)
		end
	},

	{
		Pos = {x = 184.95, y = -1397.56, z = 27.27},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('watch_traffic_lightson'), 5000)
		end
	},

	{
		Pos = {x = 198.08, y = -1357.64, z = 27.725},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 319.1, y = -1325.2, z = 30.09},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(3000)
			FreezeEntityPosition(vehicle, false)
		end
	},

	{
		Pos = {x = 278.21, y = -1396.26, z = 28.12},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 179.49, y = -1403.0, z = 27.35},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('watch_traffic_lightson'), 5000)
		end
	},
	
	{
		Pos = {x = 116.02, y = -1355.28, z = 27.27},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('watch_traffic_lightson'), 5000)
		end
	},
	
	{
		Pos = {x = 85.64, y = -1267.01, z = 27.39},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('freeway')

			DrawMissionText(_U('hway_time', Config.SpeedLimits['freeway']), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
		end
	},

	{
		Pos = {x = 451.58, y = -1233.4, z = 39.34},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},

	{
		Pos = {x = 779.32, y = -1245.69, z = 25.62},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('stop_for_passing'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
			FreezeEntityPosition(vehicle, true)
			Citizen.Wait(3000)
			FreezeEntityPosition(vehicle, false)
		end
	},
	
	{
		Pos = {x = 832.58, y = -1245.4, z = 24.56},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},
	
	{
		Pos = {x = 717.35, y = -1248.19, z = 42.75},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},
	
	{
		Pos = {x = 837.09, y = -1221.23, z = 43.43},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point'), 5000)
		end
	},
	
	{
		Pos = {x = 980.05, y = -1242.98, z = 40.1},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('go_next_point_reduce'), 5000)
		end
	},

	{
		Pos = {x = 1046.46, y = -1627.44, z = 27.27},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			setCurrentZoneType('town')
			DrawMissionText(_U('in_town_speed', Config.SpeedLimits['town']), 5000)
		end
	},

	{
		Pos = {x = 1046.49, y = -1749.52, z = 33.67},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			DrawMissionText(_U('gratz_stay_alert'), 5000)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
		end
	},

	{
		Pos = {x = 235.283, y = -1398.329, z = 28.921},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
		end
	}

}
