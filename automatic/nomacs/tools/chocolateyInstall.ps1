$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as 32-bit, 64-bit and Win ≤ Vista link array due to limitations of Ketarin/chocopkgup
$urlsArray = {{DownloadUrlx64}}
$url = $urlsArray[0]
$url64bit = $urlsArray[1]
$urlVistaAndBefore = $urlsArray[2]

try {

  # If Windows 2000/XP, download matching version
  $winVersion = [System.Environment]::OSVersion.Version
  if ($winVersion -lt [Version]'6.1') {
    $url = $urlVistaAndBefore
    $url64bit = $urlVistaAndBefore
  }


  # Else download the version for Windows Vista/7/8 or later
  Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
