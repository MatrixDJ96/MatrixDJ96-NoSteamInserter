local remove_entity = function(category, name)
	if data.raw[category][name] then
		-- eliminate item dependencies
		for item_name, item in pairs(data.raw.item) do
			if item.place_result == name then
				data.raw.item[item_name] = nil
			end
		end
		-- eliminate recipe dependencies
		for recipe_name, recipe in pairs(data.raw.recipe) do
			if recipe.result == name then
				data.raw.recipe[recipe_name] = nil
			end
		end
		-- eliminate entity
		data.raw[category][name] = nil
		log("Removed \"" .. name .. "\" entity!") 
	end
end

local remove_rcalc_entity = function(category, name) 
	local base_category = "selection-tool"
	local final_category = "alt_entity_filters"

	if data.raw[base_category][category] then
		for key, value in pairs(data.raw[base_category][category][final_category]) do
			if value == name then
				data.raw[base_category][category][final_category][key] = nil
				break
			end
		end
	end
end

remove_entity("inserter", "steam-inserter")

if mods["RateCalculator"] then
	remove_rcalc_entity("rcalc-all-selection-tool", "steam-inserter")
	remove_rcalc_entity("rcalc-materials-selection-tool", "steam-inserter")
end