function init()
  effect.addStatModifierGroup({
			{stat = "breathProtection", amount = 1},
	
			{stat = "biomecoldImmunity", amount = 1},
			{stat = "biomeheatImmunity", amount = 1},
			{stat = "biomeradiationImmunity", amount = 1},
			{stat = "lavaImmunity", amount = 1},
			{stat = "poisonImmunity", amount = 1},
			{stat = "fireImmunity", amount = 1},
			
			{stat = "explosionDeath", amount = 1},
			
			{stat = "meatyfooddamageImmunity", amount = 1},
			{stat = "meatyfoodbuffImmunity", amount = 1},
			{stat = "metallicfooddamageImmunity", amount = 1},
			{stat = "metallicfoodbuffImmunity", amount = 1},
			{stat = "organicfooddamageImmunity", amount = 1},
			{stat = "organicfoodbuffImmunity", amount = 1},
			{stat = "rawfooddamageImmunity", amount = 1},
			{stat = "rawfoodbuffImmunity", amount = 1},
			{stat = "veggiefooddamageImmunity", amount = 1},
			{stat = "veggiefoodbuffImmunity", amount = 1}
		})
		
	script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  
end