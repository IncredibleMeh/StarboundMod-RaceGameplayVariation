function init()
  script.setUpdateDelta(5)

  self.tickTimer = 1
  self.degen = 0.005

  self.pulseTimer = 0
  self.halfPi = math.pi / 2
end

function update(dt)
	if world.entitySpecies(entity.id()) ~= "novakid" then
		if world.entitySpecies(entity.id()) ~= "glitch" then
			mcontroller.controlModifiers({
					runModifier = 0.6,
					jumpModifier = 0.6
				})

			status.modifyResourcePercentage("energy", -self.degen * dt)
			self.tickTimer = self.tickTimer - dt
			if self.tickTimer <= 0 then
				self.tickTimer = 1
				self.degen = self.degen + 0.005
				status.applySelfDamageRequest({
						damageType = "IgnoresDef",
						damage = self.degen * status.resourceMax("health"),
						sourceEntityId = entity.id()
					})
			end
		end
		
		self.pulseTimer = self.pulseTimer + dt * 2
		if self.pulseTimer >= math.pi then
			self.pulseTimer = self.pulseTimer - math.pi
		end

		local pulseMagnitude = math.floor(math.cos(self.pulseTimer - self.halfPi) * 16) / 16
		effect.setParentDirectives(string.format("fade=AAFF88=%.3f?border=2;AAFF88%2x;00000000", (pulseMagnitude * 0.3 + 0.1), math.floor(pulseMagnitude * 70) + 10))
	end	
end

function uninit()

end