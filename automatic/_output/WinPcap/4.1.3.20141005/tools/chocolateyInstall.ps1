try {
  $packageName = 'WinPcap'
  $url = 'http://www.winpcap.org/install/bin/WinPcap_4_1_3.exe'
  $filePath = "$env:TEMP\chocolatey\winpcap"
  $fileFullPath = "$filePath\winpcapInstall.exe"

  if (!(Test-Path $filePath)) {
    New-Item -ItemType directory $filePath -Force
  }

  Get-ChocolateyWebFile $packageName $fileFullPath $url

  $ahkScript = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\winpcapInstall.ahk"

  Start-ChocolateyProcessAsAdmin $ahkScript 'AutoHotkey'

}   catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw
}
