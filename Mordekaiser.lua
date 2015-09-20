if GetObjectName(myHero) ~= "Mordekaiser" then return end
PrintChat("Misery Loves Company by Shiv loaded, v1.2, IOW version")
MordekaiserMenu = Menu("Mordekaiser", "Mordekaiser")
MordekaiserMenu:SubMenu("Combo", "Combo")
MordekaiserMenu.Combo:Boolean("Q", "Use Q", true)
MordekaiserMenu.Combo:Boolean("W", "Use W", true)
MordekaiserMenu.Combo:Boolean("E", "Use E", true)
MordekaiserMenu.Combo:Boolean("R", "Use R", true)
MordekaiserMenu.Combo:Boolean("Items", "Use Items", true)
MordekaiserMenu.Combo:Boolean("QSS", "Use QSS", true)
MordekaiserMenu.Combo:Slider("QSSHP", "if my health % is lower than", 75, 0, 100, 1)

MordekaiserMenu:SubMenu("Farm", "Farm")
MordekaiserMenu.Farm:Boolean("QLC", "Clear lane with Q", true)
MordekaiserMenu.Farm:Boolean("WLC", "Clear lane with W", false)
MordekaiserMenu.Farm:Boolean("ELC", "Clear lane with E", true)

MordekaiserMenu:SubMenu("JungleClear", "Jungle Clear")
MordekaiserMenu.JungleClear:Boolean("QJC", "Clear jungle with Q", true)
MordekaiserMenu.JungleClear:Boolean("WJC", "Clear jungle with W", true)
MordekaiserMenu.JungleClear:Boolean("EJC", "Clear jungle with E", true)

MordekaiserMenu:SubMenu("Drawings", "Drawings")
MordekaiserMenu.Drawings:Boolean("Q", "Draw AA/Q Range", false)
MordekaiserMenu.Drawings:Boolean("W", "Draw W Range", false)
MordekaiserMenu.Drawings:Boolean("E", "Draw E Range", false)
MordekaiserMenu.Drawings:Boolean("R", "Draw R Range", false)

MordekaiserMenu:SubMenu("Autolevel", "Auto Level")
MordekaiserMenu.Autolevel:Boolean("Autolvl", "Auto level", false)


OnLoop(function(myHero)
if IOW:Mode() == "Combo" then
	local target = GetCurrentTarget()
	  
      if CanUseSpell(myHero, _Q) == READY and MordekaiserMenu.Combo.Q:Value() and GoS:ValidTarget(target, 250) then
      CastSpell(_Q)
      end
	  
	  if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 1000) and MordekaiserMenu.Combo.W:Value() and GotBuff(myHero, "mordekaisercreepingdeath") == 0 then 
	  CastTargetSpell(target, _W)
	  end
	  
	  if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "mordekaisercreepingdeath") > 0 and GoS:EnemiesAround(GoS:myHeroPos(), 250) > 0 then 
	  CastSpell(_W)
	  end
	  
	  local rangeE = GetCastRange(myHero, _E)
	  local Eprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1300,250,rangeE,50,false,true)
      
	  if CanUseSpell(myHero, _E) == READY and MordekaiserMenu.Combo.E:Value() and GoS:ValidTarget (target, 675) and Eprediction.HitChance == 1 then
   
       CastSkillShot(_E,Eprediction.PredPos.x, Eprediction.PredPos.y, Eprediction.PredPos.z)
	end
      
	  if MordekaiserMenu.Combo.R:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 650) and 100*GetCurrentHP(target)/GetMaxHP(target) < 30 then
      CastTargetSpell(target, _R)
      end
	  
	  if GetItemSlot(myHero,3140) > 0 and MordekaiserMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < MordekaiserMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end
		
		if GetItemSlot(myHero,3139) > 0 and MordekaiserMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < MordekaiserMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
		if GetItemSlot(myHero,3144) > 0 and MordekaiserMenu.Combo.Items:Value() and GoS:ValidTarget(target, 550) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 50 and 100*GetCurrentHP(target)/GetMaxHP(target) > 20 then
        CastTargetSpell(target, GetItemSlot(myHero,3144)) --cutlass
        end
		
		if GetItemSlot(myHero,3146) > 0 and MordekaiserMenu.Combo.Items:Value() and GoS:ValidTarget(target, 675) and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 50 and 100*GetCurrentHP(target)/GetMaxHP(target) > 20 then
        CastTargetSpell(target, GetItemSlot(myHero,3146)) --gunblade
        end
  
		if GetItemSlot(myHero,3401) > 0 and MordekaiserMenu.Combo.Items:Value() and GoS:EnemiesAround(GoS:myHeroPos(), 650) > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 20 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3401)) --FotM
        end
		
end
		

for i,unit in pairs(GoS:GetAllMinions(MINION_ENEMY)) do  
if IOW:Mode() == "LaneClear" then
       
	   if GoS:ValidTarget(unit, 200) and MordekaiserMenu.Farm.QLC:Value() and CanUseSpell(myHero, _Q) == READY then
            CastSpell(_Q)            
            end  
		
		if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(unit, 250) and MordekaiserMenu.Farm.WLC:Value() and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 60 then 
			CastTargetSpell(myHero, _W)
			end			  
                           
		local minionposition = GetOrigin(unit)    
        if GoS:ValidTarget(unit, GetCastRange(myHero, _E)) and MordekaiserMenu.Farm.ELC:Value() and CanUseSpell(myHero, _E) == READY then
            CastSkillShot(_E,minionposition.x,minionposition.y, minionposition.z)
			end
end
end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
if IOW:Mode() == "LaneClear" then

if CanUseSpell(myHero, _Q) == READY and MordekaiserMenu.JungleClear.QJC:Value() and GoS:ValidTarget(mob, 200) then
      CastSpell(_Q)
      end
if CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(mob, 250) and MordekaiserMenu.JungleClear.WJC:Value() and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 90 then 
	  CastTargetSpell(myHero, _W)
				end  
	  
	  local mobPos = GetOrigin(mob)
	  if CanUseSpell(myHero, _E) == READY and MordekaiserMenu.JungleClear.EJC:Value() and GoS:ValidTarget(mob, GetCastRange(myHero, _E)) then
		CastSkillShot(_E, mobPos.x, mobPos.y, mobPos.z)
		end
end

end
if MordekaiserMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetRange(myHero),3,100,0xff0000ff) end
if MordekaiserMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff0000ff) end
if MordekaiserMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff0000ff) end
if MordekaiserMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),3,100,0xff0000ff) end

if MordekaiserMenu.Autolevel.Autolvl:Value() then
        local level = GetLevel(myHero)
 
                        if level == 1 then
                                LevelSpell(_E)
                        elseif level == 2 then
                                LevelSpell(_Q)
                        elseif level == 3 then
                                LevelSpell(_W)
                        elseif level == 4 then
                                LevelSpell(_E)
                        elseif level == 5 then
                                LevelSpell(_E)
                        elseif level == 6 then
                                LevelSpell(_R)
                        elseif level == 7 then
                                LevelSpell(_Q)
                        elseif level == 8 then
                                LevelSpell(_E)
                        elseif level == 9 then
                                LevelSpell(_W)
                        elseif level == 10 then
                                LevelSpell(_E)
                        elseif level == 11 then
                                LevelSpell(_R)
                        elseif level == 12 then
                                LevelSpell(_Q)
                        elseif level == 13 then
                                LevelSpell(_Q)
                        elseif level == 14 then
                                LevelSpell(_Q)
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