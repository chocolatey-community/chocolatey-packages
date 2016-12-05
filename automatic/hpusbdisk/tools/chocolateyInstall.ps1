$packageName = '{{PackageName}}'
$url = '{{DownloadUrl}}'

try {
  $scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
  $nodePath = Join-Path $scriptPath 'HPUSBDisk.exe'
  Get-ChocolateyWebFile "$packageName" "$nodePath" "$url"
  Install-ChocolateyPath "$nodePath" 'Machine' # Machine will assert administrative rights
  Install-ChocolateyDesktopLink "$nodePath"
  
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}