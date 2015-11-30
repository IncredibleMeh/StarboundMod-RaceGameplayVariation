function init()
  animator.setParticleEmitterOffsetRegion("snow", mcontroller.boundBox())
  animator.setParticleEmitterActive("snow", true)
  
  script.setUpdateDelta(5)

	if world.entitySpecies(entity.id()) ~= "glitch" then
		self.tickTimer = 1
	else
		self.tickTimer = 10
	end
		self.degen = 0.005

  self.pulseTimer = 0
  self.halfPi = math.pi / 2
end

function update(dt)
	if world.entitySpecies(entity.id()) ~= "glitch" then
		mcontroller.controlModifiers({
				groundMovementModifier = -0.9,
				runModifier = -0.5,
				jumpModifier = -0.3
			})
	end
			
	mcontroller.controlParameters({
			normalGroundFriction = 0.9
		})
			
	status.modifyResourcePercentage("energy", -self.degen * dt)
	self.tickTimer = self.tickTimer - dt
	if self.tickTimer <= 0 then
		if world.entitySpecies(entity.id()) ~= "glitch" then
			self.tickTimer = 1
		else
			self.tickTimer = 10
		end
		self.degen = self.degen + 0.005
		status.applySelfDamageRequest({
				damageType = "IgnoresDef",
				damage = self.degen * status.resourceMax("health"),
				sourceEntityId = entity.id()
			})
	end

  self.pulseTimer = self.pulseTimer + dt * 2
  if self.pulseTimer >= math.pi then
    self.pulseTimer = self.pulseTimer - math.pi
  end
  local pulseMagnitude = math.floor(math.cos(self.pulseTimer - self.halfPi) * 16) / 16
  effect.setParentDirectives("fade=AAAAFF="..pulseMagnitude * 0.2 + 0.2)
end

function uninit()

end