$packageName = '{{PackageName}}'
$installerType = 'MSI'
$32BitUrl  = '{{DownloadUrl}}'
$64BitUrl  = '{{DownloadUrlx64}}'
$silentArgs = '/quiet'
$validExitCodes = @(0)

$alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {
  $_.Name -eq "SmartFTP Client" -and
  $_.Version -eq $version
}

try {
  if ($alreadyInstalled) {
    Write-Output $('SmartFTP ' +
      $version + ' is already installed.')
  } else {
    Install-ChocolateyPackage $packageName $installerType $silentArgs $32BitUrl $64BitUrl -validExitCodes $validExitCodes
  }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
