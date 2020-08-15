local addon, tbl = ...;
local L = tbl.L;

-- TODO: Reconsider the approach to ignoring specific items.
local ignoredItems = {
	[11736] 		= "Libram of Resilience",
	[21218] 		= "Blue Qiraji Resonating Crystal",
    [21321] 		= "Red Qiraji Resonating Crystal",
    [21323] 		= "Green Qiraji Resonating Crystal",
    [21324] 		= "Yellow Qiraji Resonating Crystal",
	[137642]		= "Mark of Honor",
	[141605] 		= "Flight Master's Whistle",
	[143785]		= "Tome of the Tranquil Mind",
	[163611]		= "Seafarer's Coin Pouch",
	[163612]		= "Wayfinder's Satchel",
	[163613]		= "Sack of Plunder",
	[166846]		= "Spare Parts",
	[168416]		= "Anglers' Water Striders",
	[168822]		= "Thin Jelly",
	[168825]		= "Rich Jelly",
	[168828]		= "Purple Jelly",
	[171305]		= "Salvaged Cache of Goods",
	[173363]		= "Vessel of Horrific Visions",
	[174758]		= "Voidwarped Relic Fragment",
	[174759]		= "Mogu Relic Fragment",
};

tbl.ignoredItems = ignoredItems;