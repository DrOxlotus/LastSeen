local addonName, addonTable = ...
local L = addonTable.L

-- These are items that don't need to be tracked because people won't care.
-- Examples: Anima, Cataloged Research, Azerite, etc.
local ignoredItems = {
	-- Shadowlands
	184147, -- Agony Enrichment Device
	186201, -- Ancient Anima Vessel
	187349, -- Anima Laden Egg
	186204, -- Anima-Stained Glass Shards
	186204, -- Anima-Stained Glass Shards
	181540, -- Animaflower Bud
	181540, -- Animaflower Bud
	187517, -- Animaswell Prism
	181477, -- Ardendew Pearl
	184381, -- Astral Sapwood
	184773, -- Battle-Tested Armor Component
	181545, -- Bloodbound Globule
	184150, -- Bonded Tallow Candles
	184152, -- Bottle of Diluted Anima-Wine
	184152, -- Bottle of Diluted Anima-Wine
	181646, -- Bound Failsafe Phylactery
	183723, -- Brimming Anima Orb
	184374, -- Cartel Exchange Vessel
	181541, -- Celestial Acorn
	184768, -- Censer of Dried Gracepetals
	181368, -- Centurion Power Core
	184766, -- Chronicles of the Paragons
	181552, -- Collected Tithe
	184764, -- Colossus Actuator
	186519, -- Compressed Anima Bubble
	184148, -- Concealed Sinvyr Flask
	184148, -- Concealed Sinvyr Flask
	187347, -- Concentrated Anima
	181544, -- Confessions of Misdeed
	184363, -- Considerations on Courage
	181478, -- Cornucopia of the Winter Court
	184151, -- Counterfeit Ruby Brooch
	181548, -- Darkhaven Soul Lantern
	181551, -- Depleted Stoneborn Heart
	184383, -- Duskfall Tuber
	181645, -- Engorged Monstrosity's Heart
	184294, -- Ethereal Ambrosia
	184286, -- Extinguished Soul Anima
	184378, -- Faeweald Amber
	181744, -- Forgelite Ember
	181745, -- Forgesmith's Coal
	184385, -- Fossilized Heartwood
	186203, -- Glowing Devourer Stomach
	184777, -- Gravedredger's Shovel
	184767, -- Handheld Soul Mirror
	184384, -- Hibernal Sproutling
	181550, -- Hopebreaker's Field Injector
	181377, -- Illustrated Combat Meditation Aid
	186200, -- Infused Dendrite
	184774, -- Juvenile Sporespindle
	187434, -- Lightseed Sapling
	184382, -- Luminous Sylberry
	187432, -- Magifocus Heartwood
	184307, -- Maldraxxi Armor Scraps
	184305, -- Maldraxxi Champion's Armaments
	181546, -- Mature Cryptbloom
	184387, -- Misty Shimmerleaf
	184763, -- Mnemis Neural Network
	184315, -- Multi-Modal Anima Container
	184360, -- Musings on Repetition
	184386, -- Nascent Sporepod
	184775, -- Necromancy for the Practical Ritualist
	181547, -- Noble's Draught
	181642, -- Novice Principles of Plaguistry
	181743, -- Plume of the Archon
	184388, -- Plump Glitterroot
	181649, -- Preserved Preternatural Braincase
	184769, -- Pressed Torchlily Blossom
	184379, -- Queen's Frozen Tear
	184362, -- Reflections on Purity
	184771, -- Remembrance Parchment Ash
	183727, -- Resonance of Conflict
	184772, -- Ritual Maldracite Crystal
	184770, -- Roster of the Forgotten
	187175, -- Runekeeper's Ingot
	184293, -- Sanctified Skylight Leaf
	186205, -- Scholarly Attendant's Bangle
	184146, -- Singed Soul Shackles
	184389, -- Slumbering Starseed
	184373, -- Small Anima Globe
	184306, -- Soulcatching Sludge
	181650, -- Spellwarden's Dissertation
	181647, -- Stabilized Plague Strain
	184380, -- Starblossom Nectar
	181479, -- Starlight Catcher
	181549, -- Timeworn Sinstone
	184519, -- Totem of Stolen Mojo
	181644, -- Unlabeled Culture Jars
	184776, -- Urn of Arena Soil
	186206, -- Vault Emberstone
	184765, -- Vesper Strikehammer
	184371, -- Vivacity of Collaboration
	186202, -- Wafting Koricone
	181643, -- Weeping Corpseshroom
	184149, -- Widowbloom-Infused Fragrance
	187433, -- Windcrystal Chimes
	181648, -- Ziggurat Focusing Crystal
}

addonTable.ignoredItems = ignoredItems