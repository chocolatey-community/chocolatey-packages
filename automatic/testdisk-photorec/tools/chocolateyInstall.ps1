$ErrorActionPreference = 'Stop';

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$previousDirectories = Get-ChildItem "$toolsPath" -Filter "testdisk*" | ? { Test-Path -PathType Container $_.FullName }
if ($previousDirectories) { Remove-Item $previousDirectories.FullName -Force -ea 0 -Recurse }

$packageArgs = @{
  packageName  = 'testdisk-photorec'
  fileType     = 'zip'
  file         = "$toolsPath\testdisk-7.0.win.zip"
  destination  = "$toolsPath"
}

Get-ChocolateyUnzip @packageArgs

Remove-Item "$toolsPath\*.zip" -Force -ea 0

$files = Get-ChildItem "$toolsPath" -Include "testdisk_win.exe",'*photorec_win.exe' -Recurse
$desktopPath = [System.Environment]::GetFolderPath('Desktop')
$files | % {
  $fileName = $_.BaseName
  Install-ChocolateyShortcut -ShortcutFilePath "$desktopPath\$fileName.lnk" -TargetPath $_.FullName
}
