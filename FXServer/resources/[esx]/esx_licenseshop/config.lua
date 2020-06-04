Config = {}
Config.Locale = 'en'

Config.MarkerType   = 1
Config.DrawDistance = 100.0
Config.MarkerSize   = {x = 1.25, y = 1.25, z = 1.0}
Config.MarkerColor  = {r = 102, g = 102, b = 204}

Config.PlanodeSaudeLicensePrice = 3500

Config.EnablePeds = true -- If true then it will add Peds on Markers | false does the Opposite.

Config.Locations = {
	{ x = 303.41, y = -597.94, z = 42.3, heading = 148.29 } -- Next to esx_dmvschool
}

Config.Zones = {}

for i=1, #Config.Locations, 1 do
	Config.Zones['Shop_' .. i] = {
		Pos   = Config.Locations[i],
		Size  = Config.MarkerSize,
		Color = Config.MarkerColor,
		Type  = Config.MarkerType
	}
end
