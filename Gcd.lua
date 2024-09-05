local Gcd = {}
local Gcd_mt = { __index = Gcd }

function Gcd:Release()
	self.frame:UnregisterAllEvents()
	self.frame:SetScript("OnEvent", nil)
end

function Gcd:Create(frame)
	gcd = {}
	setmetatable(gcd, Gcd_mt)
	Gcd:Initialize(frame)
	return gcd
end

function Gcd:Initialize(frame)
	self.next_gcd = 0
	self.duration = 1.5
	self.frame = frame
	frame.owner = gcd
	frame:SetScript("OnEvent", Gcd.OnEvent)
	frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
end

function Gcd:OnEvent()
	self = self.owner
	local cooldownInfo = C_Spell.GetSpellCooldown(61304)
	if cooldownInfo and cooldownInfo.startTime and cooldownInfo.duration then
		self.next_gcd = cooldownInfo.startTime + cooldownInfo.duration
		self.duration = cooldownInfo.duration
	else
		self.next_gcd = 0
		self.duration = 1.5
	end
end

function Gcd:GetNext()
	return self.next_gcd
end

function Gcd:GetDuration()
	return self.duration
end

GuiBarHero.Gcd = Gcd
