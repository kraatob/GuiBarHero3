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

Config.gcd_spells = {"Hamstring", "Azure Strike"}
Config.enrage_auras = {"Enrage"}

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
--Evoker Begin
	["Pyre"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
	},
	["Disintegrate"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
	},
	["Living Flame"] = {
		{
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.red,
			need_target = true,
		}, {
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.red,
			need_target = true,
			dim_on_missing_buff = "Burnout",
		},
	},
	["Fire Breath"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
	},
	["Eternity Surge"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
	},
	["Dragonrage"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
		show_buff = true,
	},
	["Tip the Scales"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.violet,
		show_buff = true,
	},
	["Blessing of the Bronze"] = Config.template.self_buff({"Blessing of the Bronze"}),
--Evoker End
--Warlock Begin
	["Immolate"] = Config.template.debuff(nil, {}, "Immolate", true),
	["Chaos Bolt"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		show_buff_count = "Backdraft",
	},
	["Conflagrate"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		show_charges = true,
		dim_on_charges = 1,
	},
	["Summon Infernal"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
	},
	["Cataclysm"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
	},
	["Agony"] = Config.template.debuff(nil, {}, "Agony", true),
	["Unstable Affliction"] = Config.template.debuff(nil, {}, "Unstable Affliction", true),
	["Corruption"] = Config.template.debuff(nil, {}, "Corruption", true),
	["Malefic Rapture"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		min_shards = 5,
		also_lit_on_aura = "Tormented Crescendo",
	},
	["Vile Taint"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
	},
	["Soul Rot"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
	},
--Warlock End
--Warrior Begin
	["Bloodthirst"] = {
		alias = "Bloodbath",
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		show_buff_count = "Merciless Assault",
	},
	["Bloodbath"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		show_buff_count = "Merciless Assault",
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
		{
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.red,
			need_target = false,
			show_buff_count = "Whirlwind",
		}, {
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.orange,
			show_buff_count = "Whirlwind",
			dim_on_buff = "Whirlwind",
		}
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
	["Onslaught"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.orange,
		need_target = true,
	},

	["Victory Rush"] = Config.template.attack,
	["Impending Victory"] = Config.template.attack,
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
	["Slam"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
	},
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
	["Spear of Bastion"] = {
		{
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.blue,
			dim_unless_enrage = true,
		},
		{
			type = "COOLDOWN",
			note = "RIGHT",
			color = Colors.blue,
		},
	},
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
	["Spell Block"] = {
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
		show_buff_count = "Reckless Abandon",
	},
	["Crushing Blow"] = {
		type = "COOLDOWN",
		note = "RIGHT",
		color = Colors.red,
		need_target = true,
		dim_on_charges = 1,
		show_buff_count = "Reckless Abandon",
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
		show_buff = "Hurricane",
		show_buff_count = "Hurricane",
	},
	["Rend"] = Config.template.debuff(nil, {}, "Rend", true),
--Warrior End

	["Trinket 1"] = Config.template.slot_item("Trinket0Slot"),
	["Trinket 2"] = Config.template.slot_item("Trinket1Slot"),
}

GuiBarHero.Config = Config
