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

InitFunc()

^A::
	Gosub,CheckKey
	return

^S::
	Pause
	return

^D::
	Reload
	return
^F::
	ExitApp
	return


CheckKey:
	Loop {
		if !ImageSearcher("KeyZero.bmp","F") {
			Gosub,Adventure
		}	
	}
	return
	
Adventure:
	i:=0
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
		i++
	}
	MsgBox %i%
	return

StartAdventure() {
	if ImageSearcher("AdventureEnter.bmp","F") {
		ImageSearcher("AdventureLatest.bmp","C")
		sleep,1000
	}
	if ImageSearcher("KeyZero.bmp","F") {
		return false
	}
	
	ImageSearcher("UnSelectedFirstTeam.bmp","C")
	ImageSearcher("AdventureStart.bmp", "C") 
	
	if ImageSearcher("FullHeros.bmp","F") {
		return false
	}
	
	if ImageSearcher("FailEnter.bmp","F") {
		return false
	}
	
	return true
}
	
RunningAdventure() {
	runStage:=0
	
    global stageCnt
	
	Loop {
		Sleep,100
		if (ImageSearcher("AdventureFirstWave.bmp","F") and runStage<1) {
			runStage=1
			SelectSkill(runStage)
		} 
		if (ImageSearcher("AdventureSecondWave.bmp","F") and runStage<2) {
			runStage=2
			SelectSkill(runStage)
		} 
		if (ImageSearcher("AdventureThirdWave.bmp","F") and runStage<3) {
			runStage=3
			SelectSkill(runStage)
		}
		
		if (runStage=stageCnt)  
			return true
	}
	return false
}
	
FinishAdventure() {
	global stageCnt
	
	flagFinishedAdventure:=IsFinishedAdventure()
	
	if (flagFinishedAdventure="success") {
		Sleep,2000
		ClickEvent(200,200,1000)
		ClickEvent(200,200,1000)

		if RestartAdventure() {
			while !ConfirmAchivement() {
			}
		}
		return true
	} else if (flagFinishedAdventure="fail") {
		return true
	}
	return false
}
	
RestartAdventure() {
	global maxWait
	
	startTime := A_TickCount
	
	Loop {
		Sleep,100
		
		if ImageSearcher("AdventureRestart.bmp","C") {
			return true
		}
		
		if ((A_TickCount - startTime) > maxWait) {
			return false
		}
	}
	return false
}

ConfirmAchivement() {
	flagAchivement:=HasAchivement()
	
	if (flagAchivement = "achieve") { 
		ImageSearcher("Confirm.bmp","C")
		return false
	} else if (flagAchivement="level") {
		Sleep 1000
		ImageSearcher("Confirm.bmp","C")
		;Change heroes
		return false
	} else if (flagAchivement = "player") {
		ImageSearcher("Confirm.bmp","C")
		return false  
	} else if (flagAchivement = "raid") {
		ClickEvent(200,200,3000)
		Sleep,2000
		ImageSearcher("RaidOut.bmp","C")
		sleep,1000
		ImageSearcher("AdventureLatest.bmp","C")
		return false
	} else if (flagAchivement = "finish") {
		return true
	}
}

HasAchivement() {
	startTime := A_TickCount
	
	Loop {
		if ImageSearcher("Achievement.bmp","F") {
			return "achieve"
		}
		
		if ImageSearcher("FullLevel.bmp","F") {
			return "level"
		}
		
		if ImageSearcher("RaidEvent.bmp","F") {
			return "raid"
		}
		
		if ImageSearcher("PlayerLevelUp.bmp","F") {
			return "player"
		}
		
		if ImageSearcher("AdventureStart.bmp","F") {
			return "finish"
		}
		
		if ((A_TickCount - startTime) > 10000) {
			return "not"
		}
		Sleep,100
	}
	return "not"
}

IsFinishedAdventure() {
	Loop {
		Sleep,100
		
		if ImageSearcher("AdventureVictory.bmp","F") {
			return "success"
		}
		if ImageSearcher("AdventureFailed.bmp","F") {
			return "fail"
		}
	}
}
	
InitFunc() {
	CoordMode Pixel,Screen

	Global scnX1,scnY1,scnX2,scnY2,scnW,scnH,maxWait,stageCnt
	
	WinGetPos,x,y,w,h,BlueStacks App Player
	SysGet,wFrame,7 ;System Border
	SysGet,wCaption,4 ;System Caption
	
	scnX1:=x+wFrame
	scnY1:=y+wCaption+wFrame
	scnW:=w-(wFrame*2)
	scnH:=h-(wFrame*2)-wCaption
	scnX2:=scnX1+scnW
	scnY2:=scnY1+scnH
	maxWait:=60000
	stageCnt:=3
	return
}

ClickEvent(x, y, msec) {
	N:=x|y<<16

	PostMessage,0x201,1,%N%,,BlueStacks App Player
	PostMessage,0x202,0,%N%,,BlueStacks App Player
}

;mode value : F - Find, C - Click, Hero - Find Hero
ImageSearcher(img, mode) {
	Global scnX1,scnY1,scnX2,scnY2
	
	if(mode="Hero") {
		ImageSearch,oX,oY,scnX1,scnY1,scnX2,scnY2,*150 %A_ScriptDir%\img\%img%
	} else {
		ImageSearch,oX,oY,scnX1,scnY1,scnX2,scnY2,*40 %A_ScriptDir%\img\%img%
	}
	
	if(ErrorLevel<>0) {
		return false
	}
	
	if(mode="C"||mode="Hero") {
		x:=oX-scnX1
		y:=oY-scnY1
		N:=x|y<<16
		
		PostMessage,0x201,1,%N%,,BlueStacks App Player
		PostMessage,0x202,0,%N%,,BlueStacks App Player
		Sleep,100
	}
	return true
}

SelectSkill(stage) {
	skillX:=0
	skillY:=0
	if(stage=1) {
		skillX:=610
		skillY:=275
		ClickEvent(skillX, skillY, 1000)
		return
	}
	if(stage=2) {
		skillX:=610-240
		skillY:=275
		ClickEvent(skillX, skillY, 1000)
		return
	}
	if(stage=3) {
		skillX:=610-240
		skillY:=275+70
		ClickEvent(skillX, skillY, 1000)
		return
	}
	return
}
