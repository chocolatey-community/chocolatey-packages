$packageName = 'wixtoolset'
$silentArgs = '/uninstall /quiet'

$osBitness = Get-ProcessorBits

# Remove not needed folder with binaries
if ($osBitness -eq 64) {
  $uninstallRegKey = 'HKLM:SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\{229c8b18-b30c-409e-a47f-7d11c10aebb7}'
} else {
  $uninstallRegKey = 'HKLM:SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{229c8b18-b30c-409e-a47f-7d11c10aebb7}'
}

$uninstallPath = (Get-ItemProperty $uninstallRegKey).BundleCachePath

Start-ChocolateyProcessAsAdmin -exeToRun $uninstallPath -statements $silentArgs
