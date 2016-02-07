function init()
  --Slow
  self.runModifier = effect.configParameter("runModifier", 0)
  self.jumpModifier = effect.configParameter("jumpModifier", 0)
  self.groundMovementModifier = effect.configParameter("groundMovementModifier", 0)

  local slows = status.statusProperty("slows", {})
  slows["rageslow"] = 1 + self.runModifier
  status.setStatusProperty("slows", slows)

  --Power
  self.powerModifier = effect.configParameter("powerModifier", 0)
  effect.addStatModifierGroup({{stat = "powerMultiplier", basePercentage = self.powerModifier}})

  animator.setParticleEmitterOffsetRegion("embers", mcontroller.boundBox())
  animator.setParticleEmitterActive("embers", true)

  local statusTextRegion = { 0, 1, 0, 1 }
  animator.setParticleEmitterOffsetRegion("statustext", statusTextRegion)
  animator.burstParticleEmitter("statustext")
end


function update(dt)
  mcontroller.controlModifiers({
    groundMovementModifier = self.groundMovementModifier,
    runModifier = self.runModifier,
    jumpModifier = self.jumpModifier
  })

end

function uninit()

end
