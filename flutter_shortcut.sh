#!/usr/bin/env bash
# ╔══════════════════════════════════════════════════════════╗
# ║       Flutter Developer Shortcut Manager v1.1            ║
# ║            macOS & Linux Terminal Version                ║
# ╚══════════════════════════════════════════════════════════╝
# One-liner: curl -fsSL https://raw.githubusercontent.com/ranasheikh64/one-click-flutter-shortcut-create/main/flutter_shortcut.sh | bash

# ─────────────────────────────────────────────
#  COLORS
# ─────────────────────────────────────────────
RED='\033[0;91m'
GREEN='\033[0;92m'
YELLOW='\033[0;93m'
CYAN='\033[0;96m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# ─────────────────────────────────────────────
#  SHORTCUT DEFINITIONS
# ─────────────────────────────────────────────
ALIASES=()
CMDS=()
DESCS=()
CATS=()

add_sc() {
    ALIASES+=("$1")
    CMDS+=("$2")
    DESCS+=("$3")
    CATS+=("$4")
}

# ── Project Management ──
add_sc "fc"       "flutter clean"                                                                          "Clean build artifacts"                "Project"
add_sc "fpg"      "flutter pub get"                                                                        "Get all dependencies"                 "Project"
add_sc "fpu"      "flutter pub upgrade"                                                                    "Upgrade dependencies"                 "Project"
add_sc "fpuM"     "flutter pub upgrade --major-versions"                                                   "Upgrade to major versions"            "Project"
add_sc "fpo"      "flutter pub outdated"                                                                   "Show outdated packages"               "Project"
add_sc "fpub"     "flutter pub publish"                                                                    "Publish package to pub.dev"           "Project"
add_sc "fcp"      "flutter clean && flutter pub get"                                                       "Clean then get packages"              "Project"
add_sc "fgen"     "flutter pub run build_runner build"                                                     "Run build_runner once"                "Project"
add_sc "fgenw"    "flutter pub run build_runner watch"                                                     "Run build_runner watch mode"          "Project"
add_sc "fgend"    "flutter pub run build_runner build --delete-conflicting-outputs"                        "Build and delete conflicts"           "Project"
add_sc "fcg"      "flutter clean && flutter pub get && flutter pub run build_runner build --delete-conflicting-outputs" "Full clean+get+generate" "Project"
add_sc "ffix"     "flutter clean && flutter pub cache repair && flutter pub get"                           "Fix broken pub cache"                 "Project"
add_sc "fcache"   "flutter pub cache clean"                                                                "Clean pub cache"                      "Project"
add_sc "frepair"  "flutter pub cache repair"                                                               "Repair pub cache"                     "Project"

# ── Run & Debug ──
add_sc "fr"       "flutter run"                                                                            "Run on default device"                "Run"
add_sc "frd"      "flutter run --debug"                                                                    "Run in debug mode"                    "Run"
add_sc "frr"      "flutter run --release"                                                                  "Run in release mode"                  "Run"
add_sc "frp"      "flutter run --profile"                                                                  "Run in profile mode"                  "Run"
add_sc "frv"      "flutter run --verbose"                                                                  "Run with verbose output"              "Run"
add_sc "frw"      "flutter run -d chrome"                                                                  "Run on Chrome Web"                    "Run"
add_sc "fre"      "flutter run -d edge"                                                                    "Run on Edge Web"                      "Run"
add_sc "frm"      "flutter run -d macos"                                                                   "Run on macOS desktop"                 "Run"
add_sc "frln"     "flutter run -d linux"                                                                   "Run on Linux desktop"                 "Run"
add_sc "fhot"     "flutter run --hot"                                                                      "Run with hot reload"                  "Run"

