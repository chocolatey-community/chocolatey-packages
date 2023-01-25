$packageName = 'totalcommander'
$packageSearch = "Total Commander*"
$installerType = 'exe'
$silentArgs = ''
$validExitCodes = @(0)

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

# Remove the shell integration, if added
Remove-TCShellExtension

# Rser back to Explorere being the default File Manager
Set-ExplorerAsDefaultFM

$scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$ahkFile = Join-Path -Path $scriptPath -ChildPath "chocolateyUninstall.ahk"
$ahkExe = 'AutoHotKey'
$ahkRun = "$Env:Temp\$(Get-Random).ahk"
Copy-Item -Path $ahkFile -Destination "$ahkRun" -Force

Start-Process $ahkExe $ahkRun
Get-ItemProperty -Path @('HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*',
                         'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                         'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*') `
                 -ErrorAction:SilentlyContinue `
| Where-Object   {$_.DisplayName -like $packageSearch} `
| ForEach-Object {Uninstall-ChocolateyPackage -PackageName "$packageName" `
                                              -FileType "$installerType" `
                                              -SilentArgs "$($silentArgs)" `
                                              -File "$($_.UninstallString.Replace('"',''))" `
                                              -ValidExitCodes $validExitCodes}
Remove-Item -Path "$ahkRun" -Force
