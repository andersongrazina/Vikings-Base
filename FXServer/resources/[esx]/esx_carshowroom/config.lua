Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 255, g = 255, b = 255 }
--language currently available EN and SV
Config.Locale                     = 'en'
--this is how much the price shows from the purchase price
-- exapmle the cardealer boughts it for 2000 if 2 then it says 4000
Config.Price = 2 -- this is times how much it should show

Config.Zones = {

  ShopInside = {
    Pos     = { x = 228.26 , y = -986.57, z = -99.96 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 177.28,
    Type    = -1,
  },

  Katalog = {
    Pos     = { x = -57.4 , y = -1097.08, z = 25.43 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 177.28,
    Type    = 27,
  },

}