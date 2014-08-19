try {

  $name = "keepassx-langfiles"
  $scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  $fileFullPath = "$scriptPath\keepass_1.x_langfiles.zip"

  $keepasspath = "$env:ProgramFiles\KeePass Password Safe"
  $keepasspathx86 = "${env:ProgramFiles(x86)}\KeePass Password Safe"
  if (Test-Path "$keepasspath") {$destination = "$keepasspath"}
  if (Test-Path "$keepasspathx86") {$destination = "$keepasspathx86"}

  $extractPath = "$scriptPath\keepassx-langfiles"
  if (-not (Test-Path $extractPath)) {
    mkdir $extractPath
  }

  Get-ChocolateyUnzip $fileFullPath $extractPath
  Start-ChocolateyProcessAsAdmin "Copy-Item -Force '$extractPath\*.lng' '$destination'"

  Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}
