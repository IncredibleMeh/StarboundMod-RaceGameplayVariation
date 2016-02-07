function init()
   effect.addStatModifierGroup({{stat = "maxEnergy", amount = effect.configParameter("energyAmount", 0)}})

   script.setUpdateDelta(0)
end

function update(dt)

end

function uninit()
  
end