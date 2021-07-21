local addonName, addonTable = ...
local L = addonTable.L

-- Item Information Variables
local itemID, itemLink = 0, ""
local ref

local function CheckDataValidity(itemID)
	-- Written by: Arcanemagus (Pull Request)
	if (itemID) then
		ref = LastSeenItems[itemID]
		if (ref["sourceInfo"]["name"]) and (ref["sourceInfo"]["map"]) and (ref["sourceInfo"]["lootDate"]) then
			return true
		else
			return false
		end
	else
		return false
	end
end

local function OnTooltipSetItem(tooltip)
	_, itemLink = tooltip:GetItem()
	_, itemID = strsplit(":", itemLink); itemID = tonumber(itemID)
	if (itemID) then
		if (LastSeenItems[itemID]) then
			-- It may not be the most elegant solution, but we don't want to put our text in the tooltip if it exists.
			-- This is particularly noticeable on recipe tooltips.
			local tooltipFrame, tooltipText
			for i = 1, 30 do
				tooltipFrame = _G[tooltip:GetName() .. "TextLeft" .. i]
				if (tooltipFrame) then
					tooltipText = tooltipFrame:GetText()
					if (tooltipText) then
						if (string.find(tooltipText, addonName)) then
							return
						end
					end
				end
			end
			-- Assuming we didn't return from the check above, let's add the discovered information to the tooltip!
			if (CheckDataValidity(itemID)) then
				tooltip:AddDoubleLine(addonName, "(" .. ref["sourceInfo"]["name"] .. ", " .. ref["sourceInfo"]["map"] .. ", " .. ref["sourceInfo"]["lootDate"] .. ")", 0, 204, 255, 255, 255, 255)
				tooltip:Show()
			end
		end
	end
end

addonTable.OnTooltipSetItem = OnTooltipSetItem