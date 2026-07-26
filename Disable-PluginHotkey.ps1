# Disabilita l'hotkey del plugin Bestiary (iKeycode=-1).
# NON usare 0: per questo plugin 0 = Left Mouse Button.
# Uso: powershell -ExecutionPolicy Bypass -File .\Disable-PluginHotkey.ps1

$paths = @(
  "D:\SteamLibrary\steamapps\common\Skyrim Special Edition\Data\Dragonborns Bestiary.ini",
  "D:\Vortex Mods\skyrimse\The Dragonborn's Bestiary-123521-1-5-2-1739063915\Dragonborns Bestiary.ini"
)

foreach ($path in $paths) {
  if (-not (Test-Path $path)) {
    Write-Host "Skip (non trovato): $path"
    continue
  }
  $text = Get-Content -Raw -Path $path
  if ($text -match '(?im)^iKeycode\s*=') {
    $text = [regex]::Replace($text, '(?im)^iKeycode\s*=.*$', 'iKeycode=-1')
  }
  elseif ($text -match '(?im)\[General\]') {
    $text = [regex]::Replace($text, '(?im)(\[General\]\s*)', "`$1iKeycode=-1`r`n")
  }
  else {
    $text = "[General]`r`niKeycode=-1`r`n" + $text
  }
  Set-Content -Path $path -Value $text -NoNewline
  Write-Host "OK: $path -> iKeycode=-1"
}
