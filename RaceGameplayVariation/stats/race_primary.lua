function init()
	local bounds = mcontroller.boundBox() --Mcontroller for apex movement
end
  if world.getProperty("invinciblePlayers") then
    return {}
  end

  if damageRequest.damageSourceKind ~= "falling" and (self.hitInvulnerabilityTime > 0 or world.getProperty("nonCombat")) then
    return {}
  end

  local damage = 0
  
	if damageRequest.damageSourceKind == "electric" and world.entitySpecies(entity.id()) == "glitch" 
	or damageRequest.damageSourceKind == "electricaxe" and world.entitySpecies(entity.id()) == "glitch" 
	or damageRequest.damageSourceKind == "electricbarrier" and world.entitySpecies(entity.id()) == "glitch" 
	or damageRequest.damageSourceKind == "electricbroadsword" and world.entitySpecies(entity.id()) == "glitch" 
	or damageRequest.damageSourceKind == "electricdagger" and world.entitySpecies(entity.id()) == "glitch" 
	or damageRequest.damageSourceKind == "electrichammer" and world.entitySpecies(entity.id()) == "glitch" 
	or damageRequest.damageSourceKind == "electricplasma" and world.entitySpecies(entity.id()) == "glitch" 
	or damageRequest.damageSourceKind == "electricshortsword" and world.entitySpecies(entity.id()) == "glitch" 
	or damageRequest.damageSourceKind == "electricspear" and world.entitySpecies(entity.id()) == "glitch" then
		if damageRequest.damageType == "Damage" or damageRequest.damageType == "Knockback" then --Glitch electric damage request
			damage = damage + root.evalFunction2("protection", damageRequest.damage, status.stat("protection")) * 2
		elseif damageRequest.damageType == "IgnoresDef" then
			damage = damage + damageRequest.damage * 2
		end
	elseif damageRequest.damageType == "Damage" or damageRequest.damageType == "Knockback" then --Normal damage request
    damage = damage + root.evalFunction2("protection", damageRequest.damage, status.stat("protection"))
  elseif damageRequest.damageType == "IgnoresDef" then
    damage = damage + damageRequest.damage
  end
  
  if status.resourcePositive("damageAbsorption") then
    local damageAbsorb = math.min(damage, status.resource("damageAbsorption"))
    status.modifyResource("damageAbsorption", -damageAbsorb)
    damage = damage - damageAbsorb
  end

  if damageRequest.hitType == "ShieldHit" then
    if not status.resourcePositive("perfectBlock") then
      status.modifyResource("shieldStamina", -damage / status.stat("shieldHealth"))
    end
    status.setResourcePercentage("shieldStaminaRegenBlock", 1.0)
    damage = 0
    damageRequest.statusEffects = {}
  end

  local damageHealthPercentage = damage / status.resourceMax("health")

  if damage > 0 and damageRequest.damageType ~= "Knockback" then
    status.modifyResource("health", -damage)
    self.damageFlashTime = 0.07
    animator.playSound("ouch")
    if damageHealthPercentage > status.statusProperty("hitInvulnerabilityThreshold") then
      self.hitInvulnerabilityTime = status.statusProperty("hitInvulnerabilityTime") * math.min(damageHealthPercentage, 1.0)
    end
  end

  status.addEphemeralEffects(damageRequest.statusEffects, damageRequest.sourceEntityId)

  local knockbackFactor = (1 - status.stat("grit"))

  local knockbackMomentum = vec2.mul(damageRequest.knockbackMomentum, knockbackFactor)
  local knockback = vec2.mag(knockbackMomentum)
  if knockback > 0 then
    mcontroller.setVelocity({0,0})
    if mcontroller.baseParameters().gravityEnabled then
      local dir = knockbackMomentum[1] > 0 and 1 or -1
      mcontroller.addMomentum({dir * knockback / 1.41, knockback / 1.41})
    else
      mcontroller.addMomentum(knockbackMomentum)
    end
  end

	--Novakid death explosion
	if not status.resourcePositive("health") and world.entitySpecies(entity.id()) == "novakid" then
		world.spawnProjectile("zbomb", mcontroller.position(), 0, {0, 0}, false, { timeToLive = 0 })
	end
	
  return {{
    sourceEntityId = damageRequest.sourceEntityId,
    targetEntityId = entity.id(),
    position = mcontroller.position(),
    damage = damage,
    hitType = damageRequest.hitType,
    damageSourceKind = damageRequest.damageSourceKind,
    targetMaterialKind = status.statusProperty("targetMaterialKind"),
    killed = not status.resourcePositive("health")
  }}
end

