require('Inspired')
PrintChat("ShivAIO | ScaryGanks v1.0")
ScaryGanksMenu = Menu("ScaryGanks", "ScaryGanks")
ScaryGanksMenu:SubMenu("Ganking", "Ganks")
ScaryGanksMenu.Ganking:Boolean("Alert", "Show Alerts", true)

OnLoop(function(myHero)
if ScaryGanksMenu.Ganking.Alert:Value()	then
if GoS:EnemiesAround(GoS:myHeroPos(), 4000) > 0 then
			
				local hero_origin = GoS:myHeroPos()
				local myscreenpos = WorldToScreen(1,hero_origin.x,hero_origin.y,hero_origin.z)
				
					if GoS:EnemiesAround(GoS:myHeroPos(), 4000) > GoS:AlliesAround(GoS:myHeroPos(),2000)+1 then
						DrawText(string.format("GANKED!"),24,myscreenpos.x,myscreenpos.y,0xffff0000)
					
				end
			end
		end
end)