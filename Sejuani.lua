if GetObjectName(myHero) ~= "Sejuani" then return end
PrintChat("ShivAIO | Sejuani v1.0")
SejuaniMenu = Menu("Sejuani", "Sejuani")
SejuaniMenu:SubMenu("Combo", "Combo")
SejuaniMenu.Combo:Boolean("Q", "Use Q", true)
SejuaniMenu.Combo:Boolean("W", "Use W", true)
SejuaniMenu.Combo:Boolean("E", "Use E", true)
SejuaniMenu.Combo:Boolean("R", "Use R when enemy is low HP", true)
SejuaniMenu.Combo:Boolean("gankR", "Use R when outnumbered", true)
SejuaniMenu.Combo:Boolean("lowR", "Use R when team is low HP", true)
SejuaniMenu.Combo:Boolean("Items", "Use Items", true)
SejuaniMenu.Combo:Boolean("QSS", "Use QSS", true)
SejuaniMenu.Combo:Slider("QSSHP", "if my health % is lower than", 75, 0, 100, 1)

SejuaniMenu:SubMenu("Farm", "Farm")
SejuaniMenu.Farm:Boolean("WLC", "Clear lane with W", true)
SejuaniMenu.Farm:Boolean("ELC", "Clear lane with E", true)

SejuaniMenu:SubMenu("JungleClear", "Jungle Clear")
SejuaniMenu.JungleClear:Boolean("QJC", "Clear jungle with Q", true)
SejuaniMenu.JungleClear:Boolean("WJC", "Clear jungle with W", true)
SejuaniMenu.JungleClear:Boolean("EJC", "Clear jungle with E", true)

SejuaniMenu:SubMenu("Misc", "Misc")
SejuaniMenu.Misc:Key("dash", "Use Q to mouse pos:", string.byte("G"))

SejuaniMenu:SubMenu("Drawings", "Drawings")
SejuaniMenu.Drawings:Boolean("Q", "Draw Q Range", false)
SejuaniMenu.Drawings:Boolean("W", "Draw W Range", false)
SejuaniMenu.Drawings:Boolean("E", "Draw E Range", false)
SejuaniMenu.Drawings:Boolean("R", "Draw R Range", false)

SejuaniMenu:SubMenu("Autolevel", "Auto Level")
SejuaniMenu.Autolevel:Boolean("Autolvl", "Auto level", false)


OnLoop(function(myHero)

local mousepos = GetMousePos()
if SejuaniMenu.Misc.dash:Value() then
CastSkillShot(_Q, mousepos.x, mousepos.y, mousepos.z)
end

if IOW:Mode() == "Combo" then
	local target = GetCurrentTarget()
	local Qprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1200,250,650,60,false,true)
	local Rprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1300,250,1250,80,false,true)
	  
      if CanUseSpell(myHero, _Q) == READY and SejuaniMenu.Combo.Q:Value() and GoS:ValidTarget(target, 650) then
      CastSkillShot(_Q,Qprediction.PredPos.x, Qprediction.PredPos.y, Qprediction.PredPos.z)
      end
	  
	  if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "sejuaninorthernwindsenrage") < 1 and GoS:ValidTarget(target, 350) and SejuaniMenu.Combo.W:Value() then 
	  CastSpell(_W)
	  end
	  
	  if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "sejuaninorthernwindsenrage") > 0 and not GoS:ValidTarget(target, 125) and SejuaniMenu.Combo.W:Value() then 
	  CastSpell(_W)
	  end
	  
	if CanUseSpell(myHero, _E) == READY and SejuaniMenu.Combo.E:Value() and GoS:ValidTarget(target, 1000) and GotBuff(target, "sejuanifrost") > 0 and GotBuff(target, "stun") < 1  then
      CastTargetSpell(target, _E)
		end
		
if SejuaniMenu.Combo.R:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1175) and Rprediction.HitChance == 1 and 100*GetCurrentHP(target)/GetMaxHP(target) < 50 then
CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
end

if SejuaniMenu.Combo.gankR:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1175) and Rprediction.HitChance == 1 and GoS:AlliesAround(GoS:myHeroPos(), 1500)+1 < GoS:EnemiesAround(GoS:myHeroPos(), 850) then
CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
end

if SejuaniMenu.Combo.lowR:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1175) and Rprediction.HitChance == 1 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 20 and GoS:EnemiesAround(GoS:myHeroPos(), 800) then
CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
end

