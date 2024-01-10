Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online
Invoke-WebRequest -Uri "https://github.com/PowerShell/PowerShell/releases/download/v7.4.0/PowerShell-7.4.0-win-x64.msi" -Outfile "PowerShell-7.4.0-win-x64.msi"
