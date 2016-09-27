$packageName = 'compact-timer'
$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)

Install-ChocolateyDesktopLink "$scriptDir\CompactTimer.exe"
