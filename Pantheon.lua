if GetObjectName(myHero) ~= "Pantheon" then return end
PrintChat("Pantheon by Shiv loaded, v1.0")
PantheonMenu = Menu("Pantheon", "Pantheon")
PantheonMenu:SubMenu("Combo", "Combo")
PantheonMenu.Combo:Boolean("Q", "Use Q", true)
PantheonMenu.Combo:Boolean("W", "Use W", true)
PantheonMenu.Combo:Boolean("E", "Use E", true)
PantheonMenu.Combo:Boolean("Items", "Use Items", true)
PantheonMenu.Combo:Boolean("QSS", "Use QSS", true)
PantheonMenu.Combo:Slider("QSSHP", "if my health % is lower than", 75, 0, 100, 1)

PantheonMenu:SubMenu("Farm", "Farm")
PantheonMenu.Farm:Boolean("QLC", "Clear lane with Q", true)
PantheonMenu.Farm:Boolean("ELC", "Clear lane with E", true)

PantheonMenu:SubMenu("JungleClear", "Jungle Clear")
PantheonMenu.JungleClear:Boolean("QJC", "Clear jungle with Q", true)
PantheonMenu.JungleClear:Boolean("WJC", "Clear jungle with W", true)
PantheonMenu.JungleClear:Boolean("EJC", "Clear jungle with E", true)

PantheonMenu:SubMenu("Drawings", "Drawings")
PantheonMenu.Drawings:Boolean("Q", "Draw Q Range", false)
PantheonMenu.Drawings:Boolean("W", "Draw W Range", false)
PantheonMenu.Drawings:Boolean("E", "Draw E Range", false)
PantheonMenu.Drawings:Boolean("R", "Draw R Range", false)

PantheonMenu:SubMenu("Autolevel", "Auto Level")
PantheonMenu.Autolevel:Boolean("Autolvl", "Auto level", false)


OnLoop(function(myHero)
if GotBuff(myHero, "pantheonesound") > 0 then
  IOW:DisableOrbwalking()
  elseif GotBuff(myHero, "pantheonesound") < 1 then 
  IOW:EnableOrbwalking()
  end
if IOW:Mode() == "Combo" then
	local target = GetCurrentTarget()
	  
      if CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "pantheonesound") < 1 and PantheonMenu.Combo.Q:Value() and GoS:ValidTarget(target, 600) then
      CastTargetSpell(target, _Q)
      end
	  
	  if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "pantheonesound") < 1 and GoS:ValidTarget(target, 600) and PantheonMenu.Combo.W:Value() then 
	  CastTargetSpell(target, _W)
	  end
	  
		local Eprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),250,250,600,120,false,true)
      
	  if CanUseSpell(myHero, _E) == READY and PantheonMenu.Combo.E:Value() and GoS:ValidTarget(target, 600) and Eprediction.HitChance == 1 then
      IOW:DisableOrbwalking()
		CastSkillShot(_E,Eprediction.PredPos.x, Eprediction.PredPos.y, Eprediction.PredPos.z)
	   
	end
	  
	  if GetItemSlot(myHero,3140) > 0 and PantheonMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < PantheonMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end
		
		if GetItemSlot(myHero,3139) > 0 and PantheonMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < PantheonMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
		if GetItemSlot(myHero,3077) > 0 and PantheonMenu.Combo.Items:Value() and GotBuff(myHero, "pantheonesound") < 1 and GoS:ValidTarget(target, 400) then
        CastTargetSpell(target, GetItemSlot(myHero,3077)) --tiamat
		end
		
		if GetItemSlot(myHero,3074) > 0 and PantheonMenu.Combo.Items:Value() and GotBuff(myHero, "pantheonesound") < 1 and GoS:ValidTarget(target, 400) then
        CastTargetSpell(target, GetItemSlot(myHero,3074)) --hydra
		end
		
  
	
		
end
		