for _, ally in pairs(GoS:GetAllyHeroes()) do
if SejuaniMenu.Combo.lowR:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1175) and Rprediction.HitChance == 1 and 100*GetCurrentHP(ally)/GetMaxHP(ally) < 20 and GoS:EnemiesAround(GoS:myHeroPos(), 1175) then
CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
end
end
	  
	  if GetItemSlot(myHero,3140) > 0 and SejuaniMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < SejuaniMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3140))
        end
		
		if GetItemSlot(myHero,3139) > 0 and SejuaniMenu.Combo.QSS:Value() and GotBuff(myHero, "rocketgrab2") > 0 or GotBuff(myHero, "charm") > 0 or GotBuff(myHero, "fear") > 0 or GotBuff(myHero, "flee") > 0 or GotBuff(myHero, "snare") > 0 or GotBuff(myHero, "taunt") > 0 or GotBuff(myHero, "suppression") > 0 or GotBuff(myHero, "stun") > 0 or GotBuff(myHero, "zedultexecute") > 0 or GotBuff(myHero, "summonerexhaust") > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < SejuaniMenu.Combo.QSSHP:Value() then
        CastTargetSpell(myHero, GetItemSlot(myHero,3139))
        end
		
end

		

for i,unit in pairs(GoS:GetAllMinions(MINION_ENEMY)) do  
if IOW:Mode() == "LaneClear" then
       
	   if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "sejuaninorthernwindsenrage") < 1 and GoS:ValidTarget(unit, 350) and SejuaniMenu.Farm.WLC:Value() then 
	  CastSpell(_W)
	  end
	  
	  if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "sejuaninorthernwindsenrage") > 0 and not GoS:ValidTarget(unit, 125) and SejuaniMenu.Farm.WLC:Value() then 
	  CastSpell(_W)
	  end 
         
		 if CanUseSpell(myHero, _E) == READY and SejuaniMenu.Farm.ELC:Value() and GoS:ValidTarget(unit, 1000) and GotBuff(unit, "sejuanifrost") > 0 then
      CastTargetSpell(unit, _E)
		end
		
end
end

for _,mob in pairs(GoS:GetAllMinions(MINION_JUNGLE)) do
if IOW:Mode() == "LaneClear" then
local minionposition = GetOrigin(mob)
if CanUseSpell(myHero, _Q) == READY and SejuaniMenu.JungleClear.QJC:Value() and GoS:ValidTarget(mob, 650) then
      CastSkillShot(_Q,minionposition.x,minionposition.y, minionposition.z)
      end

	 if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "sejuaninorthernwindsenrage") < 1 and GoS:ValidTarget(mob, 350) and SejuaniMenu.JungleClear.WJC:Value() then 
	  CastSpell(_W)
	  end
	  
	  if CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "sejuaninorthernwindsenrage") > 0 and not GoS:ValidTarget(mob, 125) and SejuaniMenu.JungleClear.WJC:Value() then 
	  CastSpell(_W)
	  end 
         
		 if CanUseSpell(myHero, _E) == READY and SejuaniMenu.JungleClear.EJC:Value() and GoS:ValidTarget(mob, 1000) and GotBuff(mob, "sejuanifrost") > 0 then
      CastTargetSpell(mob, _E)
		end
end

end
if SejuaniMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),3,100,0xff0000ff) end
if SejuaniMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff0000ff) end
if SejuaniMenu.Drawings.E:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_E),3,100,0xff0000ff) end
if SejuaniMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),3,100,0xff0000ff) end


if SejuaniMenu.Autolevel.Autolvl:Value() then
        local level = GetLevel(myHero)
 
                        if level == 1 then
                                LevelSpell(_W)
                        elseif level == 2 then
                                LevelSpell(_Q)
                        elseif level == 3 then
                                LevelSpell(_E)
                        elseif level == 4 then
                                LevelSpell(_W)
                        elseif level == 5 then
                                LevelSpell(_E)
                        elseif level == 6 then
                                LevelSpell(_R)
                        elseif level == 7 then
                                LevelSpell(_E)
                        elseif level == 8 then
                                LevelSpell(_E)
                        elseif level == 9 then
                                LevelSpell(_E)
                        elseif level == 10 then
                                LevelSpell(_Q)
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