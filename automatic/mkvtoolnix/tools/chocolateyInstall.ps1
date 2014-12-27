try {

  # Note: fosshub uses special links that expire. The Get-FosshubLinks function
  # takes care of generating these links.

  $PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
  Import-Module (Join-Path $PSScriptRoot 'get-fosshublinks.ps1')

  $packageName = '{{PackageName}}'
  $fileType = 'exe'
  $fileArgs = '/S'

  # In case you see \{\{DownloadUrlx64\}\} (without backslashes)
  # after the commented lines, it’s intended.
  $genLinkUrlArray = {{DownloadUrlx64}}
  $url = Get-FosshubLinks $genLinkUrlArray[0]
  $url64 = Get-FosshubLinks $genLinkUrlArray[1]

  Install-ChocolateyPackage $packageName $fileType $fileArgs $url $url64

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
