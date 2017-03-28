$ErrorActionPreference = 'Stop';

$programsDir = [System.Environment]::GetFolderPath('Programs')
$lnk = "$programsDir\KeePassX.lnk"
if (Test-Path $lnk) {
  Remove-Item -Force $lnk
}
