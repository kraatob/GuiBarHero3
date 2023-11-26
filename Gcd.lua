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
	self.slot = GuiBarHero.Utils:FindFirstSpell(GuiBarHero.Config.gcd_spells)
	self.next_gcd = 0
	self.duration = 1.5
	self.frame = frame
	frame.owner = gcd
	frame:SetScript("OnEvent", Gcd.OnEvent)
	frame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
end

function Gcd:OnEvent()
	self = self.owner
	local success, start, duration = pcall(GetSpellCooldown, self.slot, BOOKTYPE_SPELL)
	if success and start and duration then
		self.next_gcd = start + duration
		self.duration = duration
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