for i,unit in pairs(GoS:GetAllMinions(MINION_ENEMY)) do  
if IOW:Mode() == "LaneClear" then
       
	   if GoS:ValidTarget(unit, 600) and GotBuff(myHero, "pantheonesound") < 1 and PantheonMenu.Farm.QLC:Value() and CanUseSpell(myHero, _Q) == READY then
            CastTargetSpell(unit, _Q)          
            end  		  
                           
		local minionposition = GetOrigin(unit)    
        if GoS:ValidTarget(unit, 600) and PantheonMenu.Farm.ELC:Value() and CanUseSpell(myHero, _E) == READY then
		IOW:DisableOrbwalking()
		CastSkillShot(_E,minionposition.x,minionposition.y, minionposition.z)
			end
			
			if GetItemSlot(myHero,3077) > 0 and PantheonMenu.Combo.Items:Value() and GotBuff(myHero, "pantheonesound") < 1 and GoS:ValidTarget(unit, 400) then
        CastTargetSpell(unit, GetItemSlot(myHero,3077)) --tiamat
		end
		
		if GetItemSlot(myHero,3074) > 0 and PantheonMenu.Combo.Items:Value() and GotBuff(myHero, "pantheonesound") < 1 and GoS:ValidTarget(unit, 400) then
        CastTargetSpell(unit, GetItemSlot(myHero,3074)) --hydra
		end
end
end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
if IOW:Mode() == "LaneClear" then

if CanUseSpell(myHero, _Q) == READY and GotBuff(myHero, "pantheonesound") < 1 and PantheonMenu.JungleClear.QJC:Value() and GoS:ValidTarget(mob, 600) then
      CastTargetSpell(mob, _Q)
      end

	 if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "pantheonesound") < 1 and GoS:ValidTarget(mob, 600) and PantheonMenu.JungleClear.WJC:Value() then 
	  CastTargetSpell(mob, _W)
				end  
	  
	  local mobPos = GetOrigin(mob)
	  if CanUseSpell(myHero, _E) == READY and PantheonMenu.JungleClear.EJC:Value() and GoS:ValidTarget(mob, 600) then
		IOW:DisableOrbwalking()
		CastSkillShot(_E, mobPos.x, mobPos.y, mobPos.z)
		end
		
		if GetItemSlot(myHero,3077) > 0 and PantheonMenu.Combo.Items:Value() and GotBuff(myHero, "pantheonesound") < 1 and GoS:ValidTarget(mob, 400) then
        CastTargetSpell(mob, GetItemSlot(myHero,3077)) --tiamat
		end
		
		if GetItemSlot(myHero,3074) > 0 and PantheonMenu.Combo.Items:Value() and GotBuff(myHero, "pantheonesound") < 1 and GoS:ValidTarget(mob, 400) then
        CastTargetSpell(mob, GetItemSlot(myHero,3074)) --hydra
		end
end

end
if PantheonMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),3,100,0xff0000ff) end
if PantheonMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff0000ff) end
if PantheonMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff0000ff) end
if PantheonMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),3,100,0xff0000ff) end


if PantheonMenu.Autolevel.Autolvl:Value() then
        local level = GetLevel(myHero)
 
                        if level == 1 then
                                LevelSpell(_Q)
                        elseif level == 2 then
                                LevelSpell(_W)
                        elseif level == 3 then
                                LevelSpell(_Q)
                        elseif level == 4 then
                                LevelSpell(_E)
                        elseif level == 5 then
                                LevelSpell(_Q)
                        elseif level == 6 then
                                LevelSpell(_R)
                        elseif level == 7 then
                                LevelSpell(_Q)
                        elseif level == 8 then
                                LevelSpell(_E)
                        elseif level == 9 then
                                LevelSpell(_Q)
                        elseif level == 10 then
                                LevelSpell(_E)
                        elseif level == 11 then
                                LevelSpell(_R)
                        elseif level == 12 then
                                LevelSpell(_E)
                        elseif level == 13 then
                                LevelSpell(_E)
                        elseif level == 14 then
                                LevelSpell(_W)
                        elseif level == 15 then
                                LevelSpell(_W)
                        elseif level == 16 then
                                LevelSpell(_R)
                        elseif level == 17 then
                                LevelSpell(_W)
                        elseif level == 18 then
                                LevelSpell(_W)
                        end
						end
end)