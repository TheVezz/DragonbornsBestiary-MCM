Scriptname BestiaryMCMPlayerAlias extends ReferenceAlias

; Fallback if ESP does not use SKI_PlayerLoadGameAlias.
; Must call OnGameReload so SkyUI re-registers the MCM after load.

Event OnPlayerLoadGame()
	BestiaryMCM mcm = GetOwningQuest() as BestiaryMCM
	if mcm
		mcm.OnGameReload()
	endif
EndEvent