# ── Build ──
add_sc "fba"      "flutter build apk"                                                                      "Build APK debug"                      "Build"
add_sc "fbar"     "flutter build apk --release"                                                            "Build APK release"                    "Build"
add_sc "fbas"     "flutter build apk --split-per-abi"                                                      "Build split APKs per ABI"             "Build"
add_sc "fbasr"    "flutter build apk --release --split-per-abi"                                            "Build release split APKs"             "Build"
add_sc "fbaab"    "flutter build appbundle"                                                                 "Build Android App Bundle"             "Build"
add_sc "fbabr"    "flutter build appbundle --release"                                                      "Build release App Bundle"             "Build"
add_sc "fbios"    "flutter build ios"                                                                       "Build iOS"                            "Build"
add_sc "fbiosr"   "flutter build ios --release"                                                            "Build iOS release"                    "Build"
add_sc "fbipa"    "flutter build ipa"                                                                       "Build IPA for App Store"              "Build"
add_sc "fbw"      "flutter build web"                                                                       "Build Web"                            "Build"
add_sc "fbwr"     "flutter build web --release"                                                            "Build Web release"                    "Build"
add_sc "fbwt"     "flutter build web --web-renderer canvaskit"                                             "Build Web with CanvasKit"             "Build"
add_sc "fbm"      "flutter build macos"                                                                    "Build macOS"                          "Build"
add_sc "fbmr"     "flutter build macos --release"                                                          "Build macOS release"                  "Build"
add_sc "fbl"      "flutter build linux"                                                                    "Build Linux"                          "Build"

# ── Test ──
add_sc "ft"       "flutter test"                                                                           "Run all tests"                        "Test"
add_sc "ftv"      "flutter test --verbose"                                                                 "Run tests verbose"                    "Test"
add_sc "ftc"      "flutter test --coverage"                                                                "Run tests with coverage"              "Test"
add_sc "ftw"      "flutter test --watch"                                                                   "Run tests in watch mode"              "Test"
add_sc "ftu"      "flutter test test/unit/"                                                                "Run unit tests only"                  "Test"
add_sc "ftwi"     "flutter test test/widget/"                                                              "Run widget tests only"                "Test"
add_sc "fti"      "flutter test integration_test/"                                                         "Run integration tests"                "Test"

# ── Analyze & Format ──
add_sc "fan"      "flutter analyze"                                                                        "Analyze project for errors"           "Analyze"
add_sc "fanw"     "flutter analyze --watch"                                                                "Analyze in watch mode"                "Analyze"
add_sc "fdc"      "dart fix --apply"                                                                       "Auto-fix dart issues"                 "Analyze"
add_sc "fdf"      "dart format ."                                                                          "Format all dart files"                "Analyze"
add_sc "fdfn"     "dart format --set-exit-if-changed ."                                                    "Format and check changes"             "Analyze"

# ── Devices & Emulators ──
add_sc "fdev"     "flutter devices"                                                                        "List connected devices"               "Devices"
add_sc "femu"     "flutter emulators"                                                                      "List available emulators"             "Devices"
add_sc "fadb"     "adb devices"                                                                            "List ADB devices"                     "Devices"
add_sc "fadbl"    "adb logcat"                                                                             "Show ADB logcat"                      "Devices"
add_sc "fadbc"    "adb logcat -c"                                                                          "Clear ADB logcat"                    "Devices"
add_sc "fadbr"    "adb reboot"                                                                             "Reboot ADB device"                    "Devices"
add_sc "fadbi"    "adb install"                                                                            "Install APK via ADB"                  "Devices"
add_sc "fadbu"    "adb uninstall"                                                                          "Uninstall app via ADB"                "Devices"
add_sc "fadbs"    "adb shell"                                                                              "Open ADB shell"                       "Devices"
add_sc "fsim"     "open -a Simulator"                                                                      "Open iOS Simulator (macOS only)"      "Devices"

# ── Flutter Doctor & Info ──
add_sc "fdoc"     "flutter doctor"                                                                         "Check flutter environment"            "Info"
add_sc "fdocv"    "flutter doctor -v"                                                                      "Verbose flutter doctor"               "Info"
add_sc "fver"     "flutter --version"                                                                      "Show flutter version"                 "Info"
add_sc "fupg"     "flutter upgrade"                                                                        "Upgrade flutter SDK"                  "Info"
add_sc "fch"      "flutter channel"                                                                        "Show current channel"                 "Info"
add_sc "fchs"     "flutter channel stable"                                                                 "Switch to stable channel"             "Info"
add_sc "fchb"     "flutter channel beta"                                                                   "Switch to beta channel"               "Info"
add_sc "fchm"     "flutter channel master"                                                                 "Switch to master channel"             "Info"
add_sc "fwe"      "flutter config --enable-web"                                                            "Enable web support"                   "Info"
add_sc "fwed"     "flutter config --no-enable-web"                                                         "Disable web support"                  "Info"

