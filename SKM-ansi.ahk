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
	Gosub, CheckKey
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
		if !ImgFindEvent("KeyZeroMain.bmp") {
			Gosub, Adventure
			Gosub, Tower
            Gosub, Arena
		}
		Sleep, 60000
	}
    
	return

Test: 
    ; if (ImageSearcherInfinite("PlayerLevelUp.bmp", "F"))
    ; {
		
		; ImageSearcherOnce("LevelUpConfirm.bmp", "C")
	; }
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
    if ImgFindEvent("BattleEnter.bmp") 
		ImgClickEvent("BattleEnter.bmp", 0, 2000)
    
    if ImgFindEvent("BattleOut.bmp") 
		ClickEvent(474, 139, 0, 2000)
	
    if ImgFindEvent("ArenaFirstSeason.bmp") 
        ClickEvent(474, 139, 0, 2000)
    
    if LoopImgFindEvent("ArenaReady.bmp") {
        if ImgFindEvent("ArenaZero.bmp") {
            return false
        }
        
        ImgClickEvent("ArenaReady.bmp", 0, 0)
    } else {
        return false
    }
    
    if LoopImgFindEvent("ArenaStart.bmp") {
        ImgClickEvent("ArenaStart.bmp", 0, 2000)
        return true
    } else {
        return false
    }
    return false
}

FinishArena() {
    Loop {
        if ImgClickEvent("ArenaRestart.bmp", 0, 0) {
            Break
        }
        Sleep, 2000
    }
    
    flag := HasAchivementArena()
    return flag
}    

HasAchivementArena() {
    Global maxWait
      
    startTime := A_TickCount
    
    Loop {
        if (ImgFindEvent("Achievement.bmp")) {
            if !LoopImgClickEvent("AchieveConfirm.bmp", 0, 0) {
                ClickEvent(570, 340, 0, 1000)
            }
        }
        
        if ImgFindEvent("ArenaReady.bmp") {
            return true
        }
        
        if ((A_TickCount - startTime) > maxWait) {
			return false
		}

		Sleep, 200
    }
}    

StartTower() {
	if ImgFindEvent("BattleEnter.bmp") 
		ImgClickEvent("BattleEnter.bmp", 0, 2000)
	
	if ImgFindEvent("BattleOut.bmp") 
		ClickEvent(160, 139, 0, 2000)
	
    if ImgFindEvent("TowerGold.bmp") 
        ImgClickEvent("TowerGold.bmp", 0, 2000)
    
    if LoopImgFindEvent("TowerStart.bmp") {
        if ImgFindEvent("TowerZero.bmp") {
            return false
        }
        
        ImgClickEvent("UnSelectedThirdTeam.bmp", 0, 1000)
        
        ImgClickEvent("TowerStart.bmp", 0, 0)
        return true
    } else {
        return false
    }
    
    return true
}

RunningTower() {
    ImgClickEvent("UnSelectedAutoSkills.bmp", 5000, 0)
    return true
}	

FinishTower() {
    Loop {
        if ImgClickEvent("AdventureRestart.bmp", 0, 0) {
            Break
        }
        
        Sleep, 3000
    }
    
    flag := HasAchivementTower()
    return flag
}

HasAchivementTower() {
    Global maxWait
    
    startTime := A_TickCount
    
    Loop {
        if (ImgFindEvent("Achievement.bmp")) {
            if !LoopImgClickEvent("AchieveConfirm.bmp", 0, 0) 
                ClickEvent(570, 340, 1000, 1000)
        }
        
        if ImgFindEvent("TowerStart.bmp") 
            return true
                
        if ((A_TickCount - startTime) > maxWait) {
			return false
		}
        
		Sleep, 200
    }
    return true
}

