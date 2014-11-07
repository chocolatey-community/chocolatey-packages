$packageName = 'wixtoolset'
$silentArgs = '/uninstall /quiet'

$osBitness = Get-ProcessorBits

# Remove not needed folder with binaries
if ($osBitness -eq 64) {
  $uninstallRegKey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{3d1f6355-a0b0-49a1-b977-43cdbe771169}'
} else {
  $uninstallRegKey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{3d1f6355-a0b0-49a1-b977-43cdbe771169}'
}

$uninstallPath = (Get-ItemProperty $uninstallRegKey).BundleCachePath

Start-ChocolateyProcessAsAdmin -exeToRun $uninstallPath -statements $silentArgs