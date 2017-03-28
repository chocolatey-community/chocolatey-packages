$packageName = 'wixtoolset'
$silentArgs = '/uninstall /quiet'

$osBitness = Get-ProcessorBits


# Remove not needed folder with binaries
if ($osBitness -eq 64) {
  $uninstallRegKey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{96f2cba3-1b26-4e8c-8bef-eeae7259b99d}'
} else {
  $uninstallRegKey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{96f2cba3-1b26-4e8c-8bef-eeae7259b99d}'
}

$uninstallPath = (Get-ItemProperty $uninstallRegKey).BundleCachePath

Start-ChocolateyProcessAsAdmin -exeToRun $uninstallPath -statements $silentArgs
