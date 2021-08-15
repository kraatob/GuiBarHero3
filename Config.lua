local Colors = {
	black = { 0, 0, 0 },
	red = { 1, 0.14, 0 },
	blue = { 0.02, 0.45, 1 },
	green = { 0, 1, 0.3 },
	yellow = { 1, 0.9, 0.1 },
	orange = { 0.9, 0.62, 0 },
	lightblue = { 0.3, 0.6, 1 },
	violet = { 1, 0.28, 0.6 },
}

local Config = {}

Config.template = {
	none = {
		type = "NONE",
		note = "CENTER",
		color = Colors.black,
	},
	default = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.blue,
	},
	attack = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
	},
	instant_aoe = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.blue,
	},
	reactive = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
	},
	self_buff = function(shared) 
		return {
			type = "SELFBUFF",
			note = "CENTER",
			color = Colors.yellow,
			shared_buffs = shared or {},
		}
	end,
	dot = {
		type = "DEBUFF",
		note = "CENTER",
		color = {1, 0.3, 0},
		subtract_cast_time = true,
	},
	debuff = function(count, shared, debuff_name, left)
		return { type = "DEBUFF",
			note = left and "LEFT" or (count and "LEFT" or "CENTER"),
			color = Colors.green,
			stacks = count or 0,
			shared_buffs = shared or {},
			show_stack_count = count,
			show_debuff = debuff_name,
			needs_target = true,
			note_at_end = left,
		}
	end,
	melee = function(rage) 
		return {
			type = "COOLDOWN",
			note = "RIGHT",
			color = { 1, 1, 1 },
			need_target = true,
			min_rage = rage,
		} 
	end,
	slot_item = function(slot_name)
		return { 
			type = "SLOTITEM",
			note = "RIGHT",
			color = Colors.lightblue,
			slot_id = GetInventorySlotInfo(slot_name),
		}
	end,
}

Config.gcd_spells = {"Whirlwind"}
Config.enrage_auras = {"Enrage"}

Config.unknown_spells = {"Execute", "Whirlwind", "Revenge", "Condemn", "Warbreaker"}

Config.spells = {
--Druid Begin
	["Solar Beam"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.yellow,
		need_target = true,
	},	
	["Cenarion Ward"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.yellow,
	},		
	["Nature's Swiftness"] = {
		type = "SELFBUFF",
		note = "RIGHT",
		color = Colors.blue,
	},	
	["Ironbark"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
	},
	["Barkskin"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
	},	
	["Convoke the Spirits"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
	},		
--Druid End

--Death Knight Begin
	["Anti-Magic Shell"] = {
		type = "SELFBUFF",
		note = "RIGHT",
		color = Colors.green,
		show_buff = true,
	},
	["Icebound Fortitude"] = {
		type = "SELFBUFF",
		note = "RIGHT",
		color = Colors.blue,
		show_buff = true,
	},	
	["Mind Freeze"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.yellow,
		need_target = true,
	},	
	["Dark Transformation"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
	},		
	["Abomination Limb"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
	},		
--Death Knight End	
--Warrior Begin
	["Bloodthirst"] = {
		alias = "Bloodbath",
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
	},
	["Bloodbath"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
	},
	["Charge"] = {
		type = "COOLDOWN",
		ignore_usable = true,
		need_target = true,
	},
	["Warbreaker"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
		need_target = true,
		show_debuff = "Colossus Smash",
	},	
	["Colossus Smash"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
		need_target = true,
		show_debuff = "Colossus Smash",
	},	
	["Enrage"] = {
		type = "SELFBUFF",
		note = "NONE",
		color = Colors.yellow,
		invert = true,
	},
	["Whirlwind"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = false,
		show_buff_count = "Whirlwind",
		dim_on_missing_buff = "Whirlwind",
	},
	["Execute"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
		need_target = true,
		hide_on_dim = true,
	},
	["Condemn"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
		need_target = true,
		hide_on_dim = true,
		use_spell_for_usability = "Execute",
	},
	["Overpower"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		dim_on_charges = 1,
	},
	["Mortal Strike"] = {
		{
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.red,
			need_target = true,
			show_buff_count = "Overpower",
			-- dim_on_missing_buff = "Overpower",
			-- dim_on_missing_buff_count = 2,
		}, {
			type = "DEBUFF",
			note = "LEFT",
			color = Colors.green,
			show_debuff = "Deep Wounds",
			ignore_usable = true,
			-- dim_on_missing_buff = "Overpower",
			-- dim_on_missing_buff_count = 2,
		},
	},

	["Victory Rush"] = Config.template.attack,
	["Battle Shout"] = {
		Config.template.self_buff({"Horn of Winter", "Roar of Courage", "Trueshot Aura"}),
		{
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.orange,
			max_rage = 70,
		}
	},
	["Devastate"] = Config.template.attack,
	["Revenge"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		dim_on_missing_buff = "Revenge!",
	},
	["Shield Slam"] = Config.template.attack,
	["Bladestorm"] = {
		{
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.orange,
			dim_unless_enrage = true,
			show_buff = true,
		},
		{
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.orange,
			show_buff = true,
		},
	},
	["Shockwave"] = Config.template.instant_aoe,
	["Sweeping Strikes"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
		show_buff = true,
	},
	["Deadly Calm"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
		min_rage = 60
	},
	["Retaliation"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
		need_target = false,
	},
	["Recklessness"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
		show_buff = true,
	},
	["Rampage"] = {
		type = "SELFBUFF",
		color = Colors.orange,
	},
	["Shield Block"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
		need_no_aura = "Shield Block",
		show_charges = true,
		dim_on_charges = 1,
		dim = true,
	},
	["Shield Wall"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.blue,
		show_buff = true,
	},
	["Demoralizing Shout"] = Config.template.debuff(nil, {}, "Demoralizing Shout"),
	["Hamstring"] = Config.template.debuff(),
	["Thunder Clap"] = { Config.template.debuff(nil, {}), Config.template.instant_aoe },
	["Raging Blow"] = {
		alias = "Crushing Blow",
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		dim_on_charges = 1,
	},
	["Crushing Blow"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		dim_on_charges = 1,
	},
	["Blood Fury"] = { 
		type = "COOLDOWN",
		note = "RIGHT",
		color = { 0.5, 0.5, 1 },
		show_buff = true,
	},
	["Berserker Rage"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
		dim_on_enrage = true,
	},
	["Avatar"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
		show_buff = true,
	},
	["Pummel"] = Config.template.attack,
	["Siegebreaker"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
		need_target = true,
		show_debuff = "Siegebreaker",
	},
	["Ravager"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
	},
	["Rend"] = Config.template.debuff(nil, {}, "Rend", true),
--Warrior End
	["Shadow Bolt"] = Config.template.attack,
	["Immolate"] = Config.template.dot,
	["Corruption"] = Config.template.dot,
	["Bane of Agony"] = Config.template.dot,
	["Conflagrate"] = Config.template.attack,

	["Trinket 1"] = Config.template.slot_item("Trinket0Slot"),
	["Trinket 2"] = Config.template.slot_item("Trinket1Slot"),
}

GuiBarHero.Config = Config
