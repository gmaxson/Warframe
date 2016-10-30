; Set screen coordinate modes
CoordMode, ToolTip, Screen
CoordMode, Mouse, Screen

; Frame identification numbers
anyFrame := 1
Ash := 2
Equinox := 3
Inaros := 4
Ivara := 5
Mesa := 6
Saryn := 7
Trinity := 8
Vauban := 9
currentFrameID := 1

; Array to store frame information
frameArray := Object()
frameArray[1] := "Any"
frameArray[2] := "Ash"
frameArray[3] := "Equinox"
frameArray[4] := "Inaros"
frameArray[5] := "Ivara"
frameArray[6] := "Mesa"
frameArray[7] := "Saryn"
frameArray[8] := "Trinity"
frameArray[9] := "Vauban"
currentFrameName := frameArray[currentFrameID]

; Primary weapon identification numbers
anyPrimary := 1
dexSybaris := 2
synoidSimulor := 3
currentPrimaryID := 1

; Array to store primary weapon information
primaryArray := Object()
primaryArray[1] := "Any"
primaryArray[2] := "Dex Sybaris"
primaryArray[3] := "Synoid Simulor"
currentPrimaryName := primaryArray[currentPrimaryID]

; Secondary weapon identification numbers
anySecondary := 1
hikouPrime := 2
Sonicor := 3
spiraPrime := 4
telosAkbolto := 5
currentSecondaryID := 1

; Array to store secondary weapon information
secondaryArray := Object()
secondaryArray[1] := "Any"
secondaryArray[2] := "Hikou Prime"
secondaryArray[3] := "Sonicor"
secondaryArray[4] := "Spira Prime"
secondaryArray[5] := "Telos Akbolto"
currentSecondaryName := secondaryArray[currentSecondaryID]

; Melee weapon identification numbers
anyMelee := 1
testMelee := 2
orthosPrime := 3
sanctiMagistar := 4
telosBoltace := 5
telosBoltaceBerserker := 6
currentMeleeID := 1

; Array to store melee weapon information
meleeArray := Object()
meleeArray[1] := "Any"
meleeArray[2] := "Test"
meleeArray[3] := "Orthos Prime"
meleeArray[4] := "Sancti Magistar"
meleeArray[5] := "Telos Boltace"
meleeArray[6] := "Telos Boltace (Berserker)"
currentMeleeName := meleeArray[currentMeleeID]

; Array to store frequency values for slide attacks
slideAttackArray := Object()
slideAttackArray[1] := 1000
slideAttackArray[2] := 1000
slideAttackArray[3] := 1000
slideAttackArray[4] := 1000
slideAttackArray[5] := 350
slideAttackArray[6] := 200

; Toggle flags
isCapsLocked := false
isNumLocked := true
isScrollLocked := false

; Variables for testing purposes
testNumber := 300

; Subroutine to remove tooltips
RemoveToolTip:
SetTimer, RemoveToolTip, Off
ToolTip
return

