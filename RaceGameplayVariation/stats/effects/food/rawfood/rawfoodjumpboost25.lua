function init()
  local bounds = mcontroller.boundBox()
  animator.setParticleEmitterOffsetRegion("jumpparticles", {bounds[1], bounds[2] + 0.2, bounds[3], bounds[2] + 0.3})
end

function update(dt)
  animator.setParticleEmitterActive("jumpparticles", mcontroller.jumping())
  
	if world.entitySpecies(entity.id()) ~= "floran" then
		mcontroller.controlModifiers({
				jumpModifier = 0.125
			})
	else
		mcontroller.controlModifiers({
				jumpModifier = 0.25
			})
	end
end

function uninit()
  
end