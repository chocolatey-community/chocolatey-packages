$ErrorActionPreference = 'Stop'

$packageArgs = @{
  packageName    = '1password'
  fileType       = 'msi'
  softwareName   = '1Password 8'

  checksum       = '2842A176BD3505033578FDC190D663EB947F21005ECD9CB8169FFC27476D08BA'
  checksumType   = 'sha256'
  url            = 'https://c.1password.com/dist/1P/win8/1PasswordSetup-8.10.27.msi'

  silentArgs     = "/qn"
  validExitCodes = @(0)
}


Install-ChocolateyPackage @packageArgs

$packageName = $packageArgs.packageName
$installLocation = Get-AppInstallLocation "$packageName*"
if (!$installLocation)  { Write-Warning "Can't find $packageName install location"; return }
Write-Host "$packageName installed to '$installLocation'"

$1password_registry_uninstall=Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall, HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall | Get-ItemProperty | Where-Object {$_.DisplayName -match “1password*” }
$registry_path=$1password_registry_uninstall.PSPath
$registry_install_location=$1password_registry_uninstall.InstallLocation

#For some reason 1Password msi says it installed in C:\APPDIR sometimes rather than C:\Program Files\1Password
#Just flagging it and this is why we need custom uninstall
if (!($installLocation -ieq $registry_install_location))
{
  Write-Host "Registry claims installed to:'$registry_install_location' rather than correct:'$installLocation'"
}
