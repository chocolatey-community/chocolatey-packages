$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
Write-Host "Closing processes from sysinternals package installation directory"
Remove-Process -PathFilter ([regex]::escape('C:\ProgramData\chocolatey\lib\sysinternals\tools') + ".*") | Out-Null
