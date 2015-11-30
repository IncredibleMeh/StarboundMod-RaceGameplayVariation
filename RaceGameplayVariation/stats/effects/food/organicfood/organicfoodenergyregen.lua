function init()
  animator.setParticleEmitterOffsetRegion("energy", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("energy", effect.configParameter("emissionRate", 5))
  animator.setParticleEmitterActive("energy", true)

	if world.entitySpecies(entity.id()) ~= "floran" then
		effect.addStatModifierGroup({{stat = "energyRegen", amount = effect.configParameter("regenAmount", 0) / 2}})
	else
		effect.addStatModifierGroup({{stat = "energyRegen", amount = effect.configParameter("regenAmount", 0)}})
	end

  script.setUpdateDelta(0)
end

function update(dt)
  
end

function uninit()
  
end