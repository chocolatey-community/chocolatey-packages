$packageName = '{{PackageName}}'
$zipFile = 'rukerneltool.zip'
$zipFilePath = Join-Path $env:TEMP $zipFile
$url = 'http://rukerneltool.rainerullrich.de/download2/ruKernelTool.zip'

$oldDestinationFolder = Join-Path $env:SystemDrive 'ruKernelTool'

$binRoot = Get-BinRoot
$destinationFolder = Join-Path $binRoot 'ruKernelTool'

if ((Test-Path $oldDestinationFolder) -and ($oldDestinationFolder -ne $destinationFolder)) {

$destinationFolder = $oldDestinationFolder

Write-Output @"
Warning: Deprecated installation folder detected: %SystemDrive%\ruKernelTool.
This package will continue to install {{PackageName}} there unless you remove the deprecated installation folder.
After you did that, reinstall this package again with the “-force” parameter. Then it will use %ChocolateyBinRoot%\ruKernelTool.
"@
}

$username = 'ruKernelTool2'
$password = 'Bommelchen_2010'

$webClient = New-Object System.Net.WebClient
$webClient.Credentials = New-Object System.Net.Networkcredential($username, $password)
Write-Output $('Downloading' + $url + '…')
$webClient.DownloadFile($url, $zipFilePath)

Get-ChocolateyUnzip $zipFilePath $destinationFolder
Remove-Item $zipFilePath
