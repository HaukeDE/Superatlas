--[[

	Superatlas OpenStreetMap data processing script for tilemaker
	
	Written by Hauke in 2024
	
	Update history:
	- V1, August 3rd: Intial public version
	
	For detailed explanations, please visit https://projects.webvoss.de

]]--



PreferredLanguageNameKey = "name:de"

-- For basemap.de exclude some landscapes - better in basemap information!
ConfigIncludeAllLandscapes = false
ConfigIncludeDebugInfo = false

-- Nodes will only be processed if one of these keys is present

node_keys = {"building", "historic", "amenity", "megalith_type", "waterway", "emergency", "highway", "leisure", "ford", "man_made", "natural", "landuse", "shelter_type", "sport", "summit:cross", "accomodation", "information", "tourism", "viewpoint", "geological"}

way_keys = {"access", "abandoned:highway", "disused:highway", "bridge", "waterway", "highway", "embankment", "handrail", "barrier", "building", "amenity", "historic", "megalith_type", "leisure", "ford", "man_made", "natural", "landuse", "landcover", "shelter_type", "sport", "accomodation", "information", "tourism", "viewpoint", "boundary"} 

ValidAmenities = {"bench", "bbq", "firepit", "drinking_water", "water_point", "fountain", "ranger_station", "shelter", "table", "place_of_worship", "monastery", "parking", "toilets", "grave_yard", "restaurant", "pub", "biergarten", "cafe", "ice_cream", "public_bath"}
 

ValidHistoric = {"mine", "archaeological_site", "battlefield", "boundary_stone", "city_gate", "fort", "milestone", "memorial", "monument", "ogham_stone", "ruins", "rune_stone", "tomb", "wayside_cross", "wayside_shrine", "tree_shrine", "stone", "monastery", "castle", "gallows", "pillory", "aqueduct", "stone", "church", "cathedral", "chapel", "wayside_chapel", "mosque", "synagogue", "temple", "shrine", "cross", "high_cross", "round_tower", "stećak"}
ValidManMade = {"adit", "mineshaft", "beacon", "cross", "lighthouse", "communications_tower", "tower", "watermill", "water_well", "water_tap", "windmill", "obelisk", "observatory", "telescope", "survey_point", "embankment", "dyke"}
ValidLeisure = {"bird_hide", "wildlife_hide", "firepit", "picnic_table", "swimming_area", "swimming_pool", "water_park", "nature_reserve"}
ValidInformation = {"guidepost", "map", "board", "office"}
ValidBoundary = {"protected_area", "national_park", "nature_reserve"}
ValidGeological = {"outcrop", "glacial_erratic", "hoodoo"}

if ConfigIncludeAllLandscapes then
	ValidNatural = {"spring", "rock", "stone", "cave_entrance", "tree", "geyser", "wood", "bare_rock", "scree", "moor", "wetland", "mud", "heath", "scrub", "glacier", "arete", "ridge", "cliff", "earth_bank", "gully", "peak", "hot_spring", "arch", "blockfield"}
	ValidLanduse = {"forest", "quarry", "surface_mining", "vineyard", "cemetery"}
else
	ValidNatural = {"spring", "rock", "stone", "cave_entrance", "tree", "geyser", "bare_rock", "scree", "glacier", "hot_spring", "arete", "ridge", "cliff", "earth_bank", "gully", "peak", "arch", "blockfield"}
	ValidLanduse = {"quarry", "surface_mining", "vineyard", "cemetery"}
end

ValidBuilding = {"wayside_shrine", "church", "cathedral", "chapel", "wayside_chapel", "mosque", "synagogue", "temple", "castle", "shrine"}
ValidTourism = {"viewpoint", "alpine_hut", "wilderness_hut", "artwork", "information", "picnic_site", "zoo"} -- "attraction", is handled per object
ValidBarrier = {"handrail", "railing", "split_rail", "wood", "roundpole", "pole", "metal", "ditch"}

ValidAccess = {"no", "private", "permit", "customers"}

ValidHighways = {"path", "track", "service", "road", "footway", "bridleway", "steps", "via_ferrata", "emergency_access_point", "ladder", "rest_area", "services", "trailhead", "disused", "yes"}

InvalidParkings = {"street_side", "carports", "garage_boxes", "sheds", "lane", "on_kerb", "half_on_kerb", "shoulder"}

NonAreaFeatures = {"highway", "abandoned:highway", "disused:highway", "handrail", "barrier", "ford", "cliff"}

NonPOIfeatures = {"highway", "abandoned:highway", "disused:highway", "access", "handrail", "forest", "quarry", "vineyard", "cemetery", "cliff", "ridge", "scree", "glacier", "heath", "moor", "scrub", "bare_rock", "embankment", "gully", "dyke", "aqueduct", "zoo", "protected_area"}

TopLevelFeatures = {"ford", "viewpoint"}

OutstandingFeatures = {"waterfall", "castle", "cross", "lighthouse", "observation_tower", "communications_tower", "tower", "windmill", "telescope", "observatory", "geyser", "rock", "stone", "palace", "ridge", "cliff", "peak", "aqueduct"}

