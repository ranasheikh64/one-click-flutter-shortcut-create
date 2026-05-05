@echo off
setlocal EnableDelayedExpansion
chcp 65001 >nul 2>&1

:: ╔══════════════════════════════════════════════════════════╗
:: ║       Flutter Developer Shortcut Manager v1.1            ║
:: ║              Windows CMD Version                         ║
:: ╚══════════════════════════════════════════════════════════╝

set "CYAN=[96m"
set "GREEN=[92m"
set "RESET=[0m"
set "BOLD=[1m"

set COUNT=0
call :ADD_SC "fc"       "flutter clean"                               "Clean build artifacts"
call :ADD_SC "fpg"      "flutter pub get"                             "Get dependencies"
call :ADD_SC "fpu"      "flutter pub upgrade"                         "Upgrade dependencies"
call :ADD_SC "fpuM"     "flutter pub upgrade --major-versions"        "Upgrade to major versions"
call :ADD_SC "fcp"      "flutter clean && flutter pub get"            "Clean then get packages"
call :ADD_SC "fgen"     "flutter pub run build_runner build"          "Run build_runner"
call :ADD_SC "fgenw"    "flutter pub run build_runner watch"          "Run build_runner watch"
call :ADD_SC "fcg"      "flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs" "Full clean+get+generate"

call :ADD_SC "fr"       "flutter run"                                 "Run on default device"
call :ADD_SC "frd"      "flutter run --debug"                         "Run in debug mode"
call :ADD_SC "frr"      "flutter run --release"                       "Run in release mode"
call :ADD_SC "frw"      "flutter run -d chrome"                       "Run on Chrome Web"

call :ADD_SC "fba"      "flutter build apk"                           "Build APK debug"
call :ADD_SC "fbar"     "flutter build apk --release"                 "Build APK release"
call :ADD_SC "fbaab"    "flutter build appbundle"                     "Build App Bundle"
call :ADD_SC "fbw"      "flutter build web"                           "Build Web"

call :ADD_SC "ft"       "flutter test"                                "Run all tests"
call :ADD_SC "fan"      "flutter analyze"                             "Analyze project"
call :ADD_SC "fdf"      "dart format ."                               "Format all dart files"

call :ADD_SC "fdev"     "flutter devices"                             "List devices"
call :ADD_SC "fdoc"     "flutter doctor"                              "Check environment"
call :ADD_SC "fver"     "flutter --version"                           "Show version"

call :ADD_SC "gfc"      "git fetch && flutter clean && flutter pub get" "Git fetch+clean+get"
call :ADD_SC "gpc"      "git pull && flutter clean && flutter pub get"  "Git pull+clean+get"

goto :MAIN

:ADD_SC
set /a COUNT+=1
set "ALIAS[!COUNT!]=%~1"
set "CMD[!COUNT!]=%~2"
set "DESC[!COUNT!]=%~3"
goto :eof

:MAIN
cls
echo.
echo  %CYAN%╔══════════════════════════════════════════════════════╗%RESET%
echo  %CYAN%║      Flutter Developer Shortcut Manager v1.1         ║%RESET%
echo  %CYAN%║               Windows CMD Version                    ║%RESET%
echo  %CYAN%╚══════════════════════════════════════════════════════╝%RESET%
echo.

:MENU
echo  %BOLD%  Available shortcuts (%COUNT% total):%RESET%
for /l %%i in (1,1,!COUNT!) do (
    echo   %GREEN%!ALIAS[%%i]!%RESET%   !DESC[%%i]!
)
echo.
echo   %CYAN%1.%RESET% Install for this session
echo   %CYAN%2.%RESET% Exit
echo.
set /p CHOICE="  Choice [1]: "
if "%CHOICE%"=="" set CHOICE=1
if "%CHOICE%"=="1" goto :INSTALL
if "%CHOICE%"=="2" exit /b

:INSTALL
for /l %%i in (1,1,!COUNT!) do (
    doskey !ALIAS[%%i]!=!CMD[%%i]!
)
echo.
echo  %GREEN%✔ Shortcuts installed for this CMD session!%RESET%
pause
goto :MENU