function update(dt)
	--Apex stat trigger
	if world.entitySpecies(entity.id()) == "apex" then
		status.addEphemeralEffect("apexbiology",math.huge)
		mcontroller.controlModifiers({
				runModifier = 1.25,
				jumpModifier = 1.25
			})
	end
	
	--Floran stat trigger
	if world.entitySpecies(entity.id()) == "floran" then
		status.addEphemeralEffect("floranbiology",math.huge)
	end
	
	--Hylotl stat trigger
	if world.entitySpecies(entity.id()) == "hylotl" then
		status.addEphemeralEffect("hylotlbiology",math.huge)
	end
	
	--Glitch stat trigger
	if world.entitySpecies(entity.id()) == "glitch" then
		status.addEphemeralEffect("glitchbiology",math.huge)
	end
	
	--Noavkid stat trigger
	if world.entitySpecies(entity.id()) == "novakid" then
		status.addEphemeralEffect("novakidbiology",math.huge)
		status.addEphemeralEffect("xenonglow",math.huge)
	end
	
  self.hitInvulnerabilityTime = math.max(self.hitInvulnerabilityTime - dt, 0)
  local flashTime = status.statusProperty("hitInvulnerabilityFlash")
  self.damageFlashTime = math.max(0, self.damageFlashTime - dt)

  if self.hitInvulnerabilityTime > 0 and math.fmod(self.hitInvulnerabilityTime, flashTime) > flashTime / 2 then
    status.setPrimaryDirectives("multiply=ffffff00")
  elseif self.damageFlashTime > 0 then
    status.setPrimaryDirectives("fade=ff0000=0.85")
  else
    status.setPrimaryDirectives()
  end

  if status.resourceLocked("energy") and status.resourcePercentage("energy") == 1 then
    animator.playSound("energyRegenDone")
  end

  if status.resource("energy") == 0 then
    if not status.resourceLocked("energy") then
      animator.playSound("outOfEnergy")
      animator.burstParticleEmitter("outOfEnergy")
    end

    status.setResourceLocked("energy", true)
  elseif status.resourcePercentage("energy") == 1 then
    status.setResourceLocked("energy", false)
  end

  if not status.resourcePositive("energyRegenBlock") and world.entitySpecies(entity.id()) == "floran" then --Floran energy regen
		if world.lightLevel(mouthPosition) > 0.7 then
			status.modifyResourcePercentage("energy", 0.019)
		elseif world.lightLevel(mouthPosition) > 0.65 then
			status.modifyResourcePercentage("energy", 0.017)
		elseif world.lightLevel(mouthPosition) > 0.6 then
			status.modifyResourcePercentage("energy", 0.015)
		elseif world.lightLevel(mouthPosition) > 0.55 then
			status.modifyResourcePercentage("energy", 0.013)
		elseif world.lightLevel(mouthPosition) > 0.5 then
			status.modifyResourcePercentage("energy", 0.011)
		elseif world.lightLevel(mouthPosition) > 0.4 then
			status.modifyResourcePercentage("energy", 0.0095)
		elseif world.lightLevel(mouthPosition) > 0.4 then
			status.modifyResourcePercentage("energy", 0.008)
		elseif world.lightLevel(mouthPosition) > 0.35 then
			status.modifyResourcePercentage("energy", 0.0065)
		elseif world.lightLevel(mouthPosition) > 0.3 then
			status.modifyResourcePercentage("energy", 0.005)
		elseif world.lightLevel(mouthPosition) > 0.25 then
			status.modifyResourcePercentage("energy", 0.004)
		elseif world.lightLevel(mouthPosition) > 0.2 then
			status.modifyResourcePercentage("energy", 0.003)
		elseif world.lightLevel(mouthPosition) < 0.2 then
			status.modifyResourcePercentage("energy", 0.001)
		end
	elseif not status.resourcePositive("energyRegenBlock") and world.entitySpecies(entity.id()) == "hylotl" and world.liquidAt(mouthPosition) then
		status.modifyResourcePercentage("energy", status.stat("energyRegenPercentageRate") * dt + 0.008)
	elseif not status.resourcePositive("energyRegenBlock") then
    status.modifyResourcePercentage("energy", status.stat("energyRegenPercentageRate") * dt)
  end

  if not status.resourcePositive("shieldStaminaRegenBlock") then
    status.modifyResourcePercentage("shieldStamina", status.stat("shieldStaminaRegen") * dt)
    status.modifyResourcePercentage("perfectBlockLimit", status.stat("perfectBlockLimitRegen") * dt)
  end
	
	--Floran health regen
	if world.entitySpecies(entity.id()) == "floran" then
		if world.lightLevel(mouthPosition) > 0.6 then
			status.modifyResourcePercentage("health", 0.0008)
		elseif world.lightLevel(mouthPosition) > 0.55 then
			status.modifyResourcePercentage("health", 0.0007)
		elseif world.lightLevel(mouthPosition) > 0.5 then
			status.modifyResourcePercentage("health", 0.0006)
		elseif world.lightLevel(mouthPosition) > 0.4 then
			status.modifyResourcePercentage("health", 0.0005)
		elseif world.lightLevel(mouthPosition) > 0.4 then
			status.modifyResourcePercentage("health", 0.0004)
		elseif world.lightLevel(mouthPosition) > 0.35 then
				status.modifyResourcePercentage("health", 0.0003)
		elseif world.lightLevel(mouthPosition) > 0.3 then
			status.modifyResourcePercentage("health", 0.0002)
		elseif world.lightLevel(mouthPosition) > 0.25 then
			status.modifyResourcePercentage("health", 0.0001)
		elseif world.lightLevel(mouthPosition) > 0.2 then
			status.modifyResourcePercentage("health", 0.00005)
		end
	end
end

function overheadBars()
  if status.statPositive("shieldHealth") then
    return {{
      percentage = status.resource("shieldStamina"),
      color = status.resourcePositive("perfectBlock") and {255, 255, 200, 255} or {200, 200, 0, 255}
    }}
  end

  return {}
end
