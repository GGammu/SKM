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
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;Windows 7 64 bit
;Screen 640, 400
;Client 646, 428

^!A::
	InitFunc()
	MsgBox start
	Gosub, CheckKey
	;Gosub, Test
	return

^!S::
	Pause
	return

^!D::
	Reload
	return
	
^!F::
	ExitApp
	return

Test:
	ChangeHeroes()
	
	return
	
CheckKey:
	Loop {
		if !ImageSearcherOnce("KeyZeroMain.bmp", "F") {
			Gosub, Adventure
		}
		Sleep, 300000
	}
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

StartAdventure() {
	if ImageSearcherOnce("EnterAdventure.bmp", "F") {
		ImageSearcherOnce("EnterAdventure.bmp", "C")
		Sleep, 2000
	}

	if ImageSearcherOnce("AdventureEnter.bmp", "F") {
		ImageSearcherOnce("AdventureLatest.bmp", "C")
		Sleep, 2000
	}
	
	if ImageSearcherOnce("KeyZero.bmp", "F") {
		return false
	}
	
	ImageSearcherOnce("UnSelectedFirstTeam.bmp", "C")
	ImageSearcherOnce("AdventureStart.bmp", "C") 
	
	Sleep, 2000
	
	if ImageSearcherOnce("FullHeros.bmp", "F") {
		ImageSearcherOnce("AdventureRun.bmp", "C")
		return true
	}
	
	if ImageSearcherOnce("FailEnter.bmp", "F") {
		ImageSearcherOnce("No.bmp", "C")
		return false
	}
	
	return true
}
	
RunningAdventure() {
	runStage := 0
    stageCnt := 3
	
	Loop { 
		if ImageSearcherOnce("AdventureFirstWave.bmp", "F") {
			stageCnt := 3
			Break
		}
		if ImageSearcherOnce("TwoWaves.bmp", "F") {
			stageCnt := 2
			Break
		}
		Sleep, 100
	}
	
	Loop {
		if (stageCnt = 2) {
			if (ImageSearcherOnce("TwoWaves.bmp", "F") and runStage < stageCnt and runStage < 1) {
				runStage = 1
				SelectSkill(runStage)
			} 
			if (ImageSearcherOnce("Two_Second.bmp", "F") and runStage < stageCnt and runStage < 2) {
				runStage = 2
				SelectSkill(runStage)
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
		
		Sleep, 100
	}
	return false
}
	
FinishAdventure() {
	flagFinishedAdventure := IsFinishedAdventure()
	
	if (flagFinishedAdventure = "success") {
		Sleep, 6000
		
		if ImageSearcherInfinite("AdventureRestart.bmp", "C") {
			Sleep, 3000
			while !ConfirmAchivement() {
				Sleep, 500
			}
		}
		return true
	} else if (flagFinishedAdventure = "fail") {
		if ImageSearcherInfinite("AdventureRestart.bmp", "C") {
			Sleep, 3000
			while !ConfirmAchivement() {
				Sleep, 500
			}
		}
		return true
	}
	return false
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
	
ConfirmAchivement() {
	flagAchivement := HasAchivement()
	
	if (flagAchivement = "achieve") { 
		Sleep, 3000
		ImageSearcherInfinite("Confirm.bmp", "C")
		return false
	} else if (flagAchivement = "level") {
		Sleep, 3000
		ImageSearcherInfinite("Confirm.bmp", "C")
		Sleep, 1000
		ChangeHeroes()
		return false
	} else if (flagAchivement = "player") {
		Sleep, 3000
		ImageSearcherInfinite("Confirm.bmp", "C")
		return false  
	} else if (flagAchivement = "raid") {
		Sleep, 3000
		ClickEvent(200, 200, 3000)
		return false
	} else if (flagAchivement = "raidOut") {
		Sleep, 3000
		ImageSearcherInfinite("RaidOut.bmp", "C")
		Sleep, 3000
		ImageSearcherInfinite("AdventureLatest.bmp", "C")
		return false
	} else if  (flagAchivement = "fullHero") {
		Sleep, 3000
		ImageSearcherInfinite("AdventureRun.bmp", "C")
		return true
	} else if (flagAchivement = "finish") {
		return true
	} else {
		return false
	}
}

HasAchivement() {
	Global maxWait
	
	startTime := A_TickCount
	Loop {
		if ImageSearcherOnce("Achievement.bmp", "F") {
			return "achieve"
		} else if ImageSearcherOnce("FullLevel.bmp", "F") {
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
	Global changeHeroCnt
	
	EnterHeroManage()
	SettingHeroView()
	
	Loop, %changeHeroCnt% {
		if CheckHeroFullLevel(A_Index) {
			Sleep, 1000
			if EnterPartyHero(A_Index) {
				return
			}
		}
		Sleep, 1000
	}
	Sleep, 1000
	LeaveHeroManage()
}

EnterHeroManage() {
	ImageSearcherOnce("HeroSetting.bmp", "C")
	Sleep, 1000
}

LeaveHeroManage() {
	ImageSearcherOnce("HeroSettingMain.bmp", "C")
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
	Global maxWait
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
	maxWait := 20000
	stageCnt := 3
	changeHeroCnt := 3
	changeHeroX := 143
	changeHeroY := 143
	
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
		ImageSearch, oX, oY, scnX1, scnY1, scnX2, scnY2, *40 %A_ScriptDir%\img\%img%
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
		
		Sleep, 200
	}
	return false
}

SelectSkill(stage) {
	skillX := 0
	skillY := 0
	if (stage = 1) {
		skillX := 610 - 180
		skillY := 275
		ClickEvent(skillX, skillY, 1000)
		return
	}
	if (stage = 2) {
		skillX := 610 - 240
		skillY := 275
		ClickEvent(skillX, skillY, 1000)
		return
	}
	if(stage = 3) {
		skillX := 610 - 240
		skillY := 275+70
		ClickEvent(skillX, skillY, 1000)
		return
	}
	return
}
