$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  packageName  = $env:ChocolateyPackageName
  file         = "$toolsPath\KeePassX-2.0.3.zip"
  destination  = $toolsPath
}

# first we need to remove any existing keepass directory
Get-ChildItem "$toolsPath" -Filter "KeePassX*" | ? { $_.PSIsContainer } | % {
  Remove-Item $_.FullName -Recurse
}

Get-ChocolateyUnzip @packageArgs
Remove-Item -Force -ea 0 "$toolsPath\*.zip"
$filePath = Get-ChildItem "$toolsPath" -Filter "KeePassX.exe" -Recurse | select -First 1 -expand FullName

$programsDir = [System.Environment]::GetFolderPath('Programs')
Install-ChocolateyShortcut `
  -ShortcutFilePath "$programsDir\KeePassX.lnk" `
  -TargetPath "$filePath"
