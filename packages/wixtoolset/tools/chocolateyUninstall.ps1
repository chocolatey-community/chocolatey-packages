$packageName = 'wixtoolset'
$silentArgs = '/uninstall /quiet'

$osBitness = Get-ProcessorBits

# Remove not needed folder with binaries
if ($osBitness -eq 64) {
  $uninstallRegKey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{d2ff2571-07c4-4a04-bcae-f53edb36d960}'
} else {
  $uninstallRegKey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{d2ff2571-07c4-4a04-bcae-f53edb36d960}'
}

$uninstallPath = (Get-ItemProperty $uninstallRegKey).BundleCachePath

Start-ChocolateyProcessAsAdmin -exeToRun $uninstallPath -statements $silentArgs
