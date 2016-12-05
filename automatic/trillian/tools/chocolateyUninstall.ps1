$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = ''
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {

$psFile = Join-Path "$(Split-Path -parent $MyInvocation.MyCommand.Definition)" 'uninstallscript.ps1'
Start-ChocolateyProcessAsAdmin "& `'$psFile`'"

  # the following is all part of error handling
  Write-ChocolateySuccess "$packageName"
} catch {
  Write-ChocolateyFailure "$packageName" "$($_.Exception.Message)"
  throw 
}
