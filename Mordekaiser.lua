if GetObjectName(myHero) ~= "Mordekaiser" then return end
PrintChat("Misery Loves Company by Shiv loaded, v1.0")
MordekaiserMenu = Menu("Mordekaiser", "Mordekaiser")
MordekaiserMenu:SubMenu("Combo", "Combo")
MordekaiserMenu.Combo:Boolean("Q", "Use Q", true)
MordekaiserMenu.Combo:Boolean("W", "Use W", true)
MordekaiserMenu.Combo:Boolean("E", "Use E", true)
MordekaiserMenu.Combo:Boolean("R", "Use R", true)

MordekaiserMenu:SubMenu("Farm", "Farm")
MordekaiserMenu.Farm:Boolean("QLC", "Clear lane with Q", false)
MordekaiserMenu.Farm:Boolean("ELC", "Clear lane with E", false)

OnLoop(function(myHero)
local target = GetCurrentTarget()
local spacepress = KeyIsDown(0x20) --F7 OrbWalker is ON
	
	
	  
      if spacepress and CanUseSpell(myHero, _Q) == READY and MordekaiserMenu.Combo.Q:Value() and GoS:ValidTarget(target, 250) then
      CastSpell(_Q)
      end
	  
	  
	  if spacepress and CanUseSpell(myHero, _W) == READY and GoS:ValidTarget(target, 1000) and MordekaiserMenu.Combo.W:Value() and GotBuff(myHero, "mordekaisercreepingdeath") == 0 then 
	  CastTargetSpell(target, _W)
	  end
	  if spacepress and CanUseSpell(myHero, _W) == READY and GotBuff(myHero, "mordekaisercreepingdeath") > 0 and GoS:EnemiesAround(GoS:myHeroPos(), 250) > 0 then 
	  CastSpell(_W)
	  end
	  
	  local rangeE = GetCastRange(myHero, _E)
	  local Eprediction = GetPredictionForPlayer(GoS:myHeroPos(),target,GetMoveSpeed(target),1300,250,rangeE,50,false,true)
      
	  if spacepress and CanUseSpell(myHero, _E) == READY and MordekaiserMenu.Combo.E:Value() and GoS:ValidTarget (target, 675) and Eprediction.HitChance == 1 then
   
       CastSkillShot(_E,Eprediction.PredPos.x, Eprediction.PredPos.y, Eprediction.PredPos.z)
	end
      
	  if spacepress and MordekaiserMenu.Combo.R:Value() and CanUseSpell(myHero, _R) == READY and GoS:ValidTarget(target, 650) and 100*GetCurrentHP(target)/GetMaxHP(target) < 30 then
      CastTargetSpell(target, _R)
      end
	  
	  if spacepress and GotBuff(myHero, "mordekaisermaceofspades1") > 0 then AttackUnit(target) end
  

for i,unit in pairs(GoS:GetAllMinions(MINION_ENEMY)) do  
local laneclear = KeyIsDown(0x56) --F7 LaneClear is ON
   if laneclear then
       if GoS:ValidTarget(unit, 200) and MordekaiserMenu.Farm.QLC:Value() and CanUseSpell(myHero, _Q) == READY then
            CastSpell(_Q)            
              end                   
                           
				local minionposition = GetOrigin(unit)    
                if GoS:ValidTarget(unit, GetCastRange(myHero, _E)) and MordekaiserMenu.Farm.ELC:Value() and CanUseSpell(myHero, _E) == READY then
                        
                                CastSkillShot(_E,minionposition.x,minionposition.y, minionposition.z)
								
								end
				
    end           

end


end)