; HELP KEY
F1::
ToolTip, F1: Help`nF2: Suspend`nF3: Inventory Screen`nF4: Focus Screen`n`nCurrent Loadout`nFrame: %currentFrameName%`nPrimary: %currentPrimaryName%`nSecondary: %currentSecondaryName%`nMelee: %currentMeleeName%, 0, 0
SetTimer, RemoveToolTip, 5000
return

; SUSPEND KEY
F2::
Suspend
if(A_IsSuspended)
{
	ToolTip, Suspended, 0, 0
	SetTimer, RemoveToolTip, 3000
	isCapsLocked := GetKeyState("CapsLock", "T")
	isNumLocked := GetKeyState("NumLock", "T")
	isScrollLocked := GetKeyState("ScrollLock", "T")
	SetCapsLockState off
	SetNumLockState on
	SetScrollLockState off
}
else
{
	ToolTip, Resumed, 0, 0
	SetTimer, RemoveToolTip, 3000
	if(isCapsLocked)
	{
		SetCapsLockState on
	}
	if(!isNumLocked)
	{
		SetNumLockState off
	}
	if(isScrollLocked)
	{
		SetScrollLockState on
	}
}
return

; INVENTORY SCREEN SHORTCUT
F3::
Send {Esc}
Sleep 450
MouseMove, 250, 350
Click down
Sleep 50
Click up
Sleep 200
MouseMove, 250, 450
Click down
Sleep 50
Click up
return

; FOCUS SCREEN SHORTCUT
F4::
Send {Esc}
Sleep 450
MouseMove, 250, 400
Click down
Sleep 50
Click up
Sleep 200
MouseMove, 250, 300
Click down
Sleep 50
Click up
return

; FIRST ABILITY
$1::
if(currentFrameID = Inaros)
{
	while(GetKeyState(1, "P"))
	{
		Send 1
		Sleep 350
	}
}
else if(currentFrameID = Saryn)
{
	while(GetKeyState(1, "P"))
	{
		Send 1
		Sleep 200
	}
}
else if(currentFrameID = Vauban)
{
	while(GetKeyState(1, "P"))
	{
		Send 1
		Sleep 525
	}
}
else
{
	Send {1 down}
	KeyWait, 1, U
	Send {1 up}
}
return

; SECOND ABILITY
$2::
if(currentFrameID = Equinox)
{
	while(GetKeyState(2, "P"))
	{
		Send 2
		Sleep 200
	}
}
else if(currentFrameID = Trinity)
{
	while(GetKeyState(2, "P"))
	{
		Send 2
		Sleep 200
	}
}
else
{
	Send {2 down}
	KeyWait, 2, U
	Send {2 up}
}
return

; THIRD ABILITY
$3::
if(currentFrameID = Vauban)
{
	while(GetKeyState(3, "P"))
	{
		Send 3
		Sleep 525
	}
}
else
{
	Send {3 down}
	KeyWait, 3, U
	Send {3 up}
}
return

; FOURTH ABILITY
$4::
if(currentFrameID = Ash)
{
	while(GetKeyState(4, "P"))
	{
		Send 4
		Sleep 200
	}
}
else if(currentFrameID = Mesa)
{
	Send 4
	Click down
}
else if(currentFrameID = Vauban)
{
	while(GetKeyState(4, "P"))
	{
		Send 4
		Sleep 525
	}
}
else
{
	Send {4 down}
	KeyWait, 4, U
	Send {4 up}
}
return

; AUTO-FIRE
~$*LButton::
while(GetKeyState("LButton", "P") and GetKeyState("CapsLock", "T"))
{
	Click
	Sleep 100
}
return

; Auto alt-fire
$MButton::
while(GetKeyState("MButton", "P"))
{
	Send {MButton}
	Sleep 300
}
return

; Subroutine to handle assignment of test value to the proper location
setTestNumber:
slideAttackArray[2] := testNumber
newValue := % slideAttackArray[2]
ToolTip, %newValue%, 0, 0
SetTimer, RemoveToolTip, 5000
return

; Increment test number
~WheelUp::
testNumber := testNumber + 1
Gosub, setTestNumber
return

; Decrement test number
~WheelDown::
testNumber := testNumber - 1
Gosub, setTestNumber
return

; Increase test number by 5
~^WheelUp::
testNumber := testNumber + 5
Gosub, setTestNumber
return

; Decrease test number by 5
~^WheelDown::
testNumber := testNumber - 5
Gosub, setTestNumber
return

; Set a new value for test number
NumpadAdd::
Input, testNumber, , {Enter}
Gosub, setTestNumber
return

; AUTO-MELEE
$*e::
if(GetKeyState("NumLock", "T"))
{
	if(GetKeyState("Ctrl", "P") or GetKeyState("ScrollLock", "T"))
	{
		if(GetKeyState("Shift", "P"))
		{
			while(GetKeyState("Shift", "P") and GetKeyState("e", "P"))
			{
				Send +c^+e
				Sleep slideAttackArray[currentMeleeID]
			}
		}
		else
		{
			while(GetKeyState("e", "P"))
			{
				Send c^e
				Sleep slideAttackArray[currentMeleeID]
			}
		}
	}
	else
	{
		if(GetKeyState("Shift", "P"))
		{
			while(GetKeyState("Shift", "P") and GetKeyState("e", "P"))
			{
				Send +e
				Sleep 100
			}
		}
		else
		{
			while(GetKeyState("e", "P"))
			{
				Send e
				Sleep 100
			}
		}
	}
}
else
{
	if(GetKeyState("Ctrl", "P"))
	{
		Send ^{e down}
		KeyWait, e, U
		Send {e up}
	}
	else
	{
		Send {e down}
		KeyWait, e, U
		Send {e up}
	}
}
return

; AUTO STEALTH ATTACK
*b::
Send {e up}
Send {e down}
return

~$t::
if(!A_IsSuspended)
{
	Suspend
	ToolTip, What's going on here?, 0, 0
	SetTimer, RemoveToolTip, 3000
	isCapsLocked := GetKeyState("CapsLock", "T")
	isNumLocked := GetKeyState("NumLock", "T")
	isScrollLocked := GetKeyState("ScrollLock", "T")
	SetCapsLockState off
	SetNumLockState on
	SetScrollLockState off
	while(!GetKeyState("Esc", "P") and !GetKeyState("Enter", "P"))
	{
		Sleep 50
	}
	ToolTip, All done then?, 0, 0
	SetTimer, RemoveToolTip, 3000
	Suspend
}
return

y::
Send t
Sleep 10
Send {Esc}
return

p::
Send {Tab down}
KeyWait, p, U
Send {Tab up}
return

; Toggle NumLock
$Tab::
if(GetKeyState("NumLock", "T"))
{
	SetNumLockState off
}
else
{
	SetNumLockState on
}
return

; Toggle ScrollLock
`::
if(GetKeyState("ScrollLock", "T"))
{
	SetScrollLockState off
}
else
{
	SetScrollLockState on
}
return

