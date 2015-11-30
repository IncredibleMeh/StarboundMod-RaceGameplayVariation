function init()
  local bounds = mcontroller.boundBox()
end

function update(dt)
	if world.entitySpecies(entity.id()) ~= "floran" then
		mcontroller.controlModifiers({
				runModifier = 0.125
			})
	else
		mcontroller.controlModifiers({
				runModifier = 0.25
			})
	end
end

function uninit()
  
end