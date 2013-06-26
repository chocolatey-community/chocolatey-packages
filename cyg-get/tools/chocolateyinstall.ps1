
$toolsDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$contentDir = $($toolsDir | Split-Path | Join-Path -ChildPath "content")
$installer = join-path $contentDir 'CygwinInstaller.exe'

Get-ChocolateyWebFile 'cyg-get' $installer 'http://www.cygwin.com/setup.exe'

$path = Join-Path $(Split-Path -parent $(Split-Path -parent $MyInvocation.MyCommand.Definition)) 'content\cyg-get.ps1'

Install-ChocolateyPowershellCommand 'cyg-get' $path
