# VPN Auto-Connect
Registers a scheduled task that automatically initiates a specified VPN connection whenever a user logs in or every time the PC is unlocked.
  
### Instructions
Run the following set of commands in an elevated PowerShell console:
```powershell
Push-Location "C:\Path\To\Folder"
  
& '.\VPN Auto-Connect.ps1'
  
Pop-Location
```