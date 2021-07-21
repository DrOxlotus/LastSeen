local addonName, addonTable = ...
local L = addonTable.L

-- These are items that don't need to be tracked because people won't care.
-- Examples: Anima, Cataloged Research, Azerite, etc.
local ignoredItems = {
}

addonTable.ignoredItems = ignoredItems