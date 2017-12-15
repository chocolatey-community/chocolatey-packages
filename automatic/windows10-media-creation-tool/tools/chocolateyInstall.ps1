$PackageName = 'windows10-media-creation-tool'
$exeName = "MediaCreationTool.exe"
$url = 'http://go.microsoft.com/fwlink/?LinkId=691209'
$validExitCodes = @(0)

Get-ChocolateyWebFile -packagename "$packageName" -url "$url" -filefullpath "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\$exeName" -GetOriginalFileName

$AppPathKey = "Registry::HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\$exeName"
If (!(Test-Path $AppPathKey)) {New-Item "$AppPathKey" | Out-Null}
Set-ItemProperty -Path $AppPathKey -Name "(Default)" -Value "$env:chocolateyinstall\lib\$packagename\tools\$exeName" -Force
Set-ItemProperty -Path $AppPathKey -Name "Path" -Value "$env:chocolateyinstall\lib\$packagename\tools\" -Force

Write-Output "******************************************************************************************************************"
Write-Output "*  INSTRUCTIONS: In a prompt type `"$exeName`" to start the Windows 10 Media Creation Tool.           *"
Write-Output "*  You may also type `"$exeName`" in the search prompt of your start menu                             *"
Write-Output "******************************************************************************************************************"
