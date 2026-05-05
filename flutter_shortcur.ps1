# ╔══════════════════════════════════════════════════════════╗
# ║       Flutter Developer Shortcut Manager v1.1            ║
# ║             Windows PowerShell Version                   ║
# ╚══════════════════════════════════════════════════════════╝
# Run: .\flutter_shortcuts.ps1
# One-liner: iwr -useb https://raw.githubusercontent.com/ranasheikh64/one-click-flutter-shortcut-create/main/flutter_shortcur.ps1 | iex

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

param(
    [switch]$InstallAll,
    [switch]$Remove
)

# ─────────────────────────────────────────────
#  COLOR HELPERS
# ─────────────────────────────────────────────
function Write-Color {
    param([string]$Text, [string]$Color = "White", [switch]$NoNewline)
    if ($NoNewline) { Write-Host $Text -ForegroundColor $Color -NoNewline }
    else            { Write-Host $Text -ForegroundColor $Color }
}
function Green($t)  { Write-Color $t "Green"  -NoNewline }
function Yellow($t) { Write-Color $t "Yellow" -NoNewline }
function Cyan($t)   { Write-Color $t "Cyan"   -NoNewline }
function Red($t)    { Write-Color $t "Red"    -NoNewline }
function Dim($t)    { Write-Color $t "DarkGray" -NoNewline }
function Bold($t)   { Write-Color $t "White"  -NoNewline }

