function init()
  animator.setParticleEmitterOffsetRegion("drips", mcontroller.boundBox())
  animator.setParticleEmitterActive("drips", true)
  effect.setParentDirectives("fade=0072ff=0.1")

  local slows = status.statusProperty("slows", {})
  slows["waterslow"] = 0.8
  status.setStatusProperty("slows", slows)
end

function update(dt)
	if world.entitySpecies(entity.id()) ~= "hylotl" then
		mcontroller.controlModifiers({
				runModifier = -0.1,
				jumpModifier = -0.1
			})
	end
end

function uninit()
  local slows = status.statusProperty("slows", {})
  slows["waterslow"] = nil
  status.setStatusProperty("slows", slows)
end