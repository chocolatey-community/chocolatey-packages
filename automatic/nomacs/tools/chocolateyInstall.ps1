$packageName = '{{PackageName}}'
$fileType = 'exe'
$silentArgs = '/S'
# {\{DownloadUrlx64}\} gets “misused” here as 32- and 64-bit link array due to limitations of Ketarin/chocopkgup
$urlsArray = {{DownloadUrlx64}}
$urlOldOs = 'http://sourceforge.net/projects/nomacs/files/nomacs-2.4.0/nomacs-setup-2.4.0-WinXP-x86.exe/download'
$url = $urlsArray[0]
$url64bit = $urlsArray[1]

try {

  # If Windows 2000/XP, download matching version
  $winVersion = [System.Environment]::OSVersion.Version
  if ($winVersion -lt [Version]'6.1') {
    Write-Host $(
        'You have Windows 2000, XP or Vista. ' +
        'There is no newer version than Nomacs 2.4.0 available for these operating systems.'
    )
    $url = $urlOldOs
    $url64bit =$urlOldOs
  }


  # Else download the version for Windows Vista/7/8 or later
  Install-ChocolateyPackage $packageName $fileType $silentArgs $url $url64bit

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