# ── Dart ──
add_sc "drun"     "dart run"                                                                               "Run dart file"                        "Dart"
add_sc "dcom"     "dart compile exe"                                                                       "Compile dart to native exe"           "Dart"
add_sc "dpg"      "dart pub get"                                                                           "Dart pub get"                         "Dart"
add_sc "dpu"      "dart pub upgrade"                                                                       "Dart pub upgrade"                     "Dart"
add_sc "dtest"    "dart test"                                                                              "Run dart tests"                       "Dart"
add_sc "ddev"     "dart pub global activate devtools"                                                      "Activate DevTools"                    "Dart"

# ── DevTools & Performance ──
add_sc "fdt"      "flutter pub global run devtools"                                                        "Launch Flutter DevTools"              "DevTools"
add_sc "fperf"    "flutter run --profile --trace-skia"                                                     "Profile with Skia tracing"            "DevTools"
add_sc "fss"      "flutter screenshot"                                                                     "Take screenshot"                      "DevTools"
add_sc "flog"     "flutter logs"                                                                           "Stream device logs"                   "DevTools"
add_sc "fatt"     "flutter attach"                                                                         "Attach to running app"                "DevTools"

# ── Git + Flutter Workflow ──
add_sc "gfc"      "git fetch && flutter clean && flutter pub get"                                          "Git fetch + clean + pub get"          "Workflow"
add_sc "gpc"      "git pull && flutter clean && flutter pub get"                                           "Git pull + clean + pub get"           "Workflow"
add_sc "gbuild"   "git pull && flutter clean && flutter pub get && flutter build apk --release"            "Pull + clean + release APK"           "Workflow"

# ── Create & Generate ──
add_sc "fnew"     "flutter create"                                                                         "Create new Flutter project"           "Create"
add_sc "fnewp"    "flutter create --template=package"                                                      "Create new package"                   "Create"
add_sc "fnewpl"   "flutter create --template=plugin"                                                       "Create new plugin"                    "Create"
add_sc "fnewa"    "flutter create --template=app"                                                          "Create new app"                       "Create"
add_sc "fnewm"    "flutter create --template=module"                                                       "Create Flutter module"                "Create"
add_sc "fl10n"    "flutter gen-l10n"                                                                       "Generate localizations"               "Create"
add_sc "ficon"    "flutter pub run flutter_launcher_icons"                                                 "Generate launcher icons"              "Create"
add_sc "fsplash"  "flutter pub run flutter_native_splash:create"                                           "Generate native splash"               "Create"

# ── Help ──
add_sc "jronix"   "jronix"                                                                                 "Show all available shortcuts"          "Help"

