function init()
	script.setUpdateDelta(5)
	
	status.applySelfDamageRequest({
		damageType = "IgnoresDef",
		damage = math.floor(status.resourceMax("health") * 0.025) + 20,
		damageSourceKind = "default",
		sourceEntityId = entity.id()
	})
end

function update(dt)

end

function uninit()
  
end