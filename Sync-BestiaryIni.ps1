# Scrive Data/Dragonborns Bestiary.ini dai valori MCM (MCM/Settings/DragonbornsBestiaryMCM.ini).
# Hotkey plugin = -1 (NON 0: 0 = Left Mouse). L'hotkey reale e' gestita dall'MCM. Poi riavvia SKSE.

$mcmSettings = "D:\SteamLibrary\steamapps\common\Skyrim Special Edition\Data\MCM\Settings\DragonbornsBestiaryMCM.ini"
$iniPaths = @(
  "D:\SteamLibrary\steamapps\common\Skyrim Special Edition\Data\Dragonborns Bestiary.ini",
  "D:\Vortex Mods\skyrimse\The Dragonborn's Bestiary-123521-1-5-2-1739063915\Dragonborns Bestiary.ini"
)

function Get-IniValue([string]$text, [string]$key, [string]$default) {
  $m = [regex]::Match($text, "(?im)^\s*$([regex]::Escape($key))\s*=\s*(.*)$")
  if ($m.Success) { return $m.Groups[1].Value.Trim() }
  return $default
}

if (-not (Test-Path $mcmSettings)) {
  Write-Host "MCM settings non trovati: $mcmSettings"
  Write-Host "Apri almeno una volta il MCM in gioco, poi riesegui lo script."
  exit 1
}

$mcm = Get-Content -Raw -Path $mcmSettings
$widget = Get-IniValue $mcm "iEnableWidget" "1"
$x = Get-IniValue $mcm "iBestiaryWidget_X" "1360"
$y = Get-IniValue $mcm "iBestiaryWidget_Y" "250"
$scale = Get-IniValue $mcm "fBestiaryWidgetScale" "1.0"
$system = Get-IniValue $mcm "iEnableSystemMenuOption" "1"
$tutorial = Get-IniValue $mcm "sTutorialMessage" "Press [{}] to access your bestiary."

if ($widget -eq "true") { $widget = "1" }
if ($widget -eq "false") { $widget = "0" }
if ($system -eq "true") { $system = "1" }
if ($system -eq "false") { $system = "0" }

$out = @"
[General]
iKeycode=-1
iBestiaryWidget_X = $x
iBestiaryWidget_Y = $y
iBestiaryWidgetScale = $scale
iEnableWidget = $widget
iEnableSystemMenuOption = $system
sTutorialMessage = $tutorial
"@

foreach ($path in $iniPaths) {
  if (-not (Test-Path (Split-Path $path))) { continue }
  Set-Content -Path $path -Value $out -Encoding ascii
  Write-Host "OK $path"
}

Write-Host "Fatto. Riavvia Skyrim (SKSE) per widget/menu/tutorial."
