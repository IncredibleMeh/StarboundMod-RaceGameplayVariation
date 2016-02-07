function init()
  effect.addStatModifierGroup({
			{stat = "protection", amount = 25},
			
			{stat = "poisonImmunity", amount = 1},
			{stat = "waterImmunity", amount = 1},
			{stat = "fireImmunity", amount = 1},
			
			{stat = "meatyfooddamageImmunity", amount = 1},
			{stat = "meatyfoodbuffImmunity", amount = 1},
			
			{stat = "metallicfooddamageImmunity", amount = 1},
			
			{stat = "organicfooddamageImmunity", amount = 1},
			{stat = "organicfoodbuffImmunity", amount = 1},
			
			{stat = "rawfooddamageImmunity", amount = 1},
			{stat = "rawfoodbuffImmunity", amount = 1},
			
			{stat = "veggiefooddamageImmunity", amount = 1},
			{stat = "veggiefoodbuffImmunity", amount = 1}
		})
end

function update(dt)

end

function uninit()
  
end