$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$pp = Get-PackageParameters
$shortcutName = 'Windows Media 10 Creation Tool.lnk'
$exePath = Join-Path $toolsDir $exeName 


$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  Url          = 'https://download.microsoft.com/download/4/c/c/4cc6c15c-75a5-4d1b-a3fe-140a5e09c9ff/MediaCreationTool20H2.exe'
  FileFullPath = "$exePath"
  Checksum     = 'FAB34CCBEFBCDCEC8F823840C16AE564812D0E063319C4EB4CC1112CF775B8764FEA59D0BBAFD4774D84B56E08C24056FA96F27425C4060E12EB547C2AE086CC'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"

if ($pp['desktopshortcut']) {
	$desktopshortcut = (Join-Path ([System.Environment]::GetFolderPath("Desktop")) $shortcutName)
	Write-Host 'Adding ' $desktopshortcut
	Install-ChocolateyShortcut -ShortcutFilePath $desktopshortcut -TargetPath $exePath  -RunAsAdmin
}

if ($pp['startshortcut']) {
	$startshortcut = (Join-Path ([System.Environment]::GetFolderPath("Programs")) $shortcutName)
	Write-Host 'Adding ' $startshortcut
	Install-ChocolateyShortcut -ShortcutFilePath $startshortcut -TargetPath $exePath  -RunAsAdmin
}
