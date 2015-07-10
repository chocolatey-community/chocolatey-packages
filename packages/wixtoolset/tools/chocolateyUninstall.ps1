$packageName = 'wixtoolset'
$silentArgs = '/uninstall /quiet'

$osBitness = Get-ProcessorBits

# Remove not needed folder with binaries
if ($osBitness -eq 64) {
  $uninstallRegKey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{0f7c49f2-f5d2-4eaa-9de5-a274bdcbe6af}'
} else {
  $uninstallRegKey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{0f7c49f2-f5d2-4eaa-9de5-a274bdcbe6af}'
}

$uninstallPath = (Get-ItemProperty $uninstallRegKey).BundleCachePath

Start-ChocolateyProcessAsAdmin -exeToRun $uninstallPath -statements $silentArgs
