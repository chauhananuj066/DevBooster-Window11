# DevBooster-Window11
# 🛠️ Windows 11 Dev Booster Tool – PowerShell GUI (Safe for Developers)

This is a lightweight GUI tool built using native PowerShell and WPF that helps Windows 11 developers optimize system performance with **no risk to essential dev tools** like Visual Studio, Docker, IIS, or Windows Updates.

---

## ✅ Features

| Optimization Option | Description |
|---------------------|-------------|
| Clean Temp and Cache Files | Clears %TEMP%, Windows Temp, and Prefetch directories |
| Disable SysMain, DiagTrack, WSearch | Disables unnecessary services that slow boot time |
| Disable Background Apps | Prevents apps from running in the background |
| Enable High Performance Power Plan | Switches to high performance mode |
| Optimize Visual Effects | Speeds up UI by reducing animation delay |
| Create System Restore Point | Restores your system state before applying tweaks |

---

## 📦 File Contents

- `DevBooster.ps1` – Main PowerShell script
- `README.md` – This documentation
- `LICENSE` – MIT license (for open-source use)
- `CONTRIBUTING.md` – Contribution guidelines (optional)

---

## 🖥️ Requirements

- Windows 10/11
- PowerShell 5.1 or PowerShell 7+
- Admin privileges (for system changes)
- Script execution enabled:

```powershell
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
