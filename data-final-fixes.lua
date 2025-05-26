category_prod = {}

for _, type in pairs({"assembling-machine", "furnace", "rocket-silo"}) do
  for id, machine in pairs(data.raw[type]) do
    local machine_prod = ((machine.effect_receiver or {}).base_effect or {}).productivity or 0
    for _, category in pairs(machine.crafting_categories) do
      if (not category_prod[category]) or (category_prod[category] > machine_prod) then
        category_prod[category] = machine_prod
      end
    end
  end
end


function min_recipe_prod (recipe)
  local min_prod = category_prod[recipe.category or "crafting"]
  if not min_prod then
    error("Category " .. recipe.category .. " does not exist")
  end
  for _, extra in pairs(recipe.additional_categories or {}) do
    if min_prod > category_prod[extra] then
      min_prod = category_prod[extra]
    end
  end

  return min_prod
end

for _, tech in pairs(data.raw["technology"]) do
  if tech.max_level ~= "infinite" then
    goto continue
  end

  local max_level = 0
  for _, effect in pairs(tech.effects) do
    if effect.type ~= "change-recipe-productivity" then
      goto continue
    end

    local recipe = data.raw["recipe"][effect.recipe]
    if not recipe then
      log("Recipe " .. effect.recipe .. " does not exist")
    else
      local min_prod = min_recipe_prod(recipe)
      local max_prod = recipe.maximum_productivity or 3
      local level = math.ceil((max_prod - min_prod) / effect.change)
      if level > max_level then
        max_level = level
      end
    end
  end

  if max_level ~= 0 then
    tech.max_level = max_level
  end

  ::continue::
end
