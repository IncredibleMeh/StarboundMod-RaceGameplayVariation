function init()
  animator.setParticleEmitterOffsetRegion("healing", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("healing", effect.configParameter("emissionRate", 3))
  animator.setParticleEmitterActive("healing", true)

  script.setUpdateDelta(5)

  self.healingRate = effect.configParameter("healAmount", 30) / effect.duration()
end

function update(dt)
  status.modifyResource("health", self.healingRate * dt)
end

function uninit()
  
end