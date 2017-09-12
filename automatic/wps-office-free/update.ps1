import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.wps.com/office-free'

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]version\s*=\s*)('.*')"= "`$1'$($Latest.Version)'"
      "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
      "(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases
  $url = ( $download_page.ParsedHtml.getElementsByTagName('a') | Where { $_.className -match 'major transition_color ga-download-2016-free'} ).href
  $search = 'innerHTML'
  $cpt = 1
  $resu = @{};
  $match = '(?:Version:)[\d\.]{4,}'
  $match_1 = '([WPS]{3}\s[a-zA-Z]{1,}\s\d+\s[Free]{4})'
  $replace = 'Version:'
  $download_page.ParsedHtml.getElementsByTagname("a") | % {
    if ($_.id -eq $null) {
      $_.id="p$cpt";$cpt++
    }
    $resu[$($_.id)]=$_.$search

    if ($_.$search -match($match)) {
      $version= $_.$search
    }
  }

  $version = $version -match($match);$version = $matches[0]
  $version = $version -replace($replace)

  return @{
    URL32 = $url
    Version = Get-PaddedVersion $version
  }
}

update
