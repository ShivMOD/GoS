if GetObjectName(myHero) ~= "Braum" then return end
PrintChat("ShivAIO | Braum v1.2")
BraumMenu = Menu("Braum", "Braum")
BraumMenu:SubMenu("Combo", "Combo")
BraumMenu.Combo:Boolean("Q", "Use Q", true)
BraumMenu.Combo:Boolean("E", "Use E", true)
BraumMenu.Combo:Boolean("R", "Use R", true)
BraumMenu.Combo:Boolean("Items", "Use Items", true)
BraumMenu.Combo:Key("sbm", "Use W to ally or minion", string.byte("G"))

BraumMenu:SubMenu("Harass", "Harass")
BraumMenu.Harass:Boolean("Q", "Use Q", true)

BraumMenu:SubMenu("Drawings", "Drawings")
BraumMenu.Drawings:Boolean("Q", "Draw Q Range", false)
BraumMenu.Drawings:Boolean("W", "Draw W Range", false)
BraumMenu.Drawings:Boolean("R", "Draw R Range", false)

BraumMenu:SubMenu("Autolevel", "Auto Level")
BraumMenu.Autolevel:Boolean("Autolvl", "Auto level", false)




OnLoop(function(myHero)

for _, ally in pairs(GoS:GetAllyHeroes()) do
if CanUseSpell(myHero, _W) and BraumMenu.Combo.sbm:Value() and GoS:GetDistance(myHero, ally) <= 650 and IsObjectAlive(ally) and ally ~= myHero then
			CastTargetSpell(ally, _W)
					end
					end
					
for i, minion in pairs(GoS:GetAllMinions(MINION_ALLY)) do
if CanUseSpell(myHero, _W) and BraumMenu.Combo.sbm:Value() and GoS:GetDistance(myHero, minion) <= 650 and IsObjectAlive(minion) and GoS:AlliesAround(GoS:myHeroPos(), 650) == 0 then
			CastTargetSpell(minion, _W)
					end
					end



if IOW:Mode() == "Combo" then
	local target = GetCurrentTarget()
	local rangeQ = GetCastRange(myHero, _Q)
	local rangeR = GetCastRange(myHero, _R)
	local Qprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1650,300,rangeQ,80,true,true)
	local Rprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),2500,1000,rangeR,120,false,true)
      
	  if CanUseSpell(myHero, _Q) == READY and BraumMenu.Combo.Q:Value() and GoS:ValidTarget(target, 1000) and Qprediction.HitChance == 1 then
	  CastSkillShot(_Q,Qprediction.PredPos.x, Qprediction.PredPos.y, Qprediction.PredPos.z)
      end
		
		for _, ally in pairs(GoS:GetAllyHeroes()) do
		if GetItemSlot(myHero,3401) > 0 and BraumMenu.Combo.Items:Value() and IsObjectAlive(ally) and ally ~= myHero and GoS:IsInDistance(ally, 700) and 100*GetCurrentHP(ally)/GetMaxHP(ally) < 20 then
        CastTargetSpell(ally, GetItemSlot(myHero,3401)) --FotM
		end
				end
	  
	  local enemyPos = GetOrigin(target)
      if CanUseSpell(myHero, _E) == READY and BraumMenu.Combo.E:Value() and GoS:ValidTarget(target, 850) then
	  CastSkillShot(_E,enemyPos.x, enemyPos.y, enemyPos.z)
      end
	  
	  if BraumMenu.Combo.R:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1250) and Rprediction.HitChance == 1 and 100*GetCurrentHP(target)/GetMaxHP(target) < 50 then
      CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)

	elseif BraumMenu.Combo.R:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1250) and Rprediction.HitChance == 1 and GoS:AlliesAround(GoS:myHeroPos(), 1250)+1 < GoS:EnemiesAround(GoS:myHeroPos(), 850)  then
      CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
	  
	  elseif BraumMenu.Combo.R:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1250) and Rprediction.HitChance == 1 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 20 and GoS:EnemiesAround(GoS:myHeroPos(), 600) then
	  CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
      end
		
  
		if GetItemSlot(myHero,3401) > 0 and BraumMenu.Combo.Items:Value() and GoS:EnemiesAround(GoS:myHeroPos(), 1250) > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 20 then
        CastTargetSpell(myHero, GetItemSlot(myHero,3401)) --FotM
        end
		
end

if IOW:Mode() == "Harass" then
local target = GetCurrentTarget()
local rangeQ = GetCastRange(myHero, _Q)
local Qprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1650,300,rangeQ,80,true,true)
if CanUseSpell(myHero, _Q) == READY and BraumMenu.Harass.Q:Value() and GoS:ValidTarget(target, 1000) and Qprediction.HitChance == 1 then
CastSkillShot(_Q,Qprediction.PredPos.x, Qprediction.PredPos.y, Qprediction.PredPos.z)
end
end




if BraumMenu.Drawings.Q:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_Q),3,100,0xff0000ff) end
if BraumMenu.Drawings.W:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_W),3,100,0xff0000ff) end
if BraumMenu.Drawings.R:Value() then DrawCircle(GoS:myHeroPos().x, GoS:myHeroPos().y, GoS:myHeroPos().z,GetCastRange(myHero,_R),3,100,0xff0000ff) end

if BraumMenu.Autolevel.Autolvl:Value() then
        local level = GetLevel(myHero)
 
                        if level == 1 then
                                LevelSpell(_Q)
                        elseif level == 2 then
                                LevelSpell(_E)
                        elseif level == 3 then
                                LevelSpell(_W)
                        elseif level == 4 then
                                LevelSpell(_Q)
                        elseif level == 5 then
                                LevelSpell(_Q)
                        elseif level == 6 then
                                LevelSpell(_R)
                        elseif level == 7 then
                                LevelSpell(_Q)
                        elseif level == 8 then
                                LevelSpell(_W)
                        elseif level == 9 then
                                LevelSpell(_Q)
                        elseif level == 10 then
                                LevelSpell(_W)
                        elseif level == 11 then
                                LevelSpell(_R)
                        elseif level == 12 then
                                LevelSpell(_W)
                        elseif level == 13 then
                                LevelSpell(_W)
                        elseif level == 14 then
                                LevelSpell(_E)
                        elseif level == 15 then
                                LevelSpell(_E)
                        elseif level == 16 then
                                LevelSpell(_R)
                        elseif level == 17 then
                                LevelSpell(_E)
                        elseif level == 18 then
                                LevelSpell(_E)
                        end
						end


end)