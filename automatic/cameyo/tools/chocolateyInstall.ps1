$ErrorActionPreference = 'Stop';

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName    = 'cameyo'
  fileFullPath   = "$toolsDir\Cameyo.exe"
  url            = 'http://online.cameyo.com/packager.aspx?op=Retrieve&pkgId=1'
  checksum       = '1787eead7d6bb0d581139b941474e8c0a5b3c182ef653cac7d527b64d82d2cef'
  checksumType   = 'sha256'
}

Get-ChocolateyWebFile @packageArgs

$desktop = [System.Environment]::GetFolderPath('Desktop')

Install-ChocolateyShortcut `
  -ShortcutFilePath "$desktop\Cameyo.lnk" `
  -TargetPath $packageArgs.fileFullPath

$startMenu = $([System.Environment]::GetFolderPath([System.Environment+SpecialFolder]::StartMenu))

Install-ChocolateyShortcut `
  -ShortcutFilePath "$startMenu\Programs\Cameyo.lnk" `
  -TargetPath $packageArgs.fileFullPath
