function init()
  animator.setParticleEmitterOffsetRegion("energy", mcontroller.boundBox())
  animator.setParticleEmitterEmissionRate("energy", effect.configParameter("emissionRate", 5))
  animator.setParticleEmitterActive("energy", true)

  effect.addStatModifierGroup({{stat = "energyRegen", amount = effect.configParameter("regenAmount", 0)}})

  script.setUpdateDelta(0)
end

function update(dt)
  
end

function uninit()
  
end