; Subroutine to handle display of current loadout
displayCurrentLoadout:
ToolTip, Current Loadout`nFrame: %currentFrameName%`nPrimary: %currentPrimaryName%`nSecondary: %currentSecondaryName%`nMelee: %currentMeleeName%, 0, 0
SetTimer, RemoveToolTip, 5000
return

; Select previous frame
Numlock::
currentFrameID := Mod(currentFrameID + frameArray.MaxIndex() - 2, frameArray.MaxIndex()) + 1
currentFrameName := frameArray[currentFrameID]
Gosub, displayCurrentLoadout
return

; Select default frame
NumpadDiv::
currentFrameID := 1
currentFrameName := frameArray[currentFrameID]
Gosub, displayCurrentLoadout
return

; Select next frame
NumpadMult::
currentFrameID := Mod(currentFrameID, frameArray.MaxIndex()) + 1
currentFrameName := frameArray[currentFrameID]
Gosub, displayCurrentLoadout
return

; Select previous primary weapon
Numpad7::
NumpadHome::
currentPrimaryID := Mod(currentPrimaryID + primaryArray.MaxIndex() - 2, primaryArray.MaxIndex()) + 1
currentPrimaryName := primaryArray[currentPrimaryID]
Gosub, displayCurrentLoadout
return

; Select default primary weapon
Numpad8::
NumPadUp::
currentPrimaryID := 1
currentPrimaryName := primaryArray[currentPrimaryID]
Gosub, displayCurrentLoadout
return

; Select next primary weapon
Numpad9::
NumpadPgUp::
currentPrimaryID := Mod(currentPrimaryID, primaryArray.MaxIndex()) + 1
currentPrimaryName := primaryArray[currentPrimaryID]
Gosub, displayCurrentLoadout
return

; Select previous secondary weapon
Numpad4::
NumpadLeft::
currentSecondaryID := Mod(currentSecondaryID + secondaryArray.MaxIndex() - 2, secondaryArray.MaxIndex()) + 1
currentSecondaryName := secondaryArray[currentSecondaryID]
Gosub, displayCurrentLoadout
return

; Select default secondary weapon
Numpad5::
NumpadClear::
currentSecondaryID := 1
currentSecondaryName := secondaryArray[currentSecondaryID]
Gosub, displayCurrentLoadout
return

; Select next secondary weapon
Numpad6::
NumpadRight::
currentSecondaryID := Mod(currentSecondaryID, secondaryArray.MaxIndex()) + 1
currentSecondaryName := secondaryArray[currentSecondaryID]
Gosub, displayCurrentLoadout
return

; Select previous melee weapon
Numpad1::
NumpadEnd::
currentMeleeID := Mod(currentMeleeID + meleeArray.MaxIndex() - 2, meleeArray.MaxIndex()) + 1
currentMeleeName := meleeArray[currentMeleeID]
Gosub, displayCurrentLoadout
return

; Select default melee weapon
Numpad2::
NumpadDown::
currentMeleeID := 1
currentMeleeName := meleeArray[currentMeleeID]
Gosub, displayCurrentLoadout
return

; Select next melee weapon
Numpad3::
NumpadPgDn::
currentMeleeID := Mod(currentMeleeID, meleeArray.MaxIndex()) + 1
currentMeleeName := meleeArray[currentMeleeID]
Gosub, displayCurrentLoadout
return

; Select default loadout
Numpad0::
NumpadIns::
currentFrameID := 1
currentFrameName := frameArray[currentFrameID]
currentPrimaryID := 1
currentPrimaryName := primaryArray[currentPrimaryID]
currentSecondaryID := 1
currentSecondaryName := secondaryArray[currentSecondaryID]
currentMeleeID := 1
currentMeleeName := meleeArray[currentMeleeID]
Gosub, displayCurrentLoadout
return

; Solve Grineer 8-key cipher
!8::
Send {Space}
Sleep 590
Send {Space}
Sleep 380
Send {Space}
Sleep 500
Send {Space}
Sleep 335
Send {Space}
Sleep 385
Send {Space}
Sleep 280
Send {Space}
Sleep 320
Send {Space}
return