import-module au

$releases = "https://github.com/vim/vim-win32-installer/releases/latest"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"\`$toolsDir\\)(.*)`""   = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"\`$toolsDir\\)(.*)`"" = "`${1}$($Latest.FileName64)`""
      "(?i)(^\`$shortversion\s*=\s*)('.*')"          = "`${1}'$($Latest.Shortversion)'"
    }
    ".\tools\chocolateyuninstall.ps1" = @{
      "(?i)(^\`$shortversion\s*=\s*)('.*')"          = "`${1}'$($Latest.Shortversion)'"
    }
    ".\tools\chocolateybeforemodify.ps1" = @{
      "(?i)(^\`$shortversion\s*=\s*)('.*')"          = "`${1}'$($Latest.Shortversion)'"
    }
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*32-Bit\: <)(.*)"    = "`${1}$($Latest.URL32)>"
      "(?i)(^\s*64-Bit\: <)(.*)"    = "`${1}$($Latest.URL64)>"
      "(?i)(^\s*checksum32\: )(.*)" = "`${1}$($Latest.Checksum32)"
      "(?i)(^\s*checksum64\: )(.*)" = "`${1}$($Latest.Checksum64)"
    }
  }
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -NoSuffix -Purge
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = 'x86\.zip$'
  $re64  = 'x64\.zip$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href
  $url64 = $download_page.links | ? href -match $re64 | select -First 1 -expand href
  $version  = $url -split '/' | Select-Object -Last 1 -Skip 1 | % { $_.Trim('v') }
  $shortversion = $version.Substring(0,1) + $version.Substring(2,1)

  @{
    URL32 = $url
    URL64 = $url64
    Version = $version
    Shortversion = $shortversion
  }
}

update -ChecksumFor none
