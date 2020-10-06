import-module au

$releases = 'http://windows.php.net/downloads/releases/'
# Change the release url above with this one when
# version 5.5.x is only available from the archive section
# Fallback to the archive version in ./tools/chocolateyInstall.ps1
# can also be removed then
#$releases = 'http://windows.php.net/downloads/releases/archives/'

function global:au_BeforeUpdate {
  $Latest.ChecksumTS32 = Get-RemoteChecksum $Latest.URLTS32
  $Latest.ChecksumTS64 = Get-RemoteChecksum $Latest.URLTS64
  $Latest.ChecksumNTS32 = Get-RemoteChecksum $Latest.URLNTS32
  $Latest.ChecksumNTS64 = Get-RemoteChecksum $Latest.URLNTS64

  $lines = @(
    @('threadsafe'; $Latest.URLTS32; $Latest.URLTS64; $Latest.ChecksumTS32; $Latest.ChecksumTS64) -join '|'
    @('not-threadsafe'; $Latest.URLNTS32; $Latest.URLNTS64; $Latest.ChecksumNTS32; $Latest.ChecksumNTS64) -join '|'
  )

  [System.IO.File]::WriteAllLines("$PSScriptRoot\tools\downloadInfo.csv", $lines);
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"                        = "`$1'$($Latest.PackageName)'"
        }

        "php_5.5.x.nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = 'php-5\.5.+-nts.+\.zip$'
    $versionSort = { [version]($_ -split '-' | select -Index 1) }
    $url     = $download_page.links | ? href -match $re  | % href | sort $versionSort -Descending | select -First 2
    $urlTS   = $url | % { $_ -replace '\-nts','' }
    $version = $url[0] -split '-' | select -Index 1
    $majorVersion = $version -split '\.' | select -first 1
    $Result = @{
        Version      = $version
        URLNTS32     = "http://windows.php.net/" + ($url -match 'x86' | select -First 1)
        URLNTS64     = "http://windows.php.net/" + ($url -match 'x64' | select -First 1)
        URLTS32      = "http://windows.php.net/" + ($urlTS -match 'x86' | select -First 1)
        URLTS64      = "http://windows.php.net/" + ($urlTS -match 'x64' | select -First 1)
        ReleaseNotes = "https://secure.php.net/ChangeLog-${majorVersion}.php#${version}"
        PackageName  = 'php'
    }

    if ($Result.URLNTS32 -eq $Result.TS32) {
      throw "The threadsafe and non-threadsafe 32bit url is equal... This is not expected"
    }

    if ($Result.URLNTS64 -eq $Result.TS64) {
      throw "The threadsafe and non-threadsafe 64bit url is equal... This is not expected"
    }

    $Result
}

update -ChecksumFor none