# ─────────────────────────────────────────────
#  SHORTCUT DEFINITIONS
# ─────────────────────────────────────────────
$Shortcuts = [ordered]@{
    # ── Project Management ──
    "fc"       = @("flutter clean",                                                                      "Clean build artifacts",               "Project")
    "fpg"      = @("flutter pub get",                                                                    "Get all dependencies",                "Project")
    "fpu"      = @("flutter pub upgrade",                                                                "Upgrade dependencies",                "Project")
    "fpuM"     = @("flutter pub upgrade --major-versions",                                               "Upgrade to major versions",           "Project")
    "fpo"      = @("flutter pub outdated",                                                               "Show outdated packages",              "Project")
    "fpub"     = @("flutter pub publish",                                                                "Publish package to pub.dev",          "Project")
    "fcp"      = @("flutter clean; flutter pub get",                                                     "Clean then get packages",             "Project")
    "fgen"     = @("flutter pub run build_runner build",                                                 "Run build_runner once",               "Project")
    "fgenw"    = @("flutter pub run build_runner watch",                                                 "Run build_runner watch mode",         "Project")
    "fgend"    = @("flutter pub run build_runner build --delete-conflicting-outputs",                    "Build and delete conflicts",          "Project")
    "fcg"      = @("flutter clean; flutter pub get; flutter pub run build_runner build --delete-conflicting-outputs", "Full clean+get+generate","Project")
    "ffix"     = @("flutter clean; flutter pub cache repair; flutter pub get",                           "Fix broken pub cache",                "Project")
    "fcache"   = @("flutter pub cache clean",                                                            "Clean pub cache",                     "Project")
    "frepair"  = @("flutter pub cache repair",                                                           "Repair pub cache",                    "Project")

    # ── Run & Debug ──
    "fr"       = @("flutter run",                                                                        "Run on default device",               "Run")
    "frd"      = @("flutter run --debug",                                                                "Run in debug mode",                   "Run")
    "frr"      = @("flutter run --release",                                                              "Run in release mode",                 "Run")
    "frp"      = @("flutter run --profile",                                                              "Run in profile mode",                 "Run")
    "frv"      = @("flutter run --verbose",                                                              "Run with verbose output",             "Run")
    "frw"      = @("flutter run -d chrome",                                                              "Run on Chrome Web",                   "Run")
    "fre"      = @("flutter run -d edge",                                                                "Run on Edge Web",                     "Run")
    "frm"      = @("flutter run -d macos",                                                               "Run on macOS desktop",                "Run")
    "frln"     = @("flutter run -d linux",                                                               "Run on Linux desktop",                "Run")
    "frwn"     = @("flutter run -d windows",                                                             "Run on Windows desktop",              "Run")
    "fhot"     = @("flutter run --hot",                                                                  "Run with hot reload",                 "Run")

    # ── Build ──
    "fba"      = @("flutter build apk",                                                                  "Build APK debug",                     "Build")
    "fbar"     = @("flutter build apk --release",                                                        "Build APK release",                   "Build")
    "fbas"     = @("flutter build apk --split-per-abi",                                                  "Build split APKs per ABI",            "Build")
    "fbasr"    = @("flutter build apk --release --split-per-abi",                                        "Build release split APKs",            "Build")
    "fbaab"    = @("flutter build appbundle",                                                            "Build Android App Bundle",            "Build")
    "fbabr"    = @("flutter build appbundle --release",                                                  "Build release App Bundle",            "Build")
    "fbios"    = @("flutter build ios",                                                                  "Build iOS",                           "Build")
    "fbiosr"   = @("flutter build ios --release",                                                        "Build iOS release",                   "Build")
    "fbipa"    = @("flutter build ipa",                                                                  "Build IPA for App Store",             "Build")
    "fbw"      = @("flutter build web",                                                                  "Build Web",                           "Build")
    "fbwr"     = @("flutter build web --release",                                                        "Build Web release",                   "Build")
    "fbwt"     = @("flutter build web --web-renderer canvaskit",                                         "Build Web with CanvasKit",            "Build")
    "fbwn"     = @("flutter build windows",                                                              "Build Windows app",                   "Build")
    "fbwnr"    = @("flutter build windows --release",                                                    "Build Windows release",               "Build")
    "fbl"      = @("flutter build linux",                                                                "Build Linux",                         "Build")

    # ── Test ──
    "ft"       = @("flutter test",                                                                       "Run all tests",                       "Test")
    "ftv"      = @("flutter test --verbose",                                                             "Run tests verbose",                   "Test")
    "ftc"      = @("flutter test --coverage",                                                            "Run tests with coverage",             "Test")
    "ftw"      = @("flutter test --watch",                                                               "Run tests in watch mode",             "Test")
    "ftu"      = @("flutter test test/unit/",                                                            "Run unit tests only",                 "Test")
    "ftwi"     = @("flutter test test/widget/",                                                          "Run widget tests only",               "Test")
    "fti"      = @("flutter test integration_test/",                                                     "Run integration tests",               "Test")

    # ── Analyze & Format ──
    "fan"      = @("flutter analyze",                                                                    "Analyze project for errors",          "Analyze")
    "fanw"     = @("flutter analyze --watch",                                                            "Analyze in watch mode",               "Analyze")
    "fdc"      = @("dart fix --apply",                                                                   "Auto-fix dart issues",                "Analyze")
    "fdf"      = @("dart format .",                                                                      "Format all dart files",               "Analyze")
    "fdfn"     = @("dart format --set-exit-if-changed .",                                                "Format and check changes",            "Analyze")

    # ── Devices & Emulators ──
    "fdev"     = @("flutter devices",                                                                    "List connected devices",              "Devices")
    "femu"     = @("flutter emulators",                                                                  "List available emulators",            "Devices")
    "fadb"     = @("adb devices",                                                                        "List ADB devices",                    "Devices")
    "fadbl"    = @("adb logcat",                                                                         "Show ADB logcat",                     "Devices")
    "fadbc"    = @("adb logcat -c",                                                                      "Clear ADB logcat",                    "Devices")
    "fadbr"    = @("adb reboot",                                                                         "Reboot ADB device",                   "Devices")
    "fadbi"    = @("adb install",                                                                        "Install APK via ADB",                 "Devices")
    "fadbu"    = @("adb uninstall",                                                                      "Uninstall app via ADB",               "Devices")
    "fadbs"    = @("adb shell",                                                                          "Open ADB shell",                      "Devices")
    "fsim"     = @("open -a Simulator",                                                                  "Open iOS Simulator (macOS only)",     "Devices")

    # ── Flutter Doctor & Info ──
    "fdoc"     = @("flutter doctor",                                                                     "Check flutter environment",           "Info")
    "fdocv"    = @("flutter doctor -v",                                                                  "Verbose flutter doctor",              "Info")
    "fver"     = @("flutter --version",                                                                  "Show flutter version",                "Info")
    "fupg"     = @("flutter upgrade",                                                                    "Upgrade flutter SDK",                 "Info")
    "fch"      = @("flutter channel",                                                                    "Show current channel",                "Info")
    "fchs"     = @("flutter channel stable",                                                             "Switch to stable channel",            "Info")
    "fchb"     = @("flutter channel beta",                                                               "Switch to beta channel",              "Info")
    "fchm"     = @("flutter channel master",                                                             "Switch to master channel",            "Info")
    "fwe"      = @("flutter config --enable-web",                                                        "Enable web support",                  "Info")
    "fwed"     = @("flutter config --no-enable-web",                                                     "Disable web support",                 "Info")

    # ── Dart ──
    "drun"     = @("dart run",                                                                           "Run dart file",                       "Dart")
    "dcom"     = @("dart compile exe",                                                                   "Compile dart to native exe",          "Dart")
    "dpg"      = @("dart pub get",                                                                       "Dart pub get",                        "Dart")
    "dpu"      = @("dart pub upgrade",                                                                   "Dart pub upgrade",                    "Dart")
    "dtest"    = @("dart test",                                                                          "Run dart tests",                      "Dart")
    "ddev"     = @("dart pub global activate devtools",                                                  "Activate DevTools",                   "Dart")

    # ── DevTools & Performance ──
    "fdt"      = @("flutter pub global run devtools",                                                    "Launch Flutter DevTools",             "DevTools")
    "fperf"    = @("flutter run --profile --trace-skia",                                                 "Profile with Skia tracing",           "DevTools")
    "fss"      = @("flutter screenshot",                                                                 "Take screenshot",                     "DevTools")
    "flog"     = @("flutter logs",                                                                       "Stream device logs",                  "DevTools")
    "fatt"     = @("flutter attach",                                                                     "Attach to running app",               "DevTools")

    # ── Git + Flutter Workflow ──
    "gfc"      = @("git fetch; flutter clean; flutter pub get",                                          "Git fetch + clean + pub get",         "Workflow")
    "gpc"      = @("git pull; flutter clean; flutter pub get",                                           "Git pull + clean + pub get",          "Workflow")
    "gbuild"   = @("git pull; flutter clean; flutter pub get; flutter build apk --release",              "Pull + clean + release APK",          "Workflow")

    # ── Create & Generate ──
    "fnew"     = @("flutter create",                                                                     "Create new Flutter project",          "Create")
    "fnewp"    = @("flutter create --template=package",                                                  "Create new package",                  "Create")
    "fnewpl"   = @("flutter create --template=plugin",                                                   "Create new plugin",                   "Create")
    "fnewa"    = @("flutter create --template=app",                                                      "Create new app",                      "Create")
    "fnewm"    = @("flutter create --template=module",                                                   "Create Flutter module",               "Create")
    "fl10n"    = @("flutter gen-l10n",                                                                   "Generate localizations",              "Create")
    "ficon"    = @("flutter pub run flutter_launcher_icons",                                             "Generate launcher icons",             "Create")
    "fsplash"  = @("flutter pub run flutter_native_splash:create",                                       "Generate native splash",              "Create")

    # ── Jronix ──
    "jronix"   = @("Show-Jronix",                                                                        "Show all available shortcuts",        "Help")
}

