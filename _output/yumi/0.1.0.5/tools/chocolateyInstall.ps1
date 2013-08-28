try {

  $packageName = 'yumi'
  $fileFullPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\yumi.exe"
  Install-ChocolateyDesktopLink $fileFullPath

  Write-ChocolateySuccess $packageName
} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw 
}
