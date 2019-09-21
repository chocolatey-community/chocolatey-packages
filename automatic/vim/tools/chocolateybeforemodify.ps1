$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortversion = '81'
try {
  # Is dlls locked?
  Remove-Item "$toolsDir\vim\vim$shortversion\GvimExt32\gvimext.dll", "$toolsDir\vim\vim$shortversion\GvimExt64\gvimext.dll" -ErrorAction Stop
} catch {
  # Restart explorer to unlock dlls
  Write-Debug 'Restarting explorer.'
  Get-Process explorer | Stop-Process -Force
}