# ─────────────────────────────────────────────
#  POWERSHELL PROFILE PATH
# ─────────────────────────────────────────────
$ProfilePath = $PROFILE
$MarkerStart = "# ==== Flutter Shortcuts (auto-generated) ===="
$MarkerEnd   = "# ==== Flutter Shortcuts END ===="

# ─────────────────────────────────────────────
#  CORE FUNCTIONS
# ─────────────────────────────────────────────
function Check-Flutter {
    Write-Host ""
    Write-Host "  Flutter Environment Check" -ForegroundColor White
    Write-Host ("  " + "─" * 44) -ForegroundColor DarkGray

    $flutterPath = Get-Command flutter -ErrorAction SilentlyContinue
    $script:FlutterOK = $false

    if ($flutterPath) {
        try {
            $ver = (flutter --version 2>&1 | Select-Object -First 1).ToString()
            Write-Host "  " -NoNewline; Green "✔"; Write-Host " Flutter : " -NoNewline; Green $ver; Write-Host ""
            Write-Host "  " -NoNewline; Dim    "  Path    : $($flutterPath.Source)"; Write-Host ""
            $script:FlutterOK = $true
        } catch {
            Write-Host "  " -NoNewline; Green "✔"; Write-Host " Flutter : Found" -ForegroundColor Green
            $script:FlutterOK = $true
        }
    } else {
        Write-Host "  " -NoNewline; Red "✘"; Write-Host " Flutter : NOT FOUND" -ForegroundColor Red
    }
    Write-Host ""
}