NamedFeatures = {"alpine_hut", "aqueduct", "archaeological_site", "artwork", "attraction", "battlefield", "beacon", "bird_hide", "board", "cafe", "castle", "cave_entrance", "chapel", "church", "city_gate", "cliff", "cross", "emergency_access_point", "firepit", "forest", "fort", "gallows", "geyser", "glacier", "heath", "hot_spring", "ice_cream", "information", "lighthouse", "map", "memorial", "mine", "monastery", "monument", "moor", "mosque", "observation_tower", "observatory", "office", "palace", "peak", "picnic_shelter", "picnic_site", "place_of_worship", "protected_area", "pub", "quarry", "ranger_station", "restaurant", "ridge", "rock", "ruins", "rune_stone", "scree", "scrub", "shelter", "spring", "stone", "swimming", "synagogue", "telescope", "tomb", "tower", "tree", "tumulus", "via_ferrata", "viewpoint", "vineyard", "water_well", "waterfall", "watermill", "wayside_cross", "wayside_shrine", "wilderness_hut", "wildlife_hide", "windmill", "dolmen", "historic_stone", "zoo"}

NameColorBlack = {"alpine_hut", "beacon", "bird_hide", "castle", "cave_entrance", "chapel", "church", "city_gate", "cliff", "cross", "emergency_access_point", "firepit", "gallows", "geyser", "lighthouse", "map", "memorial", "mine", "monastery", "monument", "mosque", "observation_tower", "observatory", "office", "palace", "place_of_worship", "quarry", "ranger_station", "ridge", "rock", "rune_stone", "shelter", "stone", "swimming", "synagogue", "telescope", "temple", "tomb", "tower", "tumulus", "viewpoint", "wayside_cross", "wayside_shrine", "wilderness_hut", "wildlife_hide", "windmill", "dolmen", "historic_stone"}

NameColorBrown = {"archaeological_site", "artwork", "attraction", "battlefield", "board", "cafe", "fort", "information", "ice_cream", "peak", "picnic_shelter", "picnic_site", "pub", "restaurant", "ruins", "temple", "scree", "watermill", "zoo"}

NameColorGreen = {"forest", "heath", "scrub", "tree", "vineyard", "protected_area"}

NameColorBlue = {"spring", "water_well", "waterfall", "hot_spring"}

NameColorLightBlue = {"aqueduct", "glacier", "moor"}


ValidFinalClasses = {"access", "alpine_hut", "aqueduct", "archaeological_site", "artwork", "attraction", "bare_rock", "battlefield", "beacon", "bench", "board", "boundary_stone", "broadleaved_tree", "cafe", "castle", "cave_entrance", "cemetery", "chapel", "church", "city_gate", "cliff", "climbing", "communications_tower", "cross", "dolmen", "drinking_water", "dyke", "embankment", "emergency_access_point", "firepit", "ford", "forest", "fort", "fountain", "gallows", "geyser", "glacier", "guidepost", "gully", "handrail", "heath", "highway", "historic_stone", "hot_spring", "ice_cream", "lighthouse", "map", "memorial", "milestone", "mine", "monastery", "monument", "moor", "mosque", "needleleaved_tree", "observation_tower", "observatory", "office", "palace", "parking", "peak", "picnic_shelter", "picnic_site", "place_of_worship", "protected_area", "pub", "quarry", "ranger_station", "restaurant", "ridge", "rock", "ruins", "rune_stone", "scree", "scrub", "shelter", "spring", "stone", "survey_point", "swimming", "synagogue", "telescope", "temple", "toilets", "tomb", "tower", "tree", "tumulus", "viewpoint", "vineyard", "water_well", "waterfall", "watermill", "wayside_cross", "wayside_shrine", "wilderness_hut", "wildlife_hide", "windmill", "zoo"} --"access", 

ValidPOIs = {"alpine_hut", "aqueduct", "archaeological_site", "artwork", "attraction", "bare_rock", "battlefield", "beacon", "bench", "board", "boundary_stone", "broadleaved_tree", "cafe", "castle", "cave_entrance", "cemetery", "chapel", "church", "city_gate", "cliff", "climbing", "communications_tower", "cross", "dolmen", "drinking_water", "dyke", "embankment", "emergency_access_point", "firepit", "ford", "fort", "fountain", "gallows", "geyser", "guidepost", "gully", "historic_stone", "hot_spring", "ice_cream", "lighthouse", "map", "memorial", "milestone", "mine", "monastery", "monument", "mosque", "needleleaved_tree", "observation_tower", "observatory", "office", "palace", "parking", "picnic_shelter", "picnic_site", "place_of_worship", "pub", "ranger_station", "restaurant", "rock", "ruins", "rune_stone", "shelter", "spring", "stone", "survey_point", "swimming", "synagogue", "telescope", "temple", "toilets", "tomb", "tower", "tree", "tumulus", "viewpoint", "vineyard", "waterfall", "watermill", "wayside_cross", "wayside_shrine", "wilderness_hut", "wildlife_hide", "windmill", "peak", "water_well"}

PriorityPOIs = {"alpine_hut", "bare_rock", "bench", "castle", "cave_entrance", "cliff", "climbing", "cross", "dolmen", "drinking_water", "geyser", "mine", "monastery", "monument", "observation_tower", "observatory", "palace", "picnic_shelter", "picnic_site", "ranger_station", "rock", "ruins", "rune_stone", "shelter", "spring", "stone", "telescope", "temple", "toilets", "tomb",  "waterfall", "wilderness_hut", "wildlife_hide", "peak", "water_well"}


