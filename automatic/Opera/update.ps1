import-module au

$releases = 'https://get.geo.opera.com/pub/opera/desktop/'

function global:au_BeforeUpdate {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(^\s*url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.Version)'"
        }
    }
}

function global:au_AfterUpdate { $env:ChocolateyForce = $null }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $versionSort = { [version]$_.href.TrimEnd('/') }
    $versionLink = $download_page.links | ? href -match '^[\d]+[\d\.]+\/$' | sort $versionSort | select -Last 1

    $version     = $versionLink.href -replace '/', ''

    $url32       = 'https://get.geo.opera.com/pub/opera/desktop/<version>/win/Opera_<version>_Setup.exe'
    $url64       = 'https://get.geo.opera.com/pub/opera/desktop/<version>/win/Opera_<version>_Setup_x64.exe'
    $url32       = $url32 -replace '<version>', $version
    $url64       = $url64 -replace '<version>', $version

    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update -ChecksumFor none
