function init()
  effect.addStatModifierGroup({
			{stat = "waterbreathProtection", amount = 1},

			{stat = "meatyfooddamageImmunity", amount = 1},
			{stat = "metallicfoodbuffImmunity", amount = 1},
			{stat = "metallicfoodhealImmunity", amount = 1},
			{stat = "organicfooddamageImmunity", amount = 1},
			{stat = "rawfooddamageImmunity", amount = 1},
			{stat = "veggiefooddamageImmunity", amount = 1}
		})
		
	script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  
end