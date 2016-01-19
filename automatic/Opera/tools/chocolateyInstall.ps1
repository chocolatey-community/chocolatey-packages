$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$fileType = 'exe'
$installArgs = '/install /silent /launchopera 0 /setdefaultbrowser 0'
$url = '{{DownloadUrl}}'

$regPathModifierArray = @('Wow6432Node\', '')
$alreadyInstalled = $null

foreach ($regPathModifier in $regPathModifierArray) {
  $regPath = "HKLM:\SOFTWARE\${regPathModifier}Microsoft\Windows\CurrentVersion\Uninstall\Opera $version"
  if (Test-Path $regPath) {
    $alreadyInstalled = $true
  }
}

if ($alreadyInstalled) {
  Write-Output "Opera $version is already installed. Skipping download and installation."
} else {
  Install-ChocolateyPackage $packageName $fileType $installArgs $url
}
