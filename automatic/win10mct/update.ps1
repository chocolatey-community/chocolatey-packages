import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"
 . "$PSScriptRoot\..\win10mct\update_helper.ps1"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"          = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"     = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'" = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_AfterUpdate {
  "$($Latest.ETAG)|$($Latest.Version)" | Out-File "$PSScriptRoot\info" -Encoding utf8
}

function global:au_GetLatest {
  $url32 = Get-RedirectedUrl 'https://go.microsoft.com/fwlink/?LinkId=691209'
  $etag = GetETagIfChanged $url32
  if ($etag) {
    $result = GetResultInformation $url32
    $result["ETAG"] = $etag
  }
  else {
    $result = @{
      URL32   = $url32
      Version = Get-Content "$PSScriptRoot\info" -Encoding UTF8 | select -First 1 | % { $_ -split '\|' } | select -Last 1
    }
  }

  return $result
}

    update -ChecksumFor none
