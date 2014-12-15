$packageName = 'wesnoth'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = 'http://sourceforge.net/projects/wesnoth/files//wesnoth-1.12/wesnoth-1.12/wesnoth-1.12-win32.exe/download'

Install-ChocolateyPackage $packageName $fileType $silentArgs $url
