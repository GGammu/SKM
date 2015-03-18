;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Windows 7 64 bit
;Screen 640, 400
;Client 646, 428

~^!A::
	InitFunc()
	MsgBox start
	;Gosub, CheckKey
    Gosub, Test
    return

~^!S::
	Pause
	return

~^!D::
	Reload
	return
	
~^!F::
	ExitApp
	return
    
CheckKey:
	Loop {
		if !ImageSearcherOnce("KeyZeroMain.bmp", "F") {
			Gosub, Adventure
			Gosub, Tower
            Gosub, Arena
		}
		Sleep, 60000
	}
    
    MsgBox "End"
    
	return

Test: 
    ChangingHeroes()
    
    return 
    
Adventure:
	Loop {
		if !StartAdventure() { 
			Break
		}
		if !RunningAdventure() {
			Break
		}
		if !FinishAdventure() {
			Break
		}
	}
	ReturnMain()
	return
    
Tower:
	Loop {
		if !StartTower() {
            Break
		}
        if !RunningTower() {
			Break
		}
        if !FinishTower() {
            Break
        }
	}
    ReturnMain()
	return

Arena:
	Loop {
		if !StartArena() {
            Break
		}
        if !FinishArena() {
            Break
        }
	}
    ReturnMain()
	return

StartArena() {
    if ImageSearcherOnce("BattleEnter.bmp", "F") {
		ImageSearcherOnce("BattleEnter.bmp", "C")
		Sleep, 2000
	}
    
    if ImageSearcherOnce("BattleOut.bmp", "F") {
		ClickEvent(474, 139, 2000)
	}
    
    if ImageSearcherOnce("ArenaFirstSeason.bmp", "F") {
        ClickEvent(474, 139, 2000)
    }
    
    if ImageSearcherInfinite("ArenaReady.bmp", "F") {
        if ImageSearcherOnce("ArenaZero.bmp", "F") {
            return false
        }
        
        ImageSearcherOnce("ArenaReady.bmp", "C")
        Sleep, 10000
    } else {
        return false
    }
    
    if ImageSearcherOnce("ArenaStart.bmp", "F") {
        ImageSearcherOnce("ArenaStart.bmp", "C")
        Sleep, 2000
        return true
    } else {
        return false
    }
    return false
}

FinishArena() {
    Loop {
        if ImageSearcherOnce("ArenaRestart.bmp", "C") {
            Break
        }
        Sleep, 5000
    }
    
    flag := HasAchivementArena()
    return flag
}    

HasAchivementArena() {
    Global maxWait
      
    startTime := A_TickCount
    
    Loop {
        if (ImageSearcherOnce("Achievement.bmp", "F") or ImageSearcherOnce("Achievement_1.bmp", "F")) {
            if !ImageSearcherInfinite("Confirm.bmp", "C") {
                Sleep, 1000
                ClickEvent(570, 340, 1000)
            }
        }
        
        if ImageSearcherOnce("ArenaReady.bmp", "F") {
            return true
        }
        
        if ((A_TickCount - startTime) > maxWait) {
			return false
		}
		Sleep, 200
    }
}    

StartTower() {
	if ImageSearcherOnce("BattleEnter.bmp", "F") {
		ImageSearcherOnce("BattleEnter.bmp", "C")
		Sleep, 2000
	}
	
	if ImageSearcherOnce("BattleOut.bmp", "F") {
		ClickEvent(160, 139, 2000)
	}
	
    if ImageSearcherOnce("TowerGold.bmp", "F") {
        ImageSearcherOnce("TowerGold.bmp", "C")
    }
    
    Sleep, 2000
    
    if ImageSearcherInfinite("TowerStart.bmp", "F") {
        Sleep, 1000
        if ImageSearcherOnce("TowerZero.bmp", "F") {
            return false
        }
        
        ImageSearcherOnce("UnSelectedThirdTeam.bmp", "C")
        
        Sleep, 1000
        
        ImageSearcherOnce("TowerStart.bmp", "C")
        return true
    } else {
        return false
    }
    return true
}

