Config = {}

Config.Animations = {

	{
		name  = 'festives',
		label = 'Festivas',
		items = {
			{label = "Fumar Cigarro", type = "scenario", data = {anim = "WORLD_HUMAN_SMOKING"}},
			{label = "Tocar Instrumento", type = "scenario", data = {anim = "WORLD_HUMAN_MUSICIAN"}},
			{label = "Dj", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@dj", anim = "dj"}},
			{label = "Air Guitar", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@air_guitar", anim = "air_guitar"}},
			{label = "Sarrada", type = "anim", data = {lib = "anim@mp_player_intcelebrationfemale@air_shagging", anim = "air_shagging"}},
			{label = "Rock'n'roll", type = "anim", data = {lib = "mp_player_int_upperrock", anim = "mp_player_int_rock"}},
			{label = "Vomitar(Carro)", type = "anim", data = {lib = "oddjobs@taxi@tie", anim = "vomit_outside"}},
		}
	},

	{
		name  = 'greetings',
		label = 'Saudações',
		items = {
			{label = "Comprimentar", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_hello"}},
			{label = "Apertar as Mãos", type = "anim", data = {lib = "mp_common", anim = "givetake1_a"}},
			{label = "Acenar", type = "anim", data = {lib = "mp_ped_interaction", anim = "handshake_guy_a"}},
			{label = "Saudação de Bandido", type = "anim", data = {lib = "mp_ped_interaction", anim = "hugs_guy_a"}},
			{label = "Continência de Militar", type = "anim", data = {lib = "mp_player_int_uppersalute", anim = "mp_player_int_salute"}},
		}
	},

	{
		name  = 'work',
		label = 'Trabalho',
		items = {
			{label = "Pescar", type = "scenario", data = {anim = "world_human_stand_fishing"}},
			{label = "Polícia : Investigar", type = "anim", data = {lib = "amb@code_human_police_investigate@idle_b", anim = "idle_f"}},
			{label = "Polícia : Ficar de Guarda", type = "scenario", data = {anim = "WORLD_HUMAN_GUARD_STAND"}},
			{label = "Agricultura : Plantar", type = "scenario", data = {anim = "world_human_gardener_plant"}},
			{label = "Médico: Observar", type = "scenario", data = {anim = "CODE_HUMAN_MEDIC_KNEEL"}},
			{label = "Táxi : Falar com o client", type = "anim", data = {lib = "oddjobs@taxi@driver", anim = "leanover_idle"}},
			{label = "Táxi : Passar a conta", type = "anim", data = {lib = "oddjobs@taxi@cyi", anim = "std_hand_off_ps_passenger"}},
			{label = "Barman : Servir um shot", type = "anim", data = {lib = "mini@drinking", anim = "shots_barman_b"}},
			{label = "Journalista : Tirar foto", type = "scenario", data = {anim = "WORLD_HUMAN_PAPARAZZI"}},
		}
	},

	{
		name  = 'humors',
		label = 'Humor',
		items = {
			{label = "Aplaudir", type = "scenario", data = {anim = "WORLD_HUMAN_CHEERING"}},
			{label = "Você é o cara!", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_point"}},
			{label = "Qual foi?", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_come_here_soft"}}, 
			{label = "Eu", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_me"}},
			{label = "Pegar e colocar no bolso", type = "anim", data = {lib = "anim@am_hold_up@male", anim = "shoplift_high"}},
			{label = "Mão na cara", type = "anim", data = {lib = "anim@mp_player_intcelebrationmale@face_palm", anim = "face_palm"}},
			{label = "Calma ai", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_easy_now"}},
			{label = "Chamar para briga?", type = "anim", data = {lib = "oddjobs@assassinate@multi@", anim = "react_big_variations_a"}},
			{label = "Apavorar", type = "anim", data = {lib = "amb@code_human_cower_stand@male@react_cowering", anim = "base_right"}},
			{label = "Luta ?", type = "anim", data = {lib = "anim@deathmatch_intros@unarmed", anim = "intro_male_unarmed_e"}},
			{label = "Poxa vida!", type = "anim", data = {lib = "gestures@m@standing@casual", anim = "gesture_damn"}},
			{label = "Beijar", type = "anim", data = {lib = "mp_ped_interaction", anim = "kisses_guy_a"}},
			{label = "Dedo do meio", type = "anim", data = {lib = "mp_player_int_upperfinger", anim = "mp_player_int_finger_01_enter"}},
			{label = "Punheta", type = "anim", data = {lib = "mp_player_int_upperwank", anim = "mp_player_int_wank_01"}},
			{label = "Tiro na cabeça", type = "anim", data = {lib = "mp_suicide", anim = "pistol"}},
		}
	},

	{
		name  = 'sports',
		label = 'Esportes',
		items = {
			{label = "Mostrar os músculos", type = "anim", data = {lib = "amb@world_human_muscle_flex@arms_at_side@base", anim = "base"}},
			{label = "Barra de musculação", type = "anim", data = {lib = "amb@world_human_muscle_free_weights@male@barbell@base", anim = "base"}},
			{label = "Fazer flexões", type = "anim", data = {lib = "amb@world_human_push_ups@male@base", anim = "base"}},
			{label = "Fazer abdominal", type = "anim", data = {lib = "amb@world_human_sit_ups@male@base", anim = "base"}},
			{label = "Fazer yoga", type = "anim", data = {lib = "amb@world_human_yoga@male@base", anim = "base_a"}},
		}
	},

	{
		name  = 'misc',
		label = 'Divers',
		items = {
			{label = "beber Café", type = "anim", data = {lib = "amb@world_human_aa_coffee@idle_a", anim = "idle_a"}},
			{label = "Inquieto", type = "anim", data = {lib = "anim@heists@prison_heistunfinished_biztarget_idle", anim = "target_idle"}},
			{label = "Enconstar", type = "scenario", data = {anim = "world_human_leaning"}},
			{label = "Deitar virado para o sol", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE_BACK"}},
			{label = "Deitar virado para o chão", type = "scenario", data = {anim = "WORLD_HUMAN_SUNBATHE"}},
			{label = "Limpar", type = "scenario", data = {anim = "world_human_maid_clean"}},
			{label = "Preparar Churrasco", type = "scenario", data = {anim = "PROP_HUMAN_BBQ"}},
			{label = "Bater uma selfie", type = "scenario", data = {anim = "world_human_tourist_mobile"}},
			{label = "Encostar na porta", type = "anim", data = {lib = "mini@safe_cracking", anim = "idle_base"}}, 
		}
	},

	{
		name  = 'attitudem',
		label = 'Atitudes',
		items = {
			{label = "Normal M", type = "attitude", data = {lib = "move_m@confident", anim = "move_m@confident"}},
			{label = "Normal F", type = "attitude", data = {lib = "move_f@heels@c", anim = "move_f@heels@c"}},
			{label = "Depressivo M", type = "attitude", data = {lib = "move_m@depressed@a", anim = "move_m@depressed@a"}},
			{label = "Depressiva F", type = "attitude", data = {lib = "move_f@depressed@a", anim = "move_f@depressed@a"}},
			{label = "Negócios", type = "attitude", data = {lib = "move_m@business@a", anim = "move_m@business@a"}},
			{label = "Determinado", type = "attitude", data = {lib = "move_m@brave@a", anim = "move_m@brave@a"}},
			{label = "Casual", type = "attitude", data = {lib = "move_m@casual@a", anim = "move_m@casual@a"}},
			{label = "Gordo", type = "attitude", data = {lib = "move_m@fat@a", anim = "move_m@fat@a"}},
			{label = "Hipster", type = "attitude", data = {lib = "move_m@hipster@a", anim = "move_m@hipster@a"}},
			{label = "Intimidador", type = "attitude", data = {lib = "move_m@hurry@a", anim = "move_m@hurry@a"}},
			{label = "Musculoso", type = "attitude", data = {lib = "move_m@muscle@a", anim = "move_m@muscle@a"}},
			{label = "Sombrio", type = "attitude", data = {lib = "move_m@shadyped@a", anim = "move_m@shadyped@a"}},
			{label = "Fatigado", type = "attitude", data = {lib = "move_m@buzzed", anim = "move_m@buzzed"}},
			{label = "Apressado", type = "attitude", data = {lib = "move_m@hurry_butch@a", anim = "move_m@hurry_butch@a"}},
			{label = "Riquinho", type = "attitude", data = {lib = "move_m@money", anim = "move_m@money"}},
			{label = "Corridinha", type = "attitude", data = {lib = "move_m@quick", anim = "move_m@quick"}},
			{label = "Sedutora F", type = "attitude", data = {lib = "move_f@maneater", anim = "move_f@maneater"}},
			{label = "Impertinente F", type = "attitude", data = {lib = "move_f@sassy", anim = "move_f@sassy"}},	
			{label = "Arrogante F", type = "attitude", data = {lib = "move_f@arrogant@a", anim = "move_f@arrogant@a"}},
		}
	},
	
	{
        name  = 'hakanonur07',
        label = 'Danças (Masculino)',
        items = {
        {label = "--- DANÇAS 1 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_09_v2_male^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_09_v2_male^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_09_v2_male^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_09_v2_male^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_09_v2_male^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_09_v2_male^6"}},
        {label = "--- DANÇAS 2 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_11_v1_male^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_11_v1_male^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_11_v1_male^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_11_v1_male^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_11_v1_male^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_11_v1_male^6"}},
        {label = "--- DANÇAS 3 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_13_v2_male^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_13_v2_male^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_13_v2_male^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_13_v2_male^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_13_v2_male^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_13_v2_male^6"}},
        {label = "--- DANÇAS 4 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v1_male^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v1_male^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v1_male^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v1_male^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v1_male^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v1_male^6"}},
        {label = "--- DANÇAS 5 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v2_male^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v2_male^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v2_male^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v2_male^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v2_male^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_15_v2_male^6"}},
        {label = "--- DANÇAS 6 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v1_male^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v1_male^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v1_male^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v1_male^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v1_male^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v1_male^6"}},
        {label = "--- DANÇAS 7 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_male^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v2_male^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v2_male^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v2_male^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v2_male^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v2_male^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "mi_dance_crowd_17_v2_male^6"}},
    
        
             
        }
    },
	
	{
        name  = 'hakanonur3',
        label = 'Danças (Femininas)',
        items = {
        {label = "--- DANÇAS 1 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v1_female^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v1_female^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v1_female^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v1_female^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v1_female^5"}},
        {label = "--- DANÇAS 2 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v2_female^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v2_female^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v2_female^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v2_female^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v2_female^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_09_v2_female^6"}},
        {label = "--- DANÇAS 3 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_11_v1_female^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_11_v1_female^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_11_v1_female^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_11_v1_female^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_11_v1_female^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_11_v1_female^6"}},
        {label = "--- DANÇAS 4 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_13_v2_female^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_13_v2_female^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_13_v2_female^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_13_v2_female^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_13_v2_female^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_13_v2_female^6"}},
        {label = "--- DANÇAS 5 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v1_female^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v1_female^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v1_female^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v1_female^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v1_female^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v1_female^6"}},
        {label = "--- DANÇAS 6 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v2_female^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v2_female^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v2_female^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v2_female^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v2_female^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_15_v2_female^6"}},
        {label = "--- DANÇAS 7 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v1_female^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v1_female^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v1_female^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v1_female^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v1_female^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v1_female^6"}},
        {label = "--- DANÇAS 8 ---", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_single_props_transitions@from_hi_intensity", anim = "trans_crowd_prop_hi_to_li_09_v1_female^6"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v2_female^1"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v2_female^2"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v2_female^3"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v2_female^4"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v2_female^5"}},
        {label = "Dança", type = "anim", data = {lib = "anim@amb@nightclub@dancers@crowddance_groups@", anim = "li_dance_crowd_17_v2_female^6"}},

        
             
        }
    },
	
	{
		name  = 'porn',
		label = '+ 18',
		items = {
			{label = "Receber Boquete(Carro)", type = "anim", data = {lib = "oddjobs@towing", anim = "m_blow_job_loop"}},
			{label = "Pagar Boquete(Carro)", type = "anim", data = {lib = "oddjobs@towing", anim = "f_blow_job_loop"}},
			{label = "Receber Boquete", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_player"}},
			{label = "Boquete Boquete", type = "anim", data = {lib = "mini@prostitutes@sexlow_veh", anim = "low_car_sex_loop_female"}},
			{label = "Coçar o saco", type = "anim", data = {lib = "mp_player_int_uppergrab_crotch", anim = "mp_player_int_grab_crotch"}},
			{label = "Seduzir", type = "anim", data = {lib = "mini@strip_club@idles@stripper", anim = "stripper_idle_02"}},
			{label = "Pose Mulher", type = "scenario", data = {anim = "WORLD_HUMAN_PROSTITUTE_HIGH_CLASS"}},
			{label = "Balançar peito", type = "anim", data = {lib = "mini@strip_club@backroom@", anim = "stripper_b_backroom_idle_b"}},
			{label = "Strip Tease 1", type = "anim", data = {lib = "mini@strip_club@lap_dance@ld_girl_a_song_a_p1", anim = "ld_girl_a_song_a_p1_f"}},
			{label = "Strip Tease 2", type = "anim", data = {lib = "mini@strip_club@private_dance@part2", anim = "priv_dance_p2"}},
			{label = "Stip Tease ao sol", type = "anim", data = {lib = "mini@strip_club@private_dance@part3", anim = "priv_dance_p3"}},
		}
	}
}