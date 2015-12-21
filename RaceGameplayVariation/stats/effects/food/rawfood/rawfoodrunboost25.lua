function init()
  local bounds = mcontroller.boundBox()
end

function update(dt)
	if world.entitySpecies(entity.id()) ~= "floran" then
		mcontroller.controlModifiers({
				runModifier = 1.125
			})
	else
		mcontroller.controlModifiers({
				runModifier = 1.25
			})
	end
end

function uninit()
  
end