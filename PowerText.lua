local PowerTextFrame = CreateFrame("Frame", "PowerTextFrame", UIParent)
PowerTextFrame:SetWidth(120) 
PowerTextFrame:SetHeight(42) 

PowerTextFrame:SetMovable(true)
PowerTextFrame:EnableMouse(true)
PowerTextFrame:RegisterForDrag("LeftButton")
PowerTextFrame:SetScript("OnDragStart", function() PowerTextFrame:StartMoving() end)
PowerTextFrame:SetScript("OnDragStop", function() PowerTextFrame:StopMovingOrSizing() end)

PowerTextFrame:SetBackdrop({
	bgFile = "Interface/Tooltips/UI-Tooltip-Background",
	edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
	edgeSize = 8,
	insets = { left = 4, right = 4, top = 4, bottom = 4 },
})
PowerTextFrame:SetBackdropColor(0, 0, 1, .3)

PowerTextFrame:SetPoint("CENTER", 0, 0)
PowerTextFrame:Show()

PowerTextFrame:SetScript("OnLoad", PowerText_EventFrame_OnLoad)


local function PowerText_EventFrame_OnEvent() 	
	if event == "VARIABLES_LOADED" then
		this:UnregisterEvent("VARIABLES_LOADED")		
		PowerText_Initialize()	
	elseif event == "UNIT_MANA" or event == "UNIT_ENERGY" or event == "UNIT_RAGE" then		
		PowerText_UpdateText()
	elseif event == "UNIT_ATTACK_POWER" then		
		PowerText_UpdateText()
	end
	
end

local function PowerText_UpdateText()
	local base, posBuff, negBuff = UnitAttackPower("player");
	local effective = base + posBuff + negBuff;
	local mana = UnitMana("player").." / "..UnitManaMax("player")
	PowerTextFrame.text:SetText(effective.." AP\n"..mana)		
end
PowerTextFrame:SetScript('OnEvent', function()
    --PowerText_DisplayMessage(event)
    PowerText_EventFrame_OnEvent()
end)
PowerTextFrame:RegisterEvent("VARIABLES_LOADED")
PowerTextFrame:RegisterEvent("ADDON_LOADED")
PowerTextFrame:RegisterEvent("UNIT_MANA")	
PowerTextFrame:RegisterEvent("UNIT_ENERGY")	
PowerTextFrame:RegisterEvent("UNIT_RAGE")	
PowerTextFrame:RegisterEvent("UNIT_ATTACK_POWER")	

function PowerText_EventFrame_OnLoad()	
	
end

function PowerText_Initialize()
	PowerTextFrame.text = PowerTextFrame:CreateFontString(nil,"ARTWORK") 
	PowerTextFrame.text:SetFont("Fonts\\ARIALN.ttf", 230, "OUTLINE")
	PowerTextFrame.text:SetPoint("CENTER",0,0)
	PowerTextFrame.text:SetTextHeight(20)			
	PowerText_UpdateText()
end

function PowerText_Toggle()
	if PowerTextFrame:IsVisible() then
		PowerTextFrame:Hide()
	else
		PowerTextFrame:Show()
	end
end

function PowerText_DisplayMessage(message, r, g, b)
	if r == nil then
		DEFAULT_CHAT_FRAME:AddMessage(message, 0.53, 0.53, 0.93) 
	else
		DEFAULT_CHAT_FRAME:AddMessage(message, r, g, b) 
	end		
end