function Build-ProfileBlock($selected) {
    $lines = @($MarkerStart)
    $lines += "# Managed by flutter_shortcuts.ps1 - do not edit manually"
    $lines += ""
    foreach ($alias in $selected.Keys) {
        $cmd  = $selected[$alias][0]
        $desc = $selected[$alias][1]
        $cat  = $selected[$alias][2]
        $lines += "# $cat : $desc"
        $lines += "function $alias { $cmd `$args }"
    }
    $lines += ""
    $lines += $MarkerEnd
    return $lines -join "`n"
}

function Remove-ExistingBlock($content) {
    $start = $content.IndexOf($MarkerStart)
    $end   = $content.IndexOf($MarkerEnd)
    if ($start -ge 0 -and $end -ge 0) {
        $before = $content.Substring(0, $start)
        $after  = $content.Substring($end + $MarkerEnd.Length).TrimStart("`n")
        return $before + $after
    }
    return $content
}

function Write-ToProfile($selected) {
    $profileDir = Split-Path $ProfilePath -Parent
    if (-not (Test-Path $profileDir)) {
        New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
    }
    $existing = if (Test-Path $ProfilePath) { Get-Content $ProfilePath -Raw } else { "" }
    if ($null -eq $existing) { $existing = "" }
    $cleaned = Remove-ExistingBlock $existing
    $block   = Build-ProfileBlock $selected
    $final   = $cleaned.TrimEnd() + "`n`n" + $block + "`n"
    Set-Content -Path $ProfilePath -Value $final -Encoding UTF8
    return $ProfilePath
}

function Load-IntoSession($selected) {
    foreach ($alias in $selected.Keys) {
        $cmd = $selected[$alias][0]
        # Define in Global scope so it persists after script exits
        $funcBody = [scriptblock]::Create("$cmd `$args")
        Set-Item -Path "Global:Function:$alias" -Value $funcBody
    }
}

function Print-Success($path, $count) {
    Write-Host ""
    Write-Host "  " -NoNewline; Green "✔"; Write-Host " $count shortcuts written to profile:"
    Write-Host "    " -NoNewline; Cyan $path; Write-Host ""
    Write-Host ""
    Write-Host "  Also loaded into THIS PowerShell session immediately!" -ForegroundColor Green
    Write-Host ""
    Write-Host "  Usage: " -NoNewline; Green "fc"; Write-Host " (clean), " -NoNewline; Green "fcp"; Write-Host " (clean+get), " -NoNewline; Green "fr"; Write-Host " (run)"
    Write-Host ""
}