TOTAL=${#ALIASES[@]}
MARKER_START="# ==== Flutter Shortcuts (auto-generated) ===="
MARKER_END="# ==== Flutter Shortcuts END ===="

jronix() {
    clear
    echo -e "\n  ${CYAN}╔══════════════════════════════════════════════════════╗${RESET}"
    echo -e "  ${CYAN}║                WELCOME TO JRONIX                     ║${RESET}"
    echo -e "  ${CYAN}║       Flutter Developer Shortcut Manager v1.1         ║${RESET}"
    echo -e "  ${CYAN}╚══════════════════════════════════════════════════════╝${RESET}"
    echo ""
    
    local last_cat=""
    for i in "${!ALIASES[@]}"; do
        if [ "${CATS[$i]}" != "$last_cat" ]; then
            echo -e "\n  ${CYAN}[ ${CATS[$i]} ]${RESET}"
            echo    "  ──────────────────────────────────────────────────"
            last_cat="${CATS[$i]}"
        fi
        printf "  ${GREEN}%-12s${RESET} %s\n" "${ALIASES[$i]}" "${DESCS[$i]}"
    done
    echo -e "\n  ${YELLOW}Usage: Type any shortcut and press Enter!${RESET}\n"
}

# ─────────────────────────────────────────────
#  DETECT RC FILE
# ─────────────────────────────────────────────
detect_rc() {
    if [ "$(uname -s)" = "Darwin" ]; then
        RC_FILE="$HOME/.zshrc"
        [ ! -f "$RC_FILE" ] && RC_FILE="$HOME/.bash_profile"
    else
        RC_FILE="$HOME/.bashrc"
    fi
}

# ─────────────────────────────────────────────
#  CORE FUNCTIONS
# ─────────────────────────────────────────────
remove_block() {
    [ ! -f "$1" ] && return
    sed -i.bak "/$MARKER_START/,/$MARKER_END/d" "$1" && rm "${1}.bak"
}

write_shortcuts() {
    detect_rc
    remove_block "$RC_FILE"
    echo -e "\n$MARKER_START" >> "$RC_FILE"
    echo "# Managed by flutter_shortcuts.sh — do not edit manually" >> "$RC_FILE"
    
    # Add jronix function to RC file
    echo "jronix() {" >> "$RC_FILE"
    echo "    clear" >> "$RC_FILE"
    echo "    echo -e \"\\n  \${CYAN}╔══════════════════════════════════════════════════════╗\${RESET}\"" >> "$RC_FILE"
    echo "    echo -e \"  \${CYAN}║                WELCOME TO JRONIX                     ║\${RESET}\"" >> "$RC_FILE"
    echo "    echo -e \"  \${CYAN}║       Flutter Developer Shortcut Manager v1.1         ║\${RESET}\"" >> "$RC_FILE"
    echo "    echo -e \"  \${CYAN}╚══════════════════════════════════════════════════════╝\${RESET}\"" >> "$RC_FILE"
    echo "    echo \"\"" >> "$RC_FILE"
    echo "    # [List generated shortcuts below]" >> "$RC_FILE"
    for i in "${!ALIASES[@]}"; do
        [ "${ALIASES[$i]}" = "jronix" ] && continue
        echo "    printf \"  \${GREEN}%-12s\${RESET} %s\\n\" \"${ALIASES[$i]}\" \"${DESCS[$i]}\"" >> "$RC_FILE"
    done
    echo "    echo -e \"\\n  \${YELLOW}Usage: Type any shortcut and press Enter!\\n\${RESET}\"" >> "$RC_FILE"
    echo "}" >> "$RC_FILE"

    for i in "${!ALIASES[@]}"; do
        [ "${ALIASES[$i]}" = "jronix" ] && continue
        echo "alias ${ALIASES[$i]}='${CMDS[$i]}'" >> "$RC_FILE"
    done
    echo "$MARKER_END" >> "$RC_FILE"
    echo "$RC_FILE"
}

check_flutter() {
    echo -e "\n  ${BOLD}Flutter Environment Check${RESET}"
    if command -v flutter &>/dev/null; then
        echo -e "  ${GREEN}✔${RESET} Flutter : $(flutter --version | head -1)"
    else
        echo -e "  ${RED}✘${RESET} Flutter : NOT FOUND"
    fi
}

install_all() {
    echo -e "\n  Installing ${GREEN}${TOTAL}${RESET} shortcuts..."
    RC=$(write_shortcuts)
    echo -e "  ${GREEN}✔${RESET} Written to ${CYAN}${RC}${RESET}"
    echo -e "  ${BOLD}Run:${RESET} ${YELLOW}source ${RC}${RESET} to activate."
}

# ─────────────────────────────────────────────
#  ENTRY POINT
# ─────────────────────────────────────────────
if [[ "$1" == "--install" || ! -t 0 ]]; then
    install_all
    exit 0
fi

clear
echo -e "\n  ${CYAN}╔══════════════════════════════════════════════════════╗${RESET}"
echo -e "  ${CYAN}║      Flutter Developer Shortcut Manager v1.1         ║${RESET}"
echo -e "  ${CYAN}╚══════════════════════════════════════════════════════╝${RESET}"
check_flutter

while true; do
    echo -e "\n  ${BOLD}What would you like to do?${RESET}"
    echo -e "  ${CYAN}1.${RESET} Install ALL shortcuts (${GREEN}${TOTAL}${RESET})"
    echo -e "  ${CYAN}2.${RESET} View all shortcuts"
    echo -e "  ${CYAN}3.${RESET} Remove all shortcuts"
    echo -e "  ${CYAN}4.${RESET} Exit"
    read -p "  Choice [1]: " CHOICE
    CHOICE=${CHOICE:-1}
    case $CHOICE in
        1) install_all ;;
        2) jronix; read -p "  Press Enter to continue..." ;;
        3) detect_rc; remove_block "$RC_FILE"; echo -e "  ${GREEN}✔${RESET} Removed.";;
        4) exit 0 ;;
    esac
done