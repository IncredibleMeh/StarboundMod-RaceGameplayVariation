function init()
	if world.entitySpecies(entity.id()) ~= "floran" then
		effect.addStatModifierGroup({{stat = "maxHealth", amount = effect.configParameter("healthAmount", 0) / 2}})
	else
		effect.addStatModifierGroup({{stat = "maxHealth", amount = effect.configParameter("healthAmount", 0)}})
	end

   script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  
end