RunningTower() {
    Sleep, 5000
    ImageSearcherOnce("UnSelectedAutoSkills.bmp", "C")
    return true
}	

FinishTower() {
    Loop {
        if ImageSearcherOnce("AdventureRestart.bmp", "C") {
            Break
        }
        Sleep, 5000
    }
    
    flag := HasAchivementTower()
    return flag
}

HasAchivementTower() {
    Global maxWait
    
    startTime := A_TickCount
    
    Loop {
        if (ImageSearcherOnce("Achievement.bmp", "F") or ImageSearcherOnce("Achievement_1.bmp", "F")) {
            if !ImageSearcherInfinite("Confirm.bmp", "C") {
                Sleep, 1000
                ClickEvent(570, 340, 1000)
            }
        }
        
        if ImageSearcherOnce("TowerStart.bmp", "F") {
            return true
        }
        
        if ((A_TickCount - startTime) > maxWait) {
			return false
		}
		Sleep, 200
    }
    return true
}

StartAdventure() {
    step := 0
    
	if ImageSearcherOnce("EnterAdventure.bmp", "F") {
        step = 1
        
    	if ImageSearcherInfinite("EnterAdventure.bmp", "C") {
            Sleep, 2000
        } else {
            return false
        }
	}
    
    if (step = 1 or ImageSearcherOnce("AdventureEnter.bmp", "F") or ImageSearcherOnce("AdventureLatest.bmp", "F")) {
        if ImageSearcherInfinite("AdventureLatest.bmp", "C") {
            Sleep, 2000
        } else {
            return false
        }
    }
    
	if ImageSearcherOnce("KeyZero.bmp", "F") {
		return false
	}
	
	ImageSearcherOnce("UnSelectedFirstTeam.bmp", "C")
    
    Sleep, 500
    
    if ImageSearcherInfinite("AdventureStart.bmp", "F") {
        Loop {
            Sleep, 500
            
            ImageSearcherOnce("AdventureStart.bmp", "C")
            
            Sleep, 1000
        
            if ImageSearcherOnce("FullHeros.bmp", "F") {
                ImageSearcherOnce("AdventureRun.bmp", "C")
                Break
            }
            
            if ImageSearcherOnce("FailEnter.bmp", "F") {
                if !ImageSearcherInfinite("No.bmp", "C") {
                    ClickEvent(240, 275, 500)
                } 
                return false
            }
            
            if !ImageSearcherOnce("AdventureStart.bmp", "F") {
                Break
            }
        }
    } else {
        return false
    }
	
	return true
}

RunningAdventure() {
	Global stageCnt
	
	runStage := 0
    
	startTime := A_TickCount
	
	Loop {
		ImageSearcherOnce("SelectedAutoSkills.bmp", "C")
		
		if (stageCnt = 2) {
			if (ImageSearcherOnce("TwoWaves.bmp", "F") and runStage < stageCnt and runStage < 1) {
				runStage = 1
				SelectSkill(runStage)
			}
			if (ImageSearcherOnce("Two_Second.bmp", "F") and runStage < stageCnt and runStage < 2) {
				runStage = 2
				SelectSkill(runStage)
				cnt := 0
			}
		} 
        
        if (stageCnt = 3) {
			if (ImageSearcherOnce("AdventureFirstWave.bmp", "F") and runStage < stageCnt and runStage < 1) {
				runStage = 1
				SelectSkill(runStage)
			} 
			if (ImageSearcherOnce("AdventureSecondWave.bmp", "F") and runStage < stageCnt and runStage < 2) {
				runStage = 2
				SelectSkill(runStage)
			} 
			if (ImageSearcherOnce("AdventureThirdWave.bmp", "F") and runStage < stageCnt and runStage < 3) {
				runStage = 3
				SelectSkill(runStage)
			}
		}

		if (runStage = stageCnt)  
			return true
		if ((A_TickCount - startTime) > 300000) {
			return true
		}
		
		Sleep, 100
	}
	return false
}
	
