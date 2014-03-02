try {

  $name = "keepassx-langfiles"
  $scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  $fileFullPath = "$scriptPath\keepass_1.x_langfiles.zip"
  
  $keepasspath = "$env:ProgramFiles\KeePass Password Safe"
  $keepasspathx86 = "${env:ProgramFiles(x86)}\KeePass Password Safe"
  if (Test-Path "$keepasspath") {$destination = "$keepasspath"}
  if (Test-Path "$keepasspathx86") {$destination = "$keepasspathx86"}
  
  Get-ChocolateyUnzip $fileFullPath $destination

    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}