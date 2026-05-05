# 🚀 One-Click Flutter Shortcuts

Instantly add **150+ professional shortcuts** to your terminal for a faster Flutter development workflow. Works on **Windows, macOS, and Linux**.

## ⚡ Quick Install

Copy and paste the command for your operating system into your terminal:

### 🍎 macOS / 🐧 Linux (Zsh or Bash)
```bash
curl -fsSL https://raw.githubusercontent.com/ranasheikh64/one-click-flutter-shortcut-create/main/flutter_shortcut.sh | bash
```

### 🪟 Windows (PowerShell)
```powershell
iwr -useb https://raw.githubusercontent.com/ranasheikh64/one-click-flutter-shortcut-create/main/flutter_shortcur.ps1 | iex
```

---

## 🛠️ What's Included?

The script adds aliases for almost every Flutter and Dart command, categorized for ease of use:

| Shortcut | Command | Description |
| :--- | :--- | :--- |
| `jronix` | `(Help)` | **Show all shortcuts with a beautiful design** |
| `juninstall` | `(Uninstall)` | **Remove all flutter shortcuts from your system** |
| `fc` | `flutter clean` | Clean build artifacts |
| `fpg` | `flutter pub get` | Get dependencies |
| `fcp` | `flutter clean; flutter pub get` | Clean + Get dependencies |
| `fr` | `flutter run` | Run on default device |
| `fba` | `flutter build apk` | Build APK (Debug) |
| `fbar` | `flutter build apk --release` | Build APK (Release) |
| `fgen` | `flutter pub run build_runner build` | Run Build Runner |
| `fdoc` | `flutter doctor` | Check environment |
| `gpc` | `git pull; fcp` | Pull + Clean + Get packages |

> [!TIP]
> After installation, restart your terminal or run `source ~/.zshrc` (Mac/Linux) or `. $PROFILE` (Windows) to activate the shortcuts.

## 📦 How it works
- **macOS/Linux**: The script appends aliases to your `.zshrc` or `.bashrc` file.
- **Windows**: The script creates functions in your PowerShell `$PROFILE`.
- **CMD**: For legacy Command Prompt, run `flutter_shortcut.bat` to enable shortcuts for the current session.

## 🤝 Contributing
Feel free to fork this repo and add your own favorite shortcuts!

---
Made with ❤️ for Flutter Developers.
