$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$pp = Get-PackageParameters
$installDir = $toolsPath
if ($pp.InstallDir -or $pp.InstallationPath ) { $InstallDir = $pp.InstallDir + $pp.InstallationPath }
Write-Host "Sysinternals Suite is going to be installed in '$installDir'"

$packageArgs = @{
  packageName    = 'sysinternals'
  url            = 'https://download.sysinternals.com/files/SysinternalsSuite.zip'
  checksum       = '40b2031b1c8d294be083c46a83161b459c0a7fc05bd380287317eddb78b54af7'
  checksumType   = 'sha256'
  unzipLocation  = $installDir
}
Install-ChocolateyZipPackage @packageArgs
Accept-Eula
if ($installDir -ne $toolsPath) { Install-ChocolateyPath $installDir }
if (Is-NanoServer) {
  $packageArgs.url = 'https://download.sysinternals.com/files/SysinternalsSuite-Nano.zip'
  $packageArgs.checksum = '7b6fab7f0ada0bc2b0748f3bc29e93846869f9dd175a0ca070bbebc07ee5de09'
 }

if (-Not $pp.NoStartMenu) {
  Write-Verbose "Creating start menu entry"
  set-alias 7z $Env:chocolateyInstall\tools\7z.exe
  $linkfiles = get-childitem "$installDir" -include "*.exe" -recurse
  $startmenufolder = "$($env:ProgramData)\Microsoft\Windows\Start Menu\Programs\Sysinternals Suite"
  Add-Content "$toolsPath\chocoUninstall.ps1" -Value "Remove-Item `"$($startmenufolder)`" -Recurse -Force -ea ignore"
  # This will create a Link for all gui application and add a line chocoUninstall.ps1 to remove it on uninstall
  foreach ($file in $linkfiles) {
    $guiinf = 7z l $file
    # Only link gui applications
    if( -Not ( $guiinf -match "^Subsystem = Windows GUI" ) ) { continue }
    Write-Verbose "Creating Start Menu enty for $($file.BaseName)"
    $newlink ="$($startmenufolder)\$($file.BaseName).lnk"
    Install-ChocolateyShortcut -shortcutFilePath $newlink -targetPath "$file"
  }
}

$old_path = 'c:\sysinternals'
if ((Test-Path $old_path) -and ($installDir -ne $old_path)) {
    Write-Warning "Clean up older versions of this install at c:\sysinternals"
}
