#Install-ChocolateyPackage 'skype' 'exe' '/SILENT /nogoogle /noie /nodesktopicon' 'http://download.skype.com/3694814915aaa38100bfa0933f948e65/partner/59/SkypeSetup.exe'
#Install-ChocolateyPackage 'skype' 'exe' '/SILENT /nogoogle /noie /nodesktopicon' 'https://download.skype.com/msi/SkypeSetup_7.39.0.102.msi'
#Install-ChocolateyPackage 'skype' 'exe' '/SILENT /nogoogle /noie /nodesktopicon' 'http://download.skype.com/SkypeSetupFull.exe'


function isInstalled() {
  return Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match 'Skype\u2122 [\d\.]+$'}
}

$packageName = 'skype'
$fileType = 'msi'
# http://community.skype.com/t5/Windows-archive/Unattended-install/td-p/184628s
$silentArgs = '/qn /norestart STARTSKYPE=FALSE TRANSFORMS=:RemoveDesktopShortcut.mst TRANSFORMS=:RemoveStartup.mst'

$url = 'https://download.skype.com/msi/SkypeSetup_7.41.0.101.msi'
$checksum = 'c7c5499bc1e3663c98fac492b066610c218722e83f9807328c5c4d06607027b2'
$checksumType = 'SHA256'

try {

  $appInstalled = isInstalled

  if ($appInstalled) {
      # If Skype (in any version) is already installed on the computer, remove it first, otherwise the
      # installation of Skype will fail with an error.
      $msiArgs = $('/x' + $appInstalled.IdentifyingNumber + ' ' + $silentArgs)
      Write-Host "Uninstalling previous version of Skype, otherwise installing the new version won’t work."
      Start-ChocolateyProcessAsAdmin $msiArgs 'msiexec'

      # This loop checks every 5 seconds if Skype is already uninstalled.
      # Then it proceeds with the download and installation of the Skype
      # version specified in the package.
      do {
        Start-Sleep -Seconds 5
        $i += 1

        # Break if too much time passed
        if ($i -gt 12) {
          Write-Error 'Could not uninstall the previous version of Skype.'
          break
        }

      } until (-not (isInstalled))
  }

  Install-ChocolateyPackage $packageName $fileType $silentArgs $url

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}

