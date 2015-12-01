function init()
  animator.setParticleEmitterOffsetRegion("healing", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("healing", effect.configParameter("emissionRate", 3))
  animator.setParticleEmitterActive("healing", true)

  script.setUpdateDelta(5)

  if world.entitySpecies(entity.id()) == "glitch" then
		self.healingRate = effect.configParameter("healAmount", 30) / 2 / effect.duration()
	elseif world.entitySpecies(entity.id()) == "floran" then
		self.healingRate = effect.configParameter("healAmount", 30) * 1.5 / effect.duration()
	else
		self.healingRate = effect.configParameter("healAmount", 30) / effect.duration()
	end
end

function update(dt)
  status.modifyResource("health", self.healingRate * dt)
end

function uninit()
  
end