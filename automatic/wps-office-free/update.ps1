import-module au
 . ".\update_helper.ps1"

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]version\s*=\s*)('.*')"      = "`$1'$($Latest.Version)'"
      "(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
      "(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
      "(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
      "(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $streams = [ordered] @{
    wps = Get-JavaSiteUpdates -package "wps-office-free" -Title "WPS Office Free"
  }

  return @{ Streams = $streams }
}

update
