Scriptname BestiaryMCM extends MCM_ConfigBase

; Hotkey default K (37). Unbound = -1 (never 0 — SkyUI shows ???).
; Requires PapyrusUtil (MiscUtil) to write Dragonborns Bestiary.ini.
; Do NOT override OnInit without Parent.OnInit() — SkyUI registration lives there.

string Property INI_PATH = "Data/Dragonborns Bestiary.ini" AutoReadOnly

int _hotkey = 37

Event OnGameReload()
	Parent.OnGameReload()
	ApplyHotkey()
EndEvent

Event OnConfigInit()
	ApplyHotkey()
EndEvent

Event OnConfigClose()
	ApplyHotkey()
	SyncIni()
EndEvent

Event OnSettingChange(string a_ID)
	if a_ID == "iKeycode:General"
		ApplyHotkey()
	endif
EndEvent

Event OnKeyDown(int keyCode)
	if keyCode == _hotkey && _hotkey > 0
		Bestiary.Open()
	endif
EndEvent

Function SyncIniNow()
	SyncIni()
	Debug.Notification("INI updated / INI aggiornato")
EndFunction

; Button: clear bind (Escape alone is captured as key by MCM Helper).
Function ClearHotkey()
	SetModSettingInt("iKeycode:General", -1)
	ApplyHotkey()
	RefreshMenu()
EndFunction

Function ApplyHotkey()
	if _hotkey > 0
		UnregisterForKey(_hotkey)
	endif

	_hotkey = GetModSettingInt("iKeycode:General")

	; 0 = Left Mouse in many DXScanCode tables (Bestiary plugin!); never keep it.
	; 1 = Escape (often pressed intending unbound in MCM keymap).
	; 256-265 = mouse buttons (LMB..wheel) — reject accidental MCM click-bind.
	if _hotkey <= 0 || _hotkey == 1 || (_hotkey >= 256 && _hotkey <= 265)
		_hotkey = -1
		SetModSettingInt("iKeycode:General", -1)
	endif

	if _hotkey > 0
		RegisterForKey(_hotkey)
	endif
EndFunction

Function SyncIni()
	int enableWidget = 0
	if GetModSettingBool("iEnableWidget:General")
		enableWidget = 1
	endif

	int enableSystem = 0
	if GetModSettingBool("iEnableSystemMenuOption:General")
		enableSystem = 1
	endif

	int widgetX = GetModSettingInt("iBestiaryWidget_X:General")
	int widgetY = GetModSettingInt("iBestiaryWidget_Y:General")
	float widgetScale = GetModSettingFloat("fBestiaryWidgetScale:General")
	string tutorial = GetModSettingString("sTutorialMessage:General")

	; Plugin hotkey OFF = -1 (NOT 0 — 0 is Left Mouse Button for this plugin).
	; MCM owns the real hotkey via RegisterForKey.
	string outText = "[General]\n"
	outText += "iKeycode=-1\n"
	outText += "iBestiaryWidget_X = " + (widgetX as string) + "\n"
	outText += "iBestiaryWidget_Y = " + (widgetY as string) + "\n"
	outText += "iBestiaryWidgetScale = " + FormatScale(widgetScale) + "\n"
	outText += "iEnableWidget = " + (enableWidget as string) + "\n"
	outText += "iEnableSystemMenuOption = " + (enableSystem as string) + "\n"
	outText += "sTutorialMessage = " + tutorial + "\n"

	MiscUtil.WriteToFile(INI_PATH, outText, false, false)
EndFunction

string Function FormatScale(float a_scale)
	int tenths = ((a_scale * 10.0) + 0.5) as int
	int whole = tenths / 10
	int frac = tenths - (whole * 10)
	return (whole as string) + "." + (frac as string)
EndFunction
