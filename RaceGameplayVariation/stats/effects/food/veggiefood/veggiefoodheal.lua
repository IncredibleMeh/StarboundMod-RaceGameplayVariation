function init()
  animator.setParticleEmitterOffsetRegion("healing", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("healing", effect.configParameter("emissionRate", 3))
  animator.setParticleEmitterActive("healing", true)

  script.setUpdateDelta(5)

	if world.entitySpecies(entity.id()) == "glitch" then
		self.healingRate = effect.configParameter("healAmount", 30) / effect.duration() / 2
	else
		self.healingRate = effect.configParameter("healAmount", 30) / effect.duration()
	end
end

function update(dt)
  status.modifyResource("health", self.healingRate * dt)
end

function uninit()
  
end