StartAdventure() {
    step := 0
    
	if ImgFindEvent("EnterAdventure.bmp") {
        step = 1
        
    	if !LoopImgClickEvent("EnterAdventure.bmp", 0, 2000) 
            return false
	}
    
    if (step = 1 or ImgFindEvent("AdventureEnter.bmp") or ImgFindEvent("AdventureLatest.bmp")) {
        if !LoopImgClickEvent("AdventureLatest.bmp", 0, 2000) {
            return false
        }
    }
    
	if ImgFindEvent("KeyZero.bmp") 
		return false
	
	ImgClickEvent("UnSelectedFirstTeam.bmp", 0, 500`)
    
    if LoopImgFindEvent("AdventureStart.bmp") {
        Loop {
            ImgClickEvent("AdventureStart.bmp", 500, 1000)
            
            if ImgFindEvent("FullHeros.bmp") {
                ImgClickEvent("AdventureRun.bmp", 0, 0)
                Break
            }
            
            if ImgFindEvent("FailEnter.bmp") {
                if !LoopImgClickEvent("No.bmp", 0, 0) {
                    ClickEvent(240, 275, 0, 500)
                } 
                return false
            }
            
            if !ImgFindEvent("AdventureStart.bmp") 
                Break
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
		ImgClickEvent("SelectedAutoSkills.bmp", 0, 0)
		
		if (stageCnt = 2) {
			if (ImgFindEvent("TwoWaves.bmp") and runStage < stageCnt and runStage < 1) {
				runStage = 1
				SelectSkill(runStage)
			}
            
			if (ImgFindEvent("Two_Second.bmp") and runStage < stageCnt and runStage < 2) {
				runStage = 2
				SelectSkill(runStage)
				cnt := 0
			}
		} 
        
        if (stageCnt = 3) {
			if (ImgFindEvent("AdventureFirstWave.bmp") and runStage < stageCnt and runStage < 1) {
				runStage = 1
				SelectSkill(runStage)
			} 
			if (ImgFindEvent("AdventureSecondWave.bmp") and runStage < stageCnt and runStage < 2) {
				runStage = 2
				SelectSkill(runStage)
			} 
			if (ImgFindEvent("AdventureThirdWave.bmp") and runStage < stageCnt and runStage < 3) {
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
		ClickEvent(320, 315, 2500, 1000)
		ClickEvent(320, 315, 0, 1000)
    } else {
        Sleep, 3000
    }
    
    if LoopImgFindEvent("AdventureRestart.bmp") {
        ImgClickEvent("AdventureRestart.bmp", 1000, 0)
    } else {
        ClickEvent(600, 105, 0, 1000)
    }
            
    Sleep, 1000
            
    Loop {
        flagAchive := HasAchivement() 
        
        if (flagAchive = "achieve") { 
            if !LoopImgClickEvent("AchieveConfirm.bmp", 1000, 0) 
                ClickEvent(570, 340, 1000, 500)
        } else if (flagAchive = "level") {
            if !LoopImgClickEvent("Confirm.bmp", 1000, 0) 
                ClickEvent(570, 340, 1000, 500)
            
            changeHero = 1
        } else if (flagAchive = "player") {
            if !LoopImgClickEvent("LevelUpConfirm.bmp", 1000, 0) 
                ClickEvent(570, 340, 1000, 500)
        } else if (flagAchive = "raid") {
            ClickEvent(200, 200, 1000, 500)
        } else if (flagAchive = "raidOut") {
            ImgClickEvent("RaidOut.bmp", 0, 0)
		} else if (flagAchive = "enter") {
			LoopImgClickEvent("AdventureLatest.bmp", 0, 0)
		} else if (flagAchive = "finish") {
            Break
        } else {
			return false
		}
        
        Sleep, 1000
    }
    
    if (changeHero = 1) {
        ChangeHeroes()
    }
    
    return true
}

ReturnMain() {
	while !ImgFindEvent("MainScreen.bmp") {
		ClickEvent(30, 20, 0, 3000)
	}
}

IsFinishedAdventure() {
	Loop {
		if ImgFindEvent("AdventureVictory.bmp") {
			return "success"
		}
		if ImgFindEvent("AdventureFailed.bmp") {
			return "fail"
		}
		Sleep, 100
	}
}

HasAchivement() {
	Global maxWait
	
	startTime := A_TickCount
	Loop {
		if (ImgFindEvent("Achievement.bmp")) {
			return "achieve"
		} else if (ImgFindEvent("FullLevel.bmp")) {
			return "level"
		} else if ImgFindEvent("RaidEvent.bmp") {
			return "raid"
		} else if ImgFindEvent("RaidOut.bmp") {
			return "raidOut"
		} else if ImgFindEvent("PlayerLevelUp.bmp") {
			return "player"
		} else if ImgFindEvent("AdventureEnter.bmp") {
			return "enter"
		} else if ImgFindEvent("AdventureStart.bmp") {
			return "finish"
		} else if ImgFindEvent("FullHeros.bmp") {
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
            
            if (position1 <> 0) {
				if (EnterHero(1)) {
                    if !ImgFindEvent("Location1.bmp") {
                        position1 := 0
                    } else {
                        position1 := 1
                    }
                }
                Continue
            }
            
            if (position2 <> 0) {
			    if (EnterHero(2)) {
                    if !ImgFindEvent("Location2.bmp") {
                        position2 := 0
                    } else {
                        position2 := 1
                    }
                }
                Continue
            }
            
            if (position3 <> 0) {
			    if (EnterHero(3)) {
                    if !ImgFindEvent("Location3.bmp") {
                        position3 := 0
                    } else {
                        position3 := 1
                    }
                }
                Continue
            }
            
            if (position4 <> 0) {
			    if (EnterHero(4)) {
                    if !ImgFindEvent("Location4.bmp") {
                        position4 := 0
                    } else {
                        position4 := 1
                    }
                }
                Continue
            }
            
            Sleep, 2000
        }
        
        DragYEvent(310, 258 , 96, 0, 2000) ;Move 1 row
    }
    
    return
}

EnterHeroManage() {
	LoopImgClickEvent("HeroSetting.bmp", 0, 1000)
}

LeaveHeroManage() {
	LoopImgClickEvent("HeroSettingMain.bmp", 0, 1000)
}

SettingHeroView() {
	ImgClickEvent("ViewHero.bmp", 0, 0)
    
	ImgClickEvent("CloseMsg.bmp", 500, 0)
    
	ClickEvent(545, 60, 500, 500)
    
	ImgClickEvent("SelectSortLevel.bmp", 0, 0)
    
    ImgClickEvent("CloseMsg.bmp", 500, 200)
    
    LoopImgClickEvent("SelectSortAsc.bmp", 0, 0)
    
	ImgClickEvent("CloseMsg.bmp", 500, 200)
    
    LoopImgClickEvent("SelectSortDesc.bmp", 0, 0)
    
    DragYEvent(310, 96, -258, 500, 500)
}

CheckHeroFullLevel(i) {
	Global changeHeroX, changeHeroY
	
	x := changeHeroX
	y := changeHeroY + ((i - 1) * 67)
	
	ClickEvent(x, y, 0, 1000)
	
	if ImgFindEvent("HeroLevelFull.bmp") {
		ImgClickEvent("HeroDelete.bmp", 200, 200)
        return true
	} else {
		ImgClickEvent("HeroX.bmp", 200, 200)
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
		
		DragYEvent(310, 258 , 96, 500, 500) ;Move 1 row
	}
}

CheckEnterPartyHero(i) {
	x := 268 + ((i - 1) * 105)
	y := 184
	
	ClickEvent(x, y, 0, 1000)
	
	if !ImgFindEvent("HeroPlacement.bmp") {
		ImgClickEvent("HeroX.bmp", 0, 0)
		return false
	}
	
	if ImgFindEvent("HeroLevelFull.bmp") {
		ImgClickEvent("HeroPlacement.bmp", 0, 0)
		return true
	}
	
	if !ImgFindEvent("HeroLevelFull.bmp") {
		ImgClickEvent("HeroPlacement.bmp", 0, 0)
		return true
	} else {
		ImgClickEvent("HeroX.bmp", 0, 0)
		return false
	}
}

EnterHero(i) {
	Global changeHeroX, changeHeroY
	
    x := changeHeroX
	y := changeHeroY + ((i - 1) * 67)
	
    ClickEvent(x, y, 4000, 1000)
	
    if ImgFindEvent("HeroChangeFail.bmp") {
		ClickEvent(200, 200, 0, 1000)
		return false
	}
	
	return true
}
 
InitFunc() {
	CoordMode Pixel, Screen

	Global maxWait, stageCnt
	Global changeHeroCnt, changeHeroX, changeHeroY
	
	maxWait := 10000
	stageCnt := 3
	changeHeroCnt := 3
	changeHeroX := 143
	changeHeroY := 143
	
    Loop {
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

SelectSkill(stage) {
	Loop {
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
    
    ClickEvent(skillX, skillY, 100, 500)
    return
}

LoopImgFindEvent(img) {
    Global maxWait
    
    startTime := A_TickCount
    
    Loop {
		if ImgFindEvent(img) {
			return true
		}

		if ((A_TickCount - startTime) > maxWait) {
			return false
		}
		
		Sleep, 1000
	}
	return false
}

ImgFindEvent(img) {
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
	
    ImageSearch, oX, oY, scnX1, scnY1, scnX2, scnY2, *50 %A_ScriptDir%\img\%img%
    
	if (ErrorLevel <> 0) {
		return false
	}
    
    return true
}

LoopImgClickEvent(img, s, e) {
    Global maxWait
  
    Sleep, s
    
    startTime := A_TickCount
    
    Loop {
		if ImgClickEvent(img, 0, e) {
			return true
		}

		if ((A_TickCount - startTime) > maxWait) {
			return false
		}
		
		Sleep, 1000
	}
	return false
}

ImgClickEvent(img, s, e) {
    Sleep, s
    
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
	
    ImageSearch, oX, oY, scnX1, scnY1, scnX2, scnY2, *50 %A_ScriptDir%\img\%img%
    
	if (ErrorLevel <> 0) {
		return false
	}
	
    ClickEvent(oX - scnX1, oY - scnY1, 0, e)
		
	return true
}

ClickEvent(x, y, s, e) {
    Sleep, s
    
	n := x | y << 16
	
	PostMessage, 0x201, 1, %n%, , BlueStacks App Player
    Sleep, 200
	PostMessage, 0x202, 0, %n%, , BlueStacks App Player
	
	Sleep, e
	return
}

DragYEvent(x, y, dp, s, e) {
    Sleep, s
    
	pX := x
	pY := y
	
	n := pX | pY << 16
	PostMessage, 0x201, 0, %n%, , BlueStacks App Player
    pY := y - dp
	
	n := pX | pY << 16
	PostMessage, 0x200, 0, %n%, , BlueStacks App Player
    PostMessage, 0x202, 0, %n%, , BlueStacks App Player
	
	Sleep, e
	return
}
