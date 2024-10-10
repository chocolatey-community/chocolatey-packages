﻿
Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  if ($Latest.Title -like '*essential*') {
    Copy-Item "$PSScriptRoot\README_tse.md" "$PSScriptRoot\README.md" -Force
  } else {
    Copy-Item "$PSScriptRoot\README_ts.md" "$PSScriptRoot\README.md" -Force
  }
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
      "(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.Title)'"
    }
    ".\360ts.nuspec" = @{
      "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
    }
  }
}

function Get360Version {
  param(
    [string]$releases,
    [string]$PackageName,
    [string]$Title
  )

  $regex = '(\d+\.\d+\.\d+\.\d+)|( Beta)'
  $HTML = Invoke-WebRequest -UseBasicParsing -Uri $releases
  ( $HTML | ForEach-Object { ($_ -match $regex )} ) | Select-Object -First 2 | Out-Null
  $version = $Matches[0];
  if ( $Matches[2] -ne $null ) {
    $version = $version + $Matches[2]
    $version -replace('','_')
  }

  $url = "https://free.360totalsecurity.com/totalsecurity/${PackageName}_Setup_${version}.exe"

  @{
    PackageName = $PackageName.ToLower()
    Title = $Title
    Version = $version -replace('_','-')
    URL32   = $url
  }
}

$360_ts_url = 'https://www.360totalsecurity.com/en/version/360-total-security/'
$360_tse_url = 'https://www.360totalsecurity.com/en/version/360-total-security-essential/'

function global:au_GetLatest {
  $streams = [ordered] @{
    #tse = Get360Version -releases $360_tse_URL -PackageName "360TSE" -Title "360 Total Security Essential" # Software removed from website, kept here as a historic reference
    ts = Get360Version -releases $360_ts_URL -PackageName "360TS" -Title "360 Total Security"
  }

  return @{ Streams = $streams }
}

update -ChecksumFor 32
