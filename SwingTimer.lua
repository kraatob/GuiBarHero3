local SwingTimer = {}
local SwingTimer_mt = { __index = SwingTimer }

function SwingTimer:Release()
	self.frame:UnregisterAllEvents()
	self.frame:SetScript("OnEvent", nil)
end

function SwingTimer:Create(frame)
	swing_timer = {}
	setmetatable(swing_timer, SwingTimer_mt)
	SwingTimer:Initialize(frame)
	return swing_timer
end

function SwingTimer:Initialize(frame)
	self.last_swing = 0
	self.frame = frame
	frame.owner = swing_timer
	frame:SetScript("OnEvent", SwingTimer.OnEvent)
	frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
    self.player_guid = UnitGUID("player")
end

function SwingTimer:OnEvent(event)
	self = self.owner
    if event == "COMBAT_LOG_EVENT_UNFILTERED" then
        self:OnCombatLogEvent()
    end
end

function SwingTimer:OnCombatLogEvent()
    local combat_info = {CombatLogGetCurrentEventInfo()}
    local _, event, _, source_guid, _, _, _, _, _, _, _, extra_info = unpack(combat_info)
    if source_guid == self.player_guid then
        if event == "SWING_DAMAGE" then
            local _, _, _, _, _, _, _, _, _, is_offhand = extra_info
            if not is_offhand then
                self.last_swing = GetTime()
            end
        elseif event == "SWING_MISSED" then
            local _, is_offhand = extra_info
            if not is_offhand then
                self.last_swing = GetTime()
            end
        end
    end
end

function SwingTimer:GetNext()
	return self.last_swing + UnitAttackSpeed("player")
end

GuiBarHero.SwingTimer = SwingTimer