FinishAdventure() {
	flagFinishedAdventure := IsFinishedAdventure()
	changeHero := 0
    
    if (flagFinishedAdventure = "success") {
		Sleep, 10000
    } else {
        Sleep, 7000
    }
    
    Loop {
        if ImageSearcherInfinite("AdventureRestart.bmp", "F") {
            Sleep, 500
            ImageSearcherOnce("AdventureRestart.bmp", "C")
        } else {
            ClickEvent(600, 105, 500)
        }
        
        if !ImageSearcherInfinite("AdventureRestart.bmp", "F") {
            Break
        }
    }
            
    Sleep, 500
            
    Loop {
        flagAchive := HasAchivement() 
        
        if (flagAchive = "achieve") { 
            Sleep, 500
            
            if !ImageSearcherInfinite("Confirm.bmp", "C") {
                Sleep, 500
                ClickEvent(570, 340, 500)
            }
        } else if (flagAchive = "level") {
            Sleep, 500
   
            if !ImageSearcherInfinite("Confirm.bmp", "C") {
                Sleep, 500
                ClickEvent(570, 340, 500)
            }
            
            changeHero = 1
        } else if (flagAchive = "player") {
            Sleep, 500
            
            if !ImageSearcherInfinite("Confirm.bmp", "C") {
                Sleep, 500
                ClickEvent(570, 340, 500)
            }
        } else if (flagAchive = "raid") {
            Sleep, 500
            ClickEvent(200, 200, 500)
        } else if (flagAchive = "raidOut") {
            Sleep, 500
            ImageSearcherInfinite("RaidOut.bmp", "C")
            Sleep, 500
            ImageSearcherInfinite("AdventureLatest.bmp", "C")
        } else if (flagAchive = "finish") {
            Break
        } else {
			return false
		}
        
        Sleep, 500
    }
    
    if (changeHero = 1) {
        ChangeHeroes()
    }
    
    return true
}

ReturnMain() {
	while !ImageSearcherOnce("MainScreen.bmp", "F") {
		ClickEvent(30, 20, 100)
		Sleep, 2000
	}
}

IsFinishedAdventure() {
	Loop {
		if ImageSearcherOnce("AdventureVictory.bmp", "F") {
			return "success"
		}
		if ImageSearcherOnce("AdventureFailed.bmp", "F") {
			return "fail"
		}
		Sleep, 100
	}
}

HasAchivement() {
	Global maxWait
	
	startTime := A_TickCount
	Loop {
		if (ImageSearcherOnce("Achievement.bmp", "F") or ImageSearcherOnce("Achievement_1.bmp", "F")) {
			return "achieve"
		} else if (ImageSearcherOnce("FullLevel.bmp", "F") or ImageSearcherOnce("FullLevel_1.bmp", "F") 
				or ImageSearcherOnce("FullLevel_2.bmp", "F") or ImageSearcherOnce("FullLevel_3.bmp", "F")) {
			return "level"
		} else if ImageSearcherOnce("RaidEvent.bmp", "F") {
			return "raid"
		} else if ImageSearcherOnce("RaidOut.bmp", "F") {
			return "raidOut"
		} else if ImageSearcherOnce("PlayerLevelUp.bmp", "F") {
			return "player"
		} else if ImageSearcherOnce("AdventureStart.bmp", "F") {
			return "finish"
		} else if ImageSearcherOnce("FullHeros.bmp", "F") {
			return "fullHero"
		}
		
		if ((A_TickCount - startTime) > maxWait) {
			return "time over"
		}
		
		Sleep, 100
	}
	return "error"
}

ChangeHeroes() {
	EnterHeroManage()
	
    ChangingHeroes()
    
	LeaveHeroManage()
}

