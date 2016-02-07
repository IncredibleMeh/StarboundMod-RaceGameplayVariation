function init()
   effect.addStatModifierGroup({{stat = "maxHealth", amount = effect.configParameter("healthAmount", 0)}})

   script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  
end