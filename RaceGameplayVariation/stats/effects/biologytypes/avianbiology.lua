function init()
effect.addStatModifierGroup({
		{stat = "meatyfooddamageImmunity", amount = 1},
		
		{stat = "metallicfoodbuffImmunity", amount = 1}
		{stat = "metallicfoodhealImmunity", amount = 1}
		
		{stat = "organicfooddamageImmunity", amount = 1},
		
		{stat = "rawfooddamageImmunity", amount = 1},
		
		{stat = "veggiefooddamageImmunity", amount = 1}
	})

  self.gravityModifier = effect.configParameter("gravityModifier")
  self.movementParams = mcontroller.baseParameters()

  setGravityMultiplier()
end

function setGravityMultiplier()
  local oldGravityMultiplier = self.movementParams.gravityMultiplier or 1

  self.newGravityMultiplier = self.gravityModifier * oldGravityMultiplier
end

function update(dt)
  mcontroller.controlParameters({
     gravityMultiplier = self.newGravityMultiplier
  })
end

function uninit()
  
end