# ─────────────────────────────────────────────
#  MENU ACTIONS
# ─────────────────────────────────────────────
function Show-Jronix {
    param($args)
    Clear-Host
    Write-Host ""
    Write-Host "  ╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
    Write-Host "  ║                WELCOME TO JRONIX                     ║" -ForegroundColor Cyan
    Write-Host "  ║       Flutter Developer Shortcut Manager v1.1        ║" -ForegroundColor Cyan
    Write-Host "  ╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
    Write-Host ""
    
    $lastCat = ""
    foreach ($alias in $Shortcuts.Keys) {
        $cmd  = $Shortcuts[$alias][0]; $desc = $Shortcuts[$alias][1]; $cat = $Shortcuts[$alias][2]
        if ($cat -ne $lastCat) {
            Write-Host ""; Write-Host "  [ $cat ]" -ForegroundColor Cyan
            Write-Host ("  " + "─" * 55) -ForegroundColor DarkGray
            $lastCat = $cat
        }
        Write-Host "  " -NoNewline; Green ("{0,-12}" -f $alias); Write-Host "  $desc"
    }
    Write-Host ""
    Write-Host "  Usage: Type any shortcut and press Enter!" -ForegroundColor Yellow
    Write-Host ""
}

function View-AllShortcuts {
    Show-Jronix
    Read-Host "  Press Enter to continue"
}

function Install-All {
    Write-Host ""; Write-Host "  Installing $($Shortcuts.Count) shortcuts..." -ForegroundColor White
    Load-IntoSession $Shortcuts
    $path = Write-ToProfile $Shortcuts
    Print-Success $path $Shortcuts.Count
}

function Remove-AllShortcuts {
    if (Test-Path $ProfilePath) {
        $content = Get-Content $ProfilePath -Raw
        $cleaned = Remove-ExistingBlock $content
        Set-Content -Path $ProfilePath -Value $cleaned -Encoding UTF8
        Write-Host ""; Write-Host "  " -NoNewline; Green "✔"; Write-Host " Removed from profile."
    }
    foreach ($alias in $Shortcuts.Keys) {
        if (Test-Path "Function:$alias") { Remove-Item "Function:$alias" -Force -ErrorAction SilentlyContinue }
    }
    Write-Host "  Removed from current session." -ForegroundColor Green
}

# ─────────────────────────────────────────────
#  ENTRY POINT
# ─────────────────────────────────────────────
if ($InstallAll) { Install-All; exit }
if ($Remove) { Remove-AllShortcuts; exit }

Clear-Host
Write-Host ""
Write-Host "  ╔══════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "  ║      Flutter Developer Shortcut Manager v1.1         ║" -ForegroundColor Cyan
Write-Host "  ║             Windows PowerShell Version               ║" -ForegroundColor Cyan
Write-Host "  ╚══════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Check-Flutter

do {
    Write-Host ""
    Write-Host "  What would you like to do?" -ForegroundColor White
    Write-Host ("  " + "─" * 40) -ForegroundColor DarkGray
    Write-Host "  " -NoNewline; Cyan "1."; Write-Host " Install ALL shortcuts  (" -NoNewline; Green "$($Shortcuts.Count)"; Write-Host " shortcuts)"
    Write-Host "  " -NoNewline; Cyan "2."; Write-Host " View all shortcuts"
    Write-Host "  " -NoNewline; Cyan "3."; Write-Host " Remove all Flutter shortcuts"
    Write-Host "  " -NoNewline; Cyan "4."; Write-Host " Exit"
    Write-Host ""

    $choice = Read-Host "  Enter choice [1]"
    if ($choice -eq "") { $choice = "1" }

    switch ($choice) {
        "1" { Install-All }
        "2" { View-AllShortcuts }
        "3" { Remove-AllShortcuts }
        "4" { Write-Host ""; break }
        default { Write-Host "  Invalid choice." -ForegroundColor Red }
    }
} while ($choice -ne "4")