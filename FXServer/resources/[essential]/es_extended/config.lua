Config                      = {}
Config.Locale               = 'br'

Config.Accounts             = { 'bank', 'black_money', 'dinheiro_vip' }
Config.AccountLabels        = { bank = _U('bank'), black_money = _U('black_money'), dinheiro_vip = _U('dinheiro_vip') }

Config.EnableSocietyPayouts = true -- pay from the society account that the player is employed at? Requirement: esx_society
Config.ShowDotAbovePlayer   = false
Config.DisableWantedLevel   = true
Config.EnableHud            = true -- enable the default hud? Display current job and accounts (black, bank & cash)

Config.PaycheckInterval     = 20 * 60000
Config.MaxPlayers           = GetConvarInt('sv_maxclients', 32)

Config.EnableDebug          = false
