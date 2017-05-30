if(!$PSScriptRoot){ $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent }
$optionsFile = (Join-Path $PSScriptRoot 'options.xml')
 
if (!(Test-Path $optionsFile)) {
  throw "Install options file missing. Could not uninstall."
}
 
$options = Import-CliXml -Path $optionsFile
$unzipLocation = $options['unzipLocation']
$serviceName = $options['serviceName']
$apacheHome = Join-Path $unzipLocation "Apache24";

Write-Debug "Uninstalling $apacheHome"
 
$service = Get-Service | ? Name -eq $serviceName
if ($service -ne $null) {
  Stop-Service $service
}
 
$binPath = Join-Path $apacheHome 'bin'
Write-Debug "Uninstalling Service $binPath : $serviceName"
if (Test-Path $binPath) {
  Push-Location $binPath
  Start-ChocolateyProcessAsAdmin ".\httpd.exe -k uninstall -n '$($serviceName)'"
  Pop-Location
}
 
Remove-Item $unzipLocation -Recurse -Force
