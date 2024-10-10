Import-Module Chocolatey-AU

$releases = 'https://www.videosoftdev.com/free-video-editor/download'

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
  Remove-Item "tools\$($Latest.FileName32)"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType64)"
      "(?i)(^\s*checksum64\:).*" = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"                = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"           = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksumType\s*=\s*)('.*')"       = "`$1'$($Latest.ChecksumType32)'"
      "(?i)(^\s*file64\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName64)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $version = $download_page.Content -split '\n' | Select-String 'Current version:' -Context 0,5 | out-string
  $version = $version -split '<|>' | Where-Object { [version]::TryParse($_, [ref]($__)) } | Select-Object -First 1

  if ($version -match "^\d+\.\d+$") {
    $version = "${version}.0"
  }

  @{
      Version = $version
      URL32   = Get-RedirectedUrl 'https://www.videosoftdev.com/services/download.aspx?ProductID=x32_1'
      URL64   = Get-RedirectedUrl 'https://www.videosoftdev.com/services/download.aspx?ProductID=1'
  }
}

update -ChecksumFor none
