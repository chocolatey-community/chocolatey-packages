Import-Module Chocolatey-AU

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "^(?i)(\s*Url\s*=\s*)'.*'"            = "`$1'$($Latest.URL32)'"
      "^(?i)(\s*Checksum\s*=\s*)'.*'"       = "`$1'$($Latest.Checksum32)'"
      "^(?i)(\s*ChecksumType\s*=\s*)'.*'"   = "`$1'$($Latest.ChecksumType32)'"
      "^(?i)(\s*Url64\s*=\s*)'.*'"          = "`$1'$($Latest.URL64)'"
      "^(?i)(\s*Checksum64\s*=\s*)'.*'"     = "`$1'$($Latest.Checksum64)'"
      "^(?i)(\s*ChecksumType64\s*=\s*)'.*'" = "`$1'$($Latest.ChecksumType64)'"
    }
  }
}

function Get-RemoteChecksumFast([string] $Url, $Algorithm = 'sha256', $Headers) {
  $ProgressPreference = 'SilentlyContinue'
  & (Get-Command -Name Get-RemoteChecksum).ScriptBlock.GetNewClosure() @PSBoundParameters
}

function global:au_GetLatest {
  $downloadId = 26347
  $softwareVersionString = '8.0.50727.6195'
  $packageRevisionString = '01'
  $packageVersion = [version]"${softwareVersionString}${packageRevisionString}"

  $confirmationPageUrl = "https://www.microsoft.com/en-us/download/confirmation.aspx?id=${downloadId}"
  $confirmationPage = Invoke-WebRequest -UseBasicParsing -Uri $confirmationPageUrl
  $url32 = $confirmationPage.Links | Where-Object href -like '*/vcredist_x86.exe' | Select-Object -ExpandProperty href -Unique
  $url64 = $confirmationPage.Links | Where-Object href -like '*/vcredist_x64.exe' | Select-Object -ExpandProperty href -Unique

  $checksumType = 'sha256'

  return @{
    URL32          = $url32
    URL64          = $url64
    Version        = $packageVersion
    Checksum32     = Get-RemoteChecksumFast -Url $url32 -Algorithm $checksumType
    ChecksumType32 = $checksumType
    Checksum64     = Get-RemoteChecksumFast -Url $url64 -Algorithm $checksumType
    ChecksumType64 = $checksumType
  }
}

update -ChecksumFor none
