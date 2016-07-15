try {
  $packageName = '{{PackageName}}'
  $url = '{{DownloadUrl}}'
  $filePath = "$env:TEMP\winpcap"
  $fileFullPath = "$filePath\winpcapInstall.exe"

  if (!(Test-Path $filePath)) {
    New-Item -ItemType directory $filePath -Force
  }

  Get-ChocolateyWebFile $packageName $fileFullPath $url

  $ahkScript = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\winpcapInstall.ahk"

  Start-ChocolateyProcessAsAdmin $ahkScript 'AutoHotkey'

}   catch {
  Write-Output $packageName $($_.Exception.Message)
  throw
}
