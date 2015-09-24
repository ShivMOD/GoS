if GetObjectName(myHero) ~= "Braum" then return end
PrintChat("ShivAIO | Braum v1.3")
BraumMenu = Menu("Braum", "Braum")
BraumMenu:SubMenu("Combo", "Combo")
BraumMenu.Combo:Boolean("Q", "Use Q", true)
BraumMenu.Combo:Key("sbm", "Use W to ally or minion on:", string.byte("G"))
BraumMenu.Combo:Boolean("E", "Use E", true)
BraumMenu.Combo:Boolean("R", "Use R when enemy is low HP", true)
BraumMenu.Combo:Boolean("gankR", "Use R when outnumbered", true)
BraumMenu.Combo:Boolean("lowR", "Use R when team is low HP", true)
BraumMenu.Combo:Boolean("Items", "Use Items", true)

BraumMenu:SubMenu("Harass", "Harass")
BraumMenu.Harass:Boolean("Q", "Use Q", true)

BraumMenu:SubMenu("Drawings", "Drawings")
BraumMenu.Drawings:Boolean("Q", "Draw Q Range", false)
BraumMenu.Drawings:Boolean("W", "Draw W Range", false)
BraumMenu.Drawings:Boolean("R", "Draw R Range", false)

BraumMenu:SubMenu("Autolevel", "Auto Level")
BraumMenu.Autolevel:Boolean("Autolvl", "Auto level", false)

target = GetCurrentTarget()
forEtar = GetCurrentTarget()

OnProcessSpell(function(forEtar, spell) -- Thank you Cloud :3

myHero = GetMyHero()
if BraumMenu.Combo.E:Value() and CanUseSpell(myHero, _E) == READY then
if forEtar and GetTeam(forEtar) ~= GetTeam(myHero) and GetObjectType(forEtar) == GetObjectType(myHero) and GoS:GetDistance(forEtar) < 1500 then
if myHero == spell.target and GoS:CalcDamage(forEtar, myHero, GetBonusDmg(forEtar)+GetBaseDamage(forEtar))/GetCurrentHP(myHero) > 0.1337 and not spell.name:lower():find("attack") then
local ePos = GetOrigin(forEtar)
CastSkillShot(_E, ePos.x, ePos.y, ePos.z)
elseif spell.endPos and not spell.name:lower():find("attack") then
local makeUpPos = GenerateSpellPos(GetOrigin(forEtar), spell.endPos, GoS:GetDistance(forEtar, myHero))
if GoS:GetDistanceSqr(makeUpPos) < (GetHitBox(myHero)*3)^2 or GoS:GetDistanceSqr(spell.endPos) < (GetHitBox(myHero)*3)^2 then
local ePos = GetOrigin(forEtar)
CastSkillShot(_E, ePos.x, ePos.y, ePos.z)
end
end
end
end
end)

function GenerateSpellPos(unitPos, spellPos, range)
local tV = {x = (spellPos.x-unitPos.x), z = (spellPos.z-unitPos.z)}
local len = math.sqrt(tV.x * tV.x + tV.z * tV.z)
return {x = unitPos.x + range * tV.x / len, y = 0, z = unitPos.z + range * tV.z / len}
end



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
local Qprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,300,1000,80,true,true)
local Rprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1600,300,1250,120,false,true)
      
if CanUseSpell(myHero, _Q) == READY and BraumMenu.Combo.Q:Value() and GoS:ValidTarget(target, 1000) and Qprediction.HitChance == 1 then
CastSkillShot(_Q,Qprediction.PredPos.x, Qprediction.PredPos.y, Qprediction.PredPos.z)
end
		
for _, ally in pairs(GoS:GetAllyHeroes()) do

if GetItemSlot(myHero,3401) > 0 and BraumMenu.Combo.Items:Value() and IsObjectAlive(ally) and ally ~= myHero and GoS:IsInDistance(ally, 700) and 100*GetCurrentHP(ally)/GetMaxHP(ally) < 20 then
CastTargetSpell(ally, GetItemSlot(myHero,3401)) --FotM
end

if GetItemSlot(myHero,3190) > 0 and BraumMenu.Combo.Items:Value() and GoS:IsInDistance(ally, 600) and ally ~= myHero and 100*GetCurrentHP(ally)/GetMaxHP(ally) < 50 and GoS:EnemiesAround(GoS:myHeroPos(), 1500) > 0 then
CastTargetSpell(myHero, GetItemSlot(myHero,3190)) --locket
end

if BraumMenu.Combo.lowR:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1250) and Rprediction.HitChance == 1 and 100*GetCurrentHP(ally)/GetMaxHP(ally) < 20 and GoS:EnemiesAround(GoS:myHeroPos(), 800) then
CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
end
end
	  
if BraumMenu.Combo.R:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1250) and Rprediction.HitChance == 1 and 100*GetCurrentHP(target)/GetMaxHP(target) < 50 then
CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
end

if BraumMenu.Combo.gankR:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1250) and Rprediction.HitChance == 1 and GoS:AlliesAround(GoS:myHeroPos(), 1500)+1 < GoS:EnemiesAround(GoS:myHeroPos(), 850)  then
CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
end
	  
if BraumMenu.Combo.lowR:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 1250) and Rprediction.HitChance == 1 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 20 and GoS:EnemiesAround(GoS:myHeroPos(), 800)then
CastSkillShot(_R,Rprediction.PredPos.x, Rprediction.PredPos.y, Rprediction.PredPos.z)
end
		
if GetItemSlot(myHero,3401) > 0 and BraumMenu.Combo.Items:Value() and GoS:EnemiesAround(GoS:myHeroPos(), 1250) > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 20 then
CastTargetSpell(myHero, GetItemSlot(myHero,3401)) --FotM
end

if GetItemSlot(myHero,3190) > 0 and BraumMenu.Combo.Items:Value() and GoS:EnemiesAround(GoS:myHeroPos(), 1250) > 0 and 100*GetCurrentHP(myHero)/GetMaxHP(myHero) < 10   then
CastTargetSpell(myHero, GetItemSlot(myHero,3190)) --locket
end
		
	end

if IOW:Mode() == "Harass" then
local target = GetCurrentTarget()
local Qprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1400,300,1000,80,true,true)
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