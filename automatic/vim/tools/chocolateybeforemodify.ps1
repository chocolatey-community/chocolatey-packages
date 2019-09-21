$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Get-Content -Path "$toolsDir\installDir"
$shortversion = '81'
try {
  # Is dlls locked?
  Remove-Item "$installDir\vim\vim$shortversion\GvimExt32\gvimext.dll", "$installDir\vim\vim$shortversion\GvimExt64\gvimext.dll" -ErrorAction Stop
} catch {
  # Restart explorer to unlock dlls
  Write-Debug 'Restarting explorer.'
  Get-Process explorer | Stop-Process -Force
}