ChangingHeroes() {
    Global changeHeroCnt
    
	position1:=0
    position2:=0
    position3:=0
    position4:=0
    
    Loop, %changeHeroCnt% {
		if CheckHeroFullLevel(A_Index) {
            position%A_Index% := A_Index
        } else {
            position%A_Index% := 0
        }
        
        Sleep, 1000
    }
    
    Sleep, 1000    
     
    SettingHeroView()
    
    Sleep, 1000
            
    Loop {
        Loop, 4 {
			if (position1 + position2 + position3 + position4 = 0) 
                return
            
            if !CheckEnterPartyHero(A_Index) {
				Sleep, 2000
                Continue
			}
            
			Sleep, 2000
			
			if (position1 <> 0) {
				Sleep, 1000
				if (EnterHero(1)) 
                    position1 := 0
				Sleep, 2000
                Continue
            }
            
            if (position2 <> 0) {
				Sleep, 1000
                if (EnterHero(2)) 
                    position2 := 0
				Sleep, 2000
                Continue
            }
            
            if (position3 <> 0) {
				Sleep, 1000
                if (EnterHero(3)) 
                    position3 := 0
				Sleep, 2000
                Continue
            }
            
            if (position4 <> 0) {
				Sleep, 1000
                if (EnterHero(4)) 
                    position4 := 0
				Sleep, 2000
                Continue
            }
            
            Sleep, 2000
        }
        
        EventDragY(310, 258 , 96, 2000) ;Move 1 row
    }
    
    return
}

;ChangeHeroes() {
;	Global changeHeroCnt
;	firstHero := 0
;    
;	EnterHeroManage()
;	
;	Loop, %changeHeroCnt% {
;		if CheckHeroFullLevel(A_Index) {
;            SettingHeroView()
;			Sleep, 1000
;			if EnterPartyHero(A_Index) {
;				return
;			}
;		}
;		Sleep, 1000
;	}
;	Sleep, 1000
;	LeaveHeroManage()
;}

EnterHeroManage() {
	ImageSearcherInfinite("HeroSetting.bmp", "C")
	Sleep, 1000
}

LeaveHeroManage() {
	ImageSearcherInfinite("HeroSettingMain.bmp", "C")
	Sleep, 1000
}

SettingHeroView() {
	ImageSearcherOnce("ViewHero.bmp", "C")
	Sleep, 1000
	ClickEvent(535, 60, 1000)
	ImageSearcherOnce("SortAsc.bmp", "C")
	Sleep, 1000
	ClickEvent(596, 60, 1000)
	ImageSearcherOnce("SortLevel.bmp", "C")
	Sleep, 1000
}

CheckHeroFullLevel(i) {
	Global changeHeroX, changeHeroY
	
	x := changeHeroX
	y := changeHeroY + ((i - 1) * 67)
	
	Sleep, 1000
	ClickEvent(x, y, 1000)
	
	if ImageSearcherOnce("HeroLevelFull.bmp", "F") {
		ImageSearcherOnce("HeroDelete.bmp", "C")
		return true
	} else {
		ImageSearcherOnce("HeroX.bmp", "C")
		return false
	}
}

EnterPartyHero(i) {
	;Hero Picture size : x-96 y-140
	;Hero Picture gap : x-9 y-4
	
	Loop {
		Sleep, 1000
		Loop, 4 {
			Sleep, 1000
			if CheckEnterPartyHero(A_Index) {
				Sleep, 1000
				if EnterHero(i) {
					return 
				}
			}
		}
		Sleep, 1000
		EventDragY(310, 258 , 96, 1000) ;Move 1 row
	}
}

CheckEnterPartyHero(i) {
	x := 268 + ((i - 1) * 105)
	y := 184
	
	ClickEvent(x, y, 1000)
	
	if !ImageSearcherOnce("HeroPlacement.bmp", "F") {
		ImageSearcherOnce("HeroX.bmp", "C")
		return false
	}
	
	if ImageSearcherOnce("HeroLevelFull.bmp", "F") {
		ImageSearcherOnce("HeroPlacement.bmp", "C")
		return true
	}
	
	if !ImageSearcherOnce("HeroLevelFull.bmp", "F") {
		ImageSearcherOnce("HeroPlacement.bmp", "C")
		return true
	} else {
		ImageSearcherOnce("HeroX.bmp", "C")
		return false
	}
}

EnterHero(i) {
	Global changeHeroX, changeHeroY
	
	x := changeHeroX
	y := changeHeroY + ((i - 1) * 67)
	
	ClickEvent(x, y, 1000)
	
	if ImageSearcherOnce("HeroChangeFail.bmp", "F") {
		ClickEvent(200, 200, 1000)
		return false
	}
	
	return true
}
 
