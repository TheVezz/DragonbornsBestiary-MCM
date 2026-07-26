# Dragonborn's Bestiary – MCM

[English](#english) | [Italiano](#italiano)

Mod name (Vortex / release): **Dragonborns Bestiary - MCM**  
Plugin: `DragonbornsBestiaryMCM.esp` (ESL / light)

---

## English

SkyUI + **MCM Helper** addon for [The Dragonborn's Bestiary](https://www.nexusmods.com/skyrimspecialedition/mods/123521): hotkey, HUD widget, System menu entry, and tutorial text — driven from `Dragonborns Bestiary.ini`.

### Requirements

- SKSE
- SkyUI
- MCM Helper
- PapyrusUtil SE (INI write via `MiscUtil`)
- The Dragonborn's Bestiary

### MCM pages

| Page | Options |
|------|---------|
| **Controls** | Bestiary hotkey (default **K**). Escape while remapping is treated as Unbound. |
| **Widget** | Enable, X, Y, scale → INI (needs SKSE restart) |
| **Menu / Text** | System menu entry, tutorial string, **Write INI now** |

### Behaviour notes

- Hotkey applies immediately (`RegisterForKey`).
- Plugin INI always gets `iKeycode=0` so the SKSE plugin does not bind a second key.
- Widget / System menu / tutorial need an SKSE restart after the INI is written.

### Languages

- `interface/translations/DragonbornsBestiaryMCM_english.txt`
- `interface/translations/DragonbornsBestiaryMCM_italian.txt`

UTF-16 LE. Language follows the game / SkyUI.

### Project layout

```
DragonbornsBestiary-MCM/
├── build.ps1                 # Compile .psc → Scripts/*.pex
├── DragonbornsBestiaryMCM.esp
├── Source/Scripts/           # Papyrus source
├── Scripts/                  # Compiled .pex
├── MCM/Config/...            # MCM Helper config + defaults
├── interface/translations/   # EN + IT
├── tools/import/             # Compile-only stubs (not for Data/)
└── *.ps1                     # Optional INI helpers
```

### Build (contributors)

1. Install a Papyrus compiler (Creation Kit or Nemesis `PapyrusCompiler.exe`).
2. From the repo root:

```powershell
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

If the compiler is not auto-detected:

```powershell
powershell -ExecutionPolicy Bypass -File .\build.ps1 -PapyrusCompiler "D:\path\to\PapyrusCompiler.exe"
```

Or set env `PAPYRUS_COMPILER`.

The ESP is **prebuilt**. Rebuild it only if you change the quest / VMAD (Mutagen / CK).  
Do not deploy `tools/import` into Skyrim `Data`.

### Contributing

Fork, change source/`config.json`/translations, run `build.ps1`, test in-game, open a PR.

---

## Italiano

Addon SkyUI + **MCM Helper** per [The Dragonborn's Bestiary](https://www.nexusmods.com/skyrimspecialedition/mods/123521): hotkey, widget HUD, voce nel menu Sistema e testo tutorial — tramite `Dragonborns Bestiary.ini`.

### Requisiti

- SKSE
- SkyUI
- MCM Helper
- PapyrusUtil SE (scrittura INI con `MiscUtil`)
- The Dragonborn's Bestiary

### Pagine MCM

| Pagina | Opzioni |
|--------|---------|
| **Controlli** | Hotkey Bestiario (default **K**). Escape in remap = Unbound. |
| **Widget** | Abilita, X, Y, scala → INI (serve riavvio SKSE) |
| **Menu / Testo** | Voce menu Sistema, tutorial, **Scrivi ora** |

### Note

- L’hotkey ha effetto immediato (`RegisterForKey`).
- Nell’INI del plugin viene scritto `iKeycode=0` per evitare un doppio bind.
- Widget / menu Sistema / tutorial richiedono riavvio SKSE dopo la scrittura INI.

### Lingue

- `interface/translations/DragonbornsBestiaryMCM_english.txt`
- `interface/translations/DragonbornsBestiaryMCM_italian.txt`

UTF-16 LE. La lingua segue il gioco / SkyUI.

### Struttura

```
DragonbornsBestiary-MCM/
├── build.ps1                 # Compila .psc → Scripts/*.pex
├── DragonbornsBestiaryMCM.esp
├── Source/Scripts/           # Sorgenti Papyrus
├── Scripts/                  # .pex compilati
├── MCM/Config/...            # Config MCM Helper + default
├── interface/translations/   # EN + IT
├── tools/import/             # Stub solo per build (non in Data/)
└── *.ps1                     # Helper INI opzionali
```

### Build (chi fa fork)

1. Installa un compilatore Papyrus (Creation Kit o Nemesis `PapyrusCompiler.exe`).
2. Dalla root del repo:

```powershell
powershell -ExecutionPolicy Bypass -File .\build.ps1
```

Se non viene trovato automaticamente:

```powershell
powershell -ExecutionPolicy Bypass -File .\build.ps1 -PapyrusCompiler "D:\percorso\PapyrusCompiler.exe"
```

Oppure variabile d’ambiente `PAPYRUS_COMPILER`.

L’ESP è **già compilato**. Ricostruiscilo solo se cambi quest / VMAD (Mutagen / CK).  
Non copiare `tools/import` in `Data` di Skyrim.

### Contribuire

Fork, modifica sorgenti/`config.json`/traduzioni, esegui `build.ps1`, testa in gioco, apri una PR.
