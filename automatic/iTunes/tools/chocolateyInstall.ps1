$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$url = '{{DownloadUrl}}'
$url64bit = '{{DownloadUrlx64}}'
$fileType = 'msi'
$silentArgs = '/qn /norestart'
$validExitCodes = @(0, 3010)

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$downloadTempDir = Join-Path $toolsDir 'download-temp'

$app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match 'iTunes'}

# Check if the same version of iTunes is already installed
if ($app -and ([version]$app.Version -ge [version]$version)) {
  Write-Host $(
    'iTunes ' + $version + ' or higher is already installed. ' +
    'No need to download and install again.'
  )
} else {

  Install-ChocolateyZipPackage -packageName $packageName -url $url `
    -url64bit $url64bit -unzipLocation $downloadTempDir

  $msiFilesList = (Get-ChildItem -Path $downloadTempDir -Filter '*.msi' | Where-Object {
    $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
  }).Name

  # Loop over each file and install it. iTunes requires all of them to be installed
  foreach ($msiFileName in $msiFilesList) {
    Install-ChocolateyInstallPackage -packageName $msiFileName -fileType $fileType `
      -silentArgs $silentArgs -file (Join-Path $downloadTempDir $msiFileName) `
      -validExitCodes $validExitCodes
  }

  Remove-Item $downloadTempDir -Recurse
}