InitFunc() {
	CoordMode Pixel, Screen

	Global scnX1, scnY1, scnX2, scnY2, scnW, scnH, borderW, borderH, captionH
	Global maxWait, stageCnt
	Global changeHeroCnt, changeHeroX, changeHeroY
	
	WinGetPos, x, y, w, h, BlueStacks App Player
	SysGet, captionH, 4 
	SysGet, borderW, 32
	SysGet, borderH, 33
	
	scnX1 := x + borderW/2
	scnY1 := y + captionH + borderH/2
	scnW := w - borderW
	scnH := h - borderH - captionH
	scnX2 := scnX1 + scnW
	scnY2 := scnY1 + scnH
	maxWait := 10000
	stageCnt := 3
	changeHeroCnt := 3
	changeHeroX := 143
	changeHeroY := 143
	
    Loop
    {
        FileReadLine, line, %A_ScriptDir%\Config.txt, %A_Index%
        
        if ErrorLevel
            break
        
		idx = %A_Index%
		
		if (idx = 1) {
			changeHeroCnt := line
        }
		
		if (idx = 2) {
			stageCnt := line
        }
		
        if (line = "") {
            Break
        }
    }
    
	return
}

ClickEvent(x, y, msec) {
	n := x | y << 16
	
	PostMessage, 0x201, 1, %n%, , BlueStacks App Player
	PostMessage, 0x202, 0, %n%, , BlueStacks App Player
	
	Sleep, msec
	return 
}

EventDragY(x, y, dp, msec)
{
	pX := x
	pY := y
	
	n := pX | pY << 16
	PostMessage, 0x201, 0, %n%, , BlueStacks App Player

	pY := y - dp
	
	n := pX | pY << 16
	PostMessage, 0x200, 0, %n%, , BlueStacks App Player
	PostMessage, 0x202, 0, %n%, , BlueStacks App Player
	
	Sleep, msec
	return
}

;mode value : F - Find, C - Click, Hero - Find Hero
ImageSearcherOnce(img, mode) {
	Global scnX1,scnY1, scnX2, scnY2
	
	if (mode = "Hero") {
		ImageSearch, oX, oY, scnX1, scnY1, scnX2, scnY2, *150 %A_ScriptDir%\img\%img%
	} else {
		ImageSearch, oX, oY, scnX1, scnY1, scnX2, scnY2, *50 %A_ScriptDir%\img\%img%
	}
	
	if(ErrorLevel <> 0) {
		return false
	}
	
	if(mode="C" || mode="Hero") {
		x := oX - scnX1
		y := oY - scnY1
		N := x | y <<16
		
		PostMessage, 0x201, 1, %N%, , BlueStacks App Player
		PostMessage, 0x202, 0, %N%, , BlueStacks App Player
	}
	return true
}

;mode value : F - Find, C - Click, Hero - Find Hero
ImageSearcherInfinite(img, mode) {
	Global maxWait
	
	startTime := A_TickCount
	
	Loop {
		if ImageSearcherOnce(img, mode) {
			return true
		}

		if ((A_TickCount - startTime) > maxWait) {
			return false
		}
		
		Sleep, 100
	}
	return false
}

SelectSkill(stage) {
	Loop
    {
        FileReadLine, line, %A_ScriptDir%\skill.txt, %A_Index%
        
        if ErrorLevel
            break
        
        positionArray := line
        
        if (positionArray = "") {
            Break
        }
        
        StringSplit, skillPosition, positionArray, `,
        
        skillStage = %skillPosition1%   
        skillX = %skillPosition2%
        skillY = %skillPosition3%
        
        if (stage = skillStage) {
            ClickSkill(skillX, skillY)
        }

		Sleep, 200
    }
}

ClickSkill(x, y) {
    skillX := 610 - 60 * (x - 1)
    skillY := 275 + 70 * (y - 1)
    
    ClickEvent(skillX, skillY, 500)
    return
}
