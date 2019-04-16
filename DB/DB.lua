------------------------------------------------------------
-- LastSeen (DB) | Oxlotus - Area 52 (US) | Copyright © 2019
------------------------------------------------------------
-- This file stores all of the addon's foundational data.

local addonName, addonTable = ...;

local ItemQualities = {
	[0] = "9d9d9d",
	[1] = "ffffff",
	[2] = "1eff00",
	[3] = "0070dd",
	[4] = "a335ee",
	[5] = "ff8000",
	[6] = "e6cc80",
	[7] = "e6cc80",
	[8] = "00ccff",
};

local LastSeenItems = {};
local LastSeenIgnore = {};
local ItemIDCache = {};

addonTable.ItemQualities = ItemQualities;
addonTable.LastSeen = IsAddOnLoaded(addonName);
addonTable.LastSeenItems = LastSeenItems;
addonTable.LastSeenIgnore = LastSeenIgnore;
addonTable.LastSeenItemIDCache = ItemIDCache;