-- Initialize Lua logic

function init_function()
end

-- Finalize Lua logic()
function exit_function()
end

local function contains(testtable, value)
   for element = 1, #testtable do
      if testtable[element] == value then 
         return true
      end
   end
   return false
end


local function OSMtranslator(ObjectCategory, ObjectData)

	local FinalClass
	local SubType
	local Embankment
	local OSMkey

	FinalClass = ""
	if (ObjectCategory == "building") then
		if contains(ValidManMade, Find("man_made")) then
			FinalClass = "Duplicate"
		elseif contains(ValidNatural, Find("natural")) then
			FinalClass = "Duplicate"
		elseif contains(ValidBuilding, ObjectData) then 
			FinalClass = ObjectData
		elseif ObjectData == "building" or Holds("man_made") or Holds("amenity") or Holds("natural") then
			FinalClass = "Rejected Duplicate"
		end
	elseif (ObjectCategory == "amenity") then
		if contains(ValidBuilding, Find("building")) then
			FinalClass = "Duplicate"
		elseif contains(ValidAmenities, ObjectData) then 
			FinalClass = ObjectData 
		elseif Holds("building") then
			FinalClass = "Rejected Duplicate"
		end
	elseif (ObjectCategory == "highway") or (ObjectCategory == "abandoned:highway") or (ObjectCategory == "disused:highway") then
		if contains(ValidHighways, ObjectData) then FinalClass = ObjectData end
		if FinalClass == "footway" then
			-- Try to filter out sidewalks
			SubType = Find("sidewalk")
			if SubType ~= "" and SubType ~= "seperate" then
				FinalClass = "Processed"
			end
		end
	elseif (ObjectCategory == "historic") then
		-- avoid duplicates due to building already covering a historic site
		if contains(ValidBuilding, Find("building")) then
			FinalClass = "Duplicate"
		elseif contains(ValidManMade, Find("man_made")) then
			FinalClass = "Duplicate"
		elseif contains(ValidHistoric, ObjectData) then 
			FinalClass = ObjectData
		elseif Holds("man_made") or Holds("building") then
			FinalClass = "Rejected Duplicate"
		end
	elseif (ObjectCategory == "man_made") then
		if ObjectData == "embankment" and Find("embankment") == "yes" then
			FinalClass = "Duplicate"
		elseif contains(ValidManMade, ObjectData) then 
			FinalClass = ObjectData
		end
	elseif (ObjectCategory == "natural") then
		if contains(ValidNatural, ObjectData) then FinalClass = ObjectData end
	elseif (ObjectCategory == "leisure") then
		if contains(ValidLeisure, ObjectData) then FinalClass = ObjectData end
	elseif (ObjectCategory == "boundary") then
		if contains(ValidBoundary, ObjectData) then FinalClass = ObjectData end
	elseif (ObjectCategory == "geological") then
		if contains(ValidGeological, ObjectData) then FinalClass = ObjectData end
	elseif (ObjectCategory == "information") then
		if contains(ValidInformation, ObjectData) then FinalClass = ObjectData end
	elseif (ObjectCategory == "landuse") then
		if contains(ValidLanduse, ObjectData) then 
			FinalClass = ObjectData 
		elseif Holds("man_made") or Holds("building") or Holds("historic") then
			FinalClass = "Rejected Duplicate"
		end
	elseif (ObjectCategory == "barrier") then
		if contains(ValidBuilding, Find("building")) then
			FinalClass = "Duplicate"
		elseif contains(ValidManMade, Find("man_made")) then
			FinalClass = "Duplicate"
		elseif contains(ValidHistoric, Find("historic")) then
			FinalClass = "Duplicate"
		elseif contains(ValidBarrier, ObjectData) then 
			FinalClass = ObjectData
		elseif Holds("man_made") or Holds("building") or Holds("historic") then
			FinalClass = "Rejected Duplicate"
		end			
	elseif (ObjectCategory == "tourism") then
		if contains(ValidTourism, ObjectData) then 
			FinalClass = ObjectData 
		elseif ObjectData == "attraction" then
			-- Find attractions that are not already covered by other procesing
			FinalClass = "attraction"
			for OSMkey = 1, #node_keys do
				if Holds(node_keys[OSMkey]) and node_keys[OSMkey] ~= "tourism" then 
					FinalClass = "Duplicate"
					break
				end
			end
			if FinalClass == "attraction" then
				for OSMkey = 1, #way_keys do
					if Holds(way_keys[OSMkey]) and way_keys[OSMkey] ~= "tourism" then 
						FinalClass = "Duplicate"
						break
					end
				end
			end
		end
	elseif (ObjectCategory == "access") then
		if Find("leisure") == "garden" then
			-- Avoid overcrowded residential areas
			FinalClass = "Processed"
		elseif Find("amenity") == "parking" and contains({"private", "no"}, ObjectData) then
			-- Exclude private parking areas
			FinalClass = "Processed"
		elseif Holds("highway") or Holds("abandoned:highway") or Holds("disused:highway") or Holds("bridge") or Holds("ford") then
			FinalClass = "Duplicate"
		elseif contains(ValidAccess, ObjectData) then 
			FinalClass = "access"
		else
			FinalClass = "Processed"
		end 
	elseif (ObjectCategory == "waterway") then
		if ObjectData == "waterfall" then 
			FinalClass = ObjectData
		else
			FinalClass = "Processed"
		end
	elseif (ObjectCategory == "megalith_type") then
		if ObjectData == "dolmen" then 
			FinalClass = ObjectData 
		else
			FinalClass = "Processed"
		end
	elseif (ObjectCategory == "shelter_type") then
		if ObjectData == "picnic_shelter" then 
			FinalClass = ObjectData 
		else
			FinalClass = "Processed"
		end
	elseif (ObjectCategory == "accomodation") then
		if ObjectData == "shelter" then 
			FinalClass = ObjectData 
		else
			FinalClass = "Processed"
		end
	elseif (ObjectCategory == "landcover") then
		if ObjectData == "trees" then 
			FinalClass = ObjectData
		else
			FinalClass = "Processed"
		end
	elseif (ObjectCategory == "emergency") then
		if ObjectData == "access_point" then 
			FinalClass = ObjectData
		else
			FinalClass = "Processed"
		end
	elseif (ObjectCategory == "sport") then
		if ObjectData == "climbing" then 
			FinalClass = ObjectData
		elseif Holds("man_made") or Holds("building") or Holds("amenity") or Holds("natural") or Holds("landuse") then
			FinalClass = "Rejected Duplicate"
		end
	elseif (ObjectCategory == "summit:cross") then
		if ObjectData == "yes" then 
			FinalClass = "cross" 
		else
			FinalClass = "Processed"
		end
	elseif (ObjectCategory == "handrail") then
		if ObjectData ~= "no" and Find("highway") ~= "steps" then FinalClass = "handrail" end
	else
		FinalClass = ObjectData
	end
	
	if FinalClass ~= "" then
		if FinalClass == "adit" or FinalClass == "mineshaft" then 
			FinalClass = "mine" 
		elseif FinalClass == "summit:cross" or FinalClass == "high_cross" then
			FinalClass = "cross"
		elseif FinalClass == "round_tower" then
			FinalClass = "tower"
		elseif FinalClass == "tower" then
			SubType = Find("tower:type")
			if SubType == "communication" then
				FinalClass = "communications_tower"
			elseif SubType == "observation" or Find("tourism") == "viewpoint" then
				FinalClass = "observation_tower"
			end
		elseif (FinalClass == "bird_hide" or FinalClass == "wildlife_hide") then
			if Find("man_made") == "tower" then
				FinalClass = "observation_tower"
			else
				FinalClass = "wildlife_hide"
			end
		elseif FinalClass == "bbq" then
			FinalClass = "firepit"
		elseif FinalClass == "bench" then
			if Find("tourism") == "picnic_site" then
				FinalClass = "Duplicate"
			end
		elseif FinalClass == "parking" then
			if contains(InvalidParkings, Find("parking")) or Holds("parking:left") or Holds("parking:right") or Holds("parking:both") or contains({"private", "no"}, Find("access")) then
				FinalClass = "Processed"
			end
		elseif FinalClass == "information" then
			if contains({"map", "guidepost", "office"}, Find("information")) then
				FinalClass = "Duplicate"    -- features already covered	
			else
				FinalClass = "board"
			end
		elseif FinalClass == "table" or FinalClass == "picnic_table" or FinalClass == "picnic_shelter" or FinalClass == "picnic_site" then
			if Find("amenity") == "shelter" then
				-- shelter beats picnic site - avoid double renderings
				FinalClass = "Duplicate" 
			elseif Find("covered") == "yes" or FinalClass == "picnic_shelter" then
				FinalClass = "picnic_shelter"
			else
				FinalClass = "picnic_site"
			end
		elseif FinalClass == "ruins" then
			-- avoid duplicates
			if contains(ValidBuilding, Find("building")) or contains(ValidManMade, Find("man_made")) or contains(ValidHistoric, Find("historic")) then
				FinalClass = "Duplicate"
			end
		elseif FinalClass == "memorial" then
			if Find("memorial:type") == "stolperstein" or Find("memorial") == "stolperstein" then
				FinalClass = "Processed" -- was cluttering cities
			elseif Find("memorial") == "cross" then
				FinalClass = "cross"
			else
				if contains(ValidBuilding, Find("building")) or Find("amenity") == "place_of_worship" then
					-- avoid duplicates
					FinalClass = "Duplicate"
				end
			end
		elseif FinalClass == "obelisk" then
			FinalClass = "monument"
		elseif FinalClass == "outcrop" then
			FinalClass = "cliff"
		elseif FinalClass == "arch" then
			FinalClass = "rock"
		elseif FinalClass == "blockfield" then
			FinalClass = "bare_rock"
		elseif FinalClass == "glacial_erratic" or FinalClass == "hoodoo" then
			FinalClass = "stone"
		elseif FinalClass == "ogham_stone" then
			FinalClass = "rune_stone"
		elseif FinalClass == "stone" then
			if ObjectCategory == "historic" and Find("natural") == "stone" then 
				FinalClass = "Duplicate"
			end
		elseif FinalClass == "cathedral" then
			FinalClass = "church"
		elseif FinalClass == "cave_entrance" then
			if Find("man_made") == "adit" then FinalClass = "Processed" end
		elseif (FinalClass == "tomb" and Find("tomb") == "tumulus") or (Find("archaeological_site") == "tumulus") then
			FinalClass = "tumulus"
		elseif FinalClass == "tree_shrine" or FinalClass == "shrine" then
			FinalClass = "wayside_shrine"
		elseif FinalClass == "tree" then
			if (Find("denotation") == "natural_monument" or Find("tourism") == "attraction" or Find("name") ~= "" or Find(PreferredLanguageNameKey) ~= "") and Find("end_date") == "" then
				SubClass = Find("leaf_type")
				if SubClass == "broadleaved" or SubClass == "needleleaved" then
					FinalClass = SubClass .. "_tree"
				end
			else
				FinalClass = "Processed"
			end
		elseif FinalClass == "monastery" or FinalClass == "castle" then
			SubType = Find("castle_type")
			if SubType == "palace" or SubType == "stately" or SubType == "manor" then
				FinalClass = "palace"
			end
		elseif FinalClass == "wayside_chapel" then
			FinalClass = "chapel"
		elseif FinalClass == "stećak" or (FinalClass == "stone" and ObjectCategory == "historic") then
			FinalClass = "historic_stone"
		elseif (FinalClass == "swimming_area" or FinalClass == "swimming_pool" or FinalClass == "water_park" or FinalClass == "public_bath") then
			if contains({"private", "no"}, Find("access")) then
				FinalClass = "Processed"
			else
				FinalClass = "swimming"
			end
		elseif FinalClass == "access_point" then
			FinalClass = "emergency_access_point"
		elseif FinalClass == "viewpoint" and (Find("man_made") == "tower" or Find("tower:type") == "observation") then
			FinalClass = "Duplicate"
		elseif FinalClass == "wood" or FinalClass == "trees" or FinalClass == "orchard" then
			FinalClass = "forest"
		elseif FinalClass == "surface_mining" then
			FinalClass = "quarry"
		elseif FinalClass == "wetland" or FinalClass == "mud" then
			FinalClass = "moor"
		elseif FinalClass == "water_tap" or FinalClass == "water_point" then
			FinalClass = "drinking_water"
		elseif FinalClass == "grave_yard" then
			FinalClass = "cemetery"
		elseif FinalClass == "arete" then
			FinalClass = "ridge"
		elseif FinalClass == "grave_yard" then
			FinalClass = "cemetery"
		elseif FinalClass == "pillory" then
			FinalClass = "gallows"
		elseif FinalClass == "biergarten" then
			FinalClass = "pub"
		elseif FinalClass == "ditch" then
			FinalClass = "gully"
		elseif FinalClass == "nature_reserve" or FinalClass == "national_park" or FinalClass == "protected_area" then
			FinalClass = "protected_area"
			if ObjectCategory == "leisure" then
				if contains({"nature_reserve", "national_park", "protected_area"}, Find("boundary")) then
					FinalClass = "Duplicate"
				end
			end
		elseif contains(ValidBarrier, FinalClass) and FinalClass ~= "ditch" then	
			FinalClass = "handrail"
		elseif FinalClass == "place_of_worship" then
			-- Avoid duplicates: Building/historic may already cover place_of_worship
			SubType = Find("building")
			if contains(ValidBuilding, Find("building")) or contains(ValidHistoric, Find("historic"))  then
				FinalClass = "Duplicate"
			end
		elseif (ObjectCategory == "embankment" and FinalClass ~= "dyke") or contains({"scarp", "cut_bank"}, Find("earth_bank")) or FinalClass == "earth_bank" then
		    if Find("earth_bank") ~= "gully" then
				FinalClass = "embankment"		-- might be yes, both, two_sided... see below
			else
				FinalClass = "gully"
			end
		end
		if FinalClass == "embankment" then
			-- Embankments are sooo complicated :-(
			Embankment = Find("embankment")
			if contains({"dyke", "two_sided", "yes"}, Embankment) or Find("embankment:side") == "both" then
				FinalClass = "dyke"
			else
				SubType = Find("embankment:type")
				if contains({"dyke", "two_sided", "noise_barrier", "rampart"}, SubType) then
					FinalClass = "dyke"
				end
			end
		end
		
	end
	
	if FinalClass == "" then
		if Find("tourism") == "attraction" then
			FinalClass = "attraction"
		end
	elseif FinalClass == "Duplicate" or FinalClass == "Rejected Duplicate" or FinalClass == "Processed" then
		FinalClass = ""
	end
	
	return FinalClass

end

function CommonAttributes(FinalClass, SetName, SetOutstanding, PresetName)

	local Access
	local Religion
	local Name
	local AdditionalName
	local AttractionDone
	local Toursim

	AttractionDone = false
	Toursim = Find("tourism")
	
	Religion = Find("religion")
	if Religion ~= "" then Attribute("religion", Religion) end
	if Holds("ruins") then Attribute("ruins", "yes") end

	if Find("fee") == "yes" or Find("toll") == "yes" then
		Attribute("access", "fee") 
	else
		Access = Find("access")
		if contains(ValidAccess, Access) then Attribute("access", Access) end
	end
	
	-- Climbing does not get attraction, as it is often paired with other elements
	if SetOutstanding then
		if contains(OutstandingFeatures, FinalClass) then
			MinZoom(10)
			Attribute("outstanding", "yes")
			if Toursim == "attraction" and FinalClass ~= "climbing" then
				Attribute("attraction", "outstanding")
				AttractionDone = true
			end
		elseif Toursim == "attraction" then
			MinZoom(10)
		elseif contains(PriorityPOIs, FinalClass) then
			MinZoom(12)
		else
			MinZoom(13)
			-- Attribute("outstanding", "no")
		end 
	end
	if Find("tourism") == "attraction" and FinalClass ~= "climbing" and not AttractionDone then	
		if FinalClass == "attraction" then
			Attribute("attraction", "minor")	
		else
			Attribute("attraction", "major")	
		end
		MinZoom(9)
		AttractionDone = true
	end
	if SetName then
		if contains(NamedFeatures, FinalClass) then
			if PresetName == "" then
				Name = Find(PreferredLanguageNameKey)
				AdditionalName = Find("name")
				if Name == "" then 
					Name = AdditionalName 
				elseif AdditionalName ~= Name and AdditionalName ~= "" then
					Name = Name .. " (" .. AdditionalName .. ")"
				end
			else
				Name = PresetName
			end
			if Name ~= "" then
				Attribute("name", Name, 13) 
				if contains(NameColorBlue, FinalClass) then
					Attribute("name_color", "blue", 13) 
				elseif contains(NameColorBrown, FinalClass) then
					Attribute("name_color", "brown", 13) 
				elseif contains(NameColorGreen, FinalClass) then
					Attribute("name_color", "green", 13) 
				elseif contains(NameColorLightBlue, FinalClass) then
					Attribute("name_color", "light_blue", 13) 
				else
					Attribute("name_color", "black", 13) 
				end								
			end
		end				
	end

end


function relation_scan_function(relation)

	if contains(ValidBoundary, Find("boundary")) then
--		if Find("name") == "Kottenforst" then print("REL --- ID: " .. Id() .. " Type: " .. Find("type") .. " boundary: " .. Find ("boundary") .. " <") end
		Accept()
	elseif contains(ValidLanduse, Find("landuse")) then
		Accept()
	elseif contains(ValidNatural, Find("natural")) then
		Accept()	
	end

end

-- Assign nodes to a layer, and set attributes, based on OSM tags

function relation_function()

	local FinalClass
	local ProtectionClass
	
	if contains(ValidBoundary, Find("boundary")) then
		FinalClass = "protected_area"

		Layer("OSMfeatures", IsClosed())
		
		ProtectionClass = Find("protection_title")
		ProtectionClass = string.gsub(ProtectionClass, "Naturschutzgebiet", "NSG")
		ProtectionClass = string.gsub(ProtectionClass, "Landschaftsschutzgebiet", "LSG")
		Name = Find(PreferredLanguageNameKey)
		if Name == "" then
			Name = Find("name")
		end
		if Name ~= "" then
			Name = string.gsub(Name, "Naturschutzgebiet", "NSG")
			Name = string.gsub(Name, "Landschaftsschutzgebiet", "LSG")
			if string.find(Name, ProtectionClass) then
				ProtectionClass = ""
			end
		end
		if ProtectionClass ~= "" then
			Attribute("subclass", ProtectionClass)
		end
		
		Attribute("class", FinalClass)
		
		CommonAttributes(FinalClass, true, false, Name)

		
	end
		
--	if Find("name") == "Stadthalle Bad Godesberg" then print("REL-ADD --- ID: " .. Id() .. " Type: " .. Find("type") .. " boundary: " .. Find ("boundary") .. " <") end

end

function node_function(node)

	local POInode
	local POI
	local POIclass
	local FinalClass
	local Name
	local AdditionalName

	for number, POInode in ipairs(node_keys) do
				
		POI = Find(POInode)
		if POI ~= "" then
			if POI == "yes" or contains (TopLevelFeatures, POInode) then
				POIclass = POInode			
			else 
				POIclass = POI
			end
			
			if POInode == "highway" and POI ~= "emergency_access_point" then
				FinalClass = ""
			else
				FinalClass = OSMtranslator(POInode, POIclass)
			end
			
			-- if Find("name") == "Alte Mauer" and Find("note") == "Keltische Fliehburg" then print("ID: " .. Id() .. " POInode: " .. POInode .. " POI: " .. POI .. " POIclass: " .. POIclass .. " FinalClass: " .. FinalClass) end
					
			if FinalClass ~= "" then
				if contains(ValidPOIs, FinalClass) then
					Layer("OSMPOI")
					Attribute("class", FinalClass)
					
					Name = ""
						
					if contains(NamedFeatures, FinalClass) then
						if FinalClass == "emergency_access_point" then
							Name = Find("ref")
							if Holds(PreferredLanguageNameKey) then
								Name = Name .. " " .. Find(PreferredLanguageNameKey)
							elseif Holds("name") then
								Name = Name .. " " .. Find("name")
							end
						elseif FinalClass == "peak" then
							Name = Find("ele")
							if Holds(PreferredLanguageNameKey) then
								if Holds("name") then
									Name = Find(PreferredLanguageNameKey) .. " (" .. Find("name") .. ")\n" .. Name 
								else
									Name = Find(PreferredLanguageNameKey) .. "\n" .. Name
								end
							elseif Holds("name") then
								Name = Find("name") .. "\n" .. Name
							end
						else
							Name = Find(PreferredLanguageNameKey)
							AdditionalName = Find("name")
							if Name == "" then 
								Name = AdditionalName 
							elseif AdditionalName ~= Name and AdditionalName ~= "" then
								Name = Name .. " (" .. AdditionalName .. ")"
							end
						end

					end
					
					if ConfigIncludeDebugInfo then Attribute("source", "POI") end
					
					CommonAttributes(FinalClass, (Name ~= ""), true, Name)
					
					if contains(PriorityPOIs, FinalClass) then Attribute("priority", "yes") end
					
				elseif not contains(NonPOIfeatures, FinalClass) then
					-- Only an error if not a known non-POI class
					print("WARNING: Object with unknown POI class: " .. FinalClass .. " - POI node: " .. POInode .. ", POI: " .. POI)
				end
			end

		end
	end

end


-- Assign ways to a layer, and set attributes, based on OSM tags

function way_function()

	local FeatureLines
	local Feature
	local FeatureClass
	local FinalClass
	local TrailVisibility
	local LeafType
	local LeafCycle
	local Wood
	local ViaFerrataScale
	local SACscale
	local Difficulty
	local DifficultyColor
	local ProcessAsPOI
	local Processed
	local Handrail
	local HandrailSide
	local OneWay
	local PreviousType
	local DoOutstandingAttribute
	local ProtectionClass
	local ConditionalAccess
	local Name
	local AbandonedType

	for number, Feature in ipairs(way_keys) do
				
		FeatureLine = Find(Feature)
		
		if FeatureLine ~= "" then
			if FeatureLine == "yes" or contains (TopLevelFeatures, Feature) then
				if Feature == "abandoned:highway" then
					AbandonedType = Find("abandoned")
					if AbandonedType ~= "" and AbandonedType ~= "yes" then
						FeatureClass = AbandonedType
					else
						FeatureClass = "path"
					end
				else
					FeatureClass = Feature
				end
			else 
				FeatureClass = FeatureLine
			end
			
			FinalClass = OSMtranslator(Feature, FeatureClass)

			if FinalClass == "bridge" then
				if Find("highway") == "" then
					FinalClass = "track"
				else
					FinalClass = ""
				end
			end
			
--[[			if Find("name") == "Stadthalle Bad Godesberg" then
				print ("ID: " .. Id() .. " Feature: " .. Feature .. " Line: " .. FeatureLine .. " FeatureClass: " .. FeatureClass .. " FinalClass: " .. FinalClass .. " Type: " .. Find("type") .. " boundary: " .. Find ("boundary") .. " <")
			end]]
			
			if FinalClass ~= "" then
				
				ProcessAsPOI = false
				Processed = false
				PreviousType = ""
				DoOutstandingAttribute = true
				
				
				if Feature == "highway" or Feature == "abandoned:highway" or Feature == "disused:highway" or Feature == "bridge" then
					if (((Feature == "abandoned:highway" or Feature == "disused:highway") and not Holds("highway")) or Feature == "highway" or Feature == "bridge") and contains(ValidHighways, FinalClass) then
						
						Layer("OSMways", false)
						
						ViaFerrataScale = Find("via_ferrata_scale")
						SACscale = Find("sac_scale")
						
						if FinalClass == "unclassified" then 
							FinalClass = "track" 
						elseif Find("assisted_trail") ~= "" or Find("safety_rope") ~= "" or Find("ladder") ~= "" or Find("rungs") ~= "" or ViaFerrataScale ~= "" then
							FinalClass = "via_ferrata"
						end
						
						Difficulty = ""
						DifficultyColor = ""

						if SACscale == "" then
							if ViaFerrataScale ~= "" then
								Difficulty = "V" .. tostring(ViaFerrataScale)
								DifficultyColor = "generic"
							end
						else
							if SACscale == "hiking" then
								Difficulty = "T1"
								DifficultyColor = "yellow"
							elseif SACscale == "mountain_hiking" then
								Difficulty = "T2"
								DifficultyColor = "red"
							elseif SACscale == "demanding_mountain_hiking" then
								Difficulty = "T3"
								DifficultyColor = "red"
							elseif SACscale == "alpine_hiking" then
								Difficulty = "T4"
								DifficultyColor = "blue"
							elseif SACscale == "demanding_alpine_hiking" then
								Difficulty = "T5"
								DifficultyColor = "blue"
							elseif SACscale == "difficult_alpine_hiking" then
								Difficulty = "T6"
								DifficultyColor = "blue"
							end
							if ViaFerrataScale ~= "" then
								Difficulty = Difficulty .. "/V" .. tostring(ViaFerrataScale)
								if DifficultyColor == "" then
									DifficultyColor = "generic"
								end
							end
						end 
							
						Attribute("class", FinalClass)
						
						if DifficultyColor ~= "" then
							Attribute("difficulty_color", DifficultyColor)
						end
						
						if ConfigIncludeDebugInfo then Attribute("source", "highway") end
						
						if Difficulty ~= "" then Attribute("difficulty", Difficulty) end
						if Holds("abandoned:highway") or Holds("disused:highway") or Find("disused") == "yes" or FinalClass=="disused" then Attribute("subclass", "abandoned") end
						TrailVisibility = Find("trail_visibility")
						if TrailVisibility ~= "" then Attribute("trail_visibility", TrailVisibility) end
						Access = Find("access")
						if contains(ValidAccess, Access) then Attribute("access", Access) end
						OneWay = Find("oneway")
						if OneWay ~= "" and OneWay ~= "no" then Attribute("oneway", "yes") end
						if FinalClass == "steps" then
							Handrail = Find("handrail")
							if Handrail == "yes" then
								HandrailSide = "handrail_both"
								if Holds("handrail:left") and not Holds("handrail:right") then
									HandrailSide = "handrail_left"
								elseif Holds("handrail:right") and not Holds("handrail:left") then
									HandrailSide = "handrail_left"
								end
								Attribute("subclass", HandrailSide)
							end
						elseif Find("surface") == "wood" or Find("bridge") == "boardwalk" then
							Attribute("subclass", "boardwalk")
						end

						if contains(NamedFeatures, FinalClass) then
							Name = Find(PreferredLanguageNameKey)
							if Name == "" then 
								Name = Find("name") 
							elseif Holds("name") then
								Name = Name .. " (" .. Find("name") .. ")"								
							end
							if Name ~= "" then
								Attribute("name", Name, 13) 
							end
						end	

						ConditionalAccess = Find("foot:conditional")
						if ConditionalAccess == "" then
							ConditionalAccess = Find("access:foot:conditional")
						end
						if ConditionalAccess == "" then
							ConditionalAccess = Find("access:conditional")
						end
						if ConditionalAccess ~= "" then
							Attribute("ConditionalAccess", ConditionalAccess)
						end
						
						if Find("fee") == "yes" or Find("toll") == "yes" then
							Attribute("fee", "yes")
						end
										
					end
				else 
					if contains(ValidFinalClasses, FinalClass) then
						if contains(NonPOIfeatures, FinalClass) or Find("tourism") == "attraction" then
							if contains(NonAreaFeatures, Feature) then

								Layer("OSMfeatures", false)

								if ConfigIncludeDebugInfo then Attribute("source", "way (NonPOI)") end
								
								PreviousType = "way"

							else
								Layer("OSMfeatures", IsClosed())
								if FinalClass == "forest" then
									LeafType = Find("leaf_type")
									LeafCycle = Find("leaf_cycle")
									Wood = Find("wood")
									if LeafType == "broadleaved" or LeafCycle == "deciduous" or Wood == "deciduous" then
										Attribute("subclass", "broadleaved")
									elseif LeafType == "needleleaved" or LeafCycle == "evergreen" or Wood == "coniferous" then
										Attribute("subclass", "needleleaved")
									elseif LeafType == "mixed" or LeafCycle == "mixed" or Wood == "mixed" then
										Attribute("subclass", "mixed")
									elseif Find("landuse") == "orchard" then
										Attribute("subclass", "orchard")
									end
								end
								-- This is needed currently for cliff because line image orientation is reversed for areas vs. lines
								if IsClosed() then
									Attribute("geometry", "area")
									PreviousType = "area"
								else
									Attribute("geometry", "line")
									PreviousType = "way/line"
								end
								DoOutstandingAttribute = not IsClosed()								
							end
							
							if FinalClass == "protected_area" then
								ProtectionClass = Find("protection_title")
								ProtectionClass = string.gsub(ProtectionClass, "Naturschutzgebiet", "NSG")
								ProtectionClass = string.gsub(ProtectionClass, "Landschaftsschutzgebiet", "LSG")
								Name = Find(PreferredLanguageNameKey)
								if Name == "" then
									Name = Find("name")
								end
								if Name ~= "" then
									Name = string.gsub(Name, "Naturschutzgebiet", "NSG")
									Name = string.gsub(Name, "Landschaftsschutzgebiet", "LSG")
									if string.find(Name, ProtectionClass) then
										ProtectionClass = ""
									end
								end
								if ProtectionClass ~= "" then
									Attribute("subclass", ProtectionClass)
								end
							else
								Name = ""
							end
							
							Attribute("class", FinalClass)
							
							CommonAttributes(FinalClass, true, DoOutstandingAttribute, Name)
							
							ProcessAsPOI = Find("tourism") == "attraction" and (contains(ValidPOIs, FinalClass) and not contains(NonPOIfeatures, FinalClass))
							
							Processed = true
						end
						
						if (contains(ValidPOIs, FinalClass) and not contains(NonPOIfeatures, FinalClass)) or ProcessAsPOI then
							
							LayerAsCentroid("OSMPOI", "centroid")
							-- Attribute("geometry", "centroid")
															
							Attribute("class", FinalClass)						

							if ConfigIncludeDebugInfo then 
								if ProcessAsPOI then
									Attribute("source", "way/area from previous " .. PreviousType)
								else
									Attribute("source", "way/area")
								end
							end
							
							CommonAttributes(FinalClass, true, true, "")
							
							if contains(PriorityPOIs, FinalClass) then Attribute("priority", "yes") end
							
							Processed = true
						end
						
						if not Processed then
							print("WARNING: Object (converted area/way) with unknown POI class: " .. FinalClass .. " - Feature: " .. Feature .. ", FeatureLine: " .. FeatureLine)
						end
					else
						print("WARNING: Object with unknown class: " .. FinalClass .. " - Feature: " .. Feature .. ", FeatureLine: " .. FeatureLine)
					end
				end
			end

		end
	end

end