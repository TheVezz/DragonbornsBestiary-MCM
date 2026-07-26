# Build Papyrus scripts for Dragonborns Bestiary - MCM
# Compila gli script Papyrus della mod.
#
# Usage / Uso:
#   powershell -ExecutionPolicy Bypass -File .\build.ps1
#   powershell -ExecutionPolicy Bypass -File .\build.ps1 -PapyrusCompiler "D:\path\PapyrusCompiler.exe"
#
# Looks for PapyrusCompiler in common locations (Creation Kit / Nemesis / -PapyrusCompiler).
# Cerca PapyrusCompiler in percorsi comuni.

[CmdletBinding()]
param(
	[string]$PapyrusCompiler = $env:PAPYRUS_COMPILER,
	[string]$FlagsFile = ""
)

$ErrorActionPreference = "Stop"
$Root = $PSScriptRoot
$SourceDir = Join-Path $Root "Source\Scripts"
$OutDir = Join-Path $Root "Scripts"
$ImportDir = Join-Path $Root "tools\import"

if (-not $FlagsFile) {
	$FlagsFile = Join-Path $Root "tools\TESV_Papyrus_Flags.flg"
}

function Find-PapyrusCompiler {
	param([string]$Explicit)
	if ($Explicit -and (Test-Path $Explicit)) { return (Resolve-Path $Explicit).Path }

	$candidates = @(
		$env:PAPYRUS_COMPILER,
		"D:\SteamLibrary\steamapps\common\Skyrim Special Edition\Data\Nemesis_Engine\Papyrus Compiler\PapyrusCompiler.exe",
		"C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Data\Nemesis_Engine\Papyrus Compiler\PapyrusCompiler.exe",
		"D:\SteamLibrary\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe",
		"C:\Program Files (x86)\Steam\steamapps\common\Skyrim Special Edition\Papyrus Compiler\PapyrusCompiler.exe"
	) | Where-Object { $_ }

	foreach ($c in $candidates) {
		if (Test-Path $c) { return (Resolve-Path $c).Path }
	}
	return $null
}

$compiler = Find-PapyrusCompiler -Explicit $PapyrusCompiler
if (-not $compiler) {
	Write-Error @"
PapyrusCompiler.exe not found.
Set -PapyrusCompiler or env PAPYRUS_COMPILER to your Creation Kit / Nemesis PapyrusCompiler.exe

PapyrusCompiler.exe non trovato.
Imposta -PapyrusCompiler oppure la variabile d'ambiente PAPYRUS_COMPILER.
"@
}

if (-not (Test-Path $FlagsFile)) {
	Write-Error "Flags file missing: $FlagsFile"
}
if (-not (Test-Path $ImportDir)) {
	Write-Error "Import stubs missing: $ImportDir"
}

New-Item -ItemType Directory -Force -Path $OutDir | Out-Null

$scripts = @(
	"BestiaryMCM.psc",
	"BestiaryMCMPlayerAlias.psc"
)

$importArg = "$ImportDir;$SourceDir"
Write-Host "Compiler: $compiler"
Write-Host "Flags:    $FlagsFile"
Write-Host "Import:   $importArg"
Write-Host "Output:   $OutDir"
Write-Host ""

$failed = $false
foreach ($name in $scripts) {
	$src = Join-Path $SourceDir $name
	if (-not (Test-Path $src)) {
		Write-Error "Missing source: $src"
	}
	Write-Host "Compiling $name ..."
	& $compiler $src "-f=$FlagsFile" "-i=$importArg" "-o=$OutDir"
	if ($LASTEXITCODE -ne 0) {
		$failed = $true
		Write-Host "FAILED: $name" -ForegroundColor Red
	}
}

if ($failed) {
	Write-Error "Build failed / Compilazione fallita."
}

Write-Host ""
Write-Host "OK - .pex written to Scripts/" -ForegroundColor Green
Write-Host "OK - .pex scritti in Scripts/" -ForegroundColor Green
Write-Host "ESP is prebuilt (DragonbornsBestiaryMCM.esp). Rebuild only if quest/VMAD changes."
Write-Host "L'ESP e' precompilato. Ricostruiscilo solo se cambi quest/VMAD."
