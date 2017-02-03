import-module au

$releases = 'http://windows.php.net/downloads/releases/archives/'

function global:au_BeforeUpdate {
  $Latest.ChecksumTS32 = Get-RemoteChecksum $Latest.URLTS32
  $Latest.ChecksumNTS32 = Get-RemoteChecksum $Latest.URLNTS32

  $lines = @(
    @('threadsafe'; $Latest.URLTS32; '' ; $Latest.ChecksumTS32; '') -join '|'
    @('not-threadsafe'; $Latest.URLNTS32; '' ; $Latest.ChecksumNTS32; '') -join '|'
  )

  [System.IO.File]::WriteAllLines("$PSScriptRoot\tools\downloadInfo.csv", $lines);
}

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"                        = "`$1'$($Latest.PackageName)'"
        }

        "php_5.3.x.nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re      = 'php-5\.3.+-nts.+\.zip$'
    $versionSort = { [version]($_ -split '-' | select -Index 1) }
    $url     = $download_page.links | ? href -match $re  | % href | sort $versionSort -Descending | select -First 1
    $urlTS   = $url -replace '\-nts',''
    $version = $url -split '-' | select -Index 1
    $majorVersion = $version -split '\.' | select -first 1
    $Result = @{
        Version      = $version
        URLNTS32     = "http://windows.php.net/" + $url
        URLTS32      = "http://windows.php.net/" + $urlTS
        ReleaseNotes = "https://secure.php.net/ChangeLog-${majorVersion}.php#${version}"
        PackageName  = 'php'
    }

    if ($Result.URLNTS32 -eq $Result.TS32) {
      throw "The threadsafe and non-threadsafe 32bit url is equal... This is not expected"
    }

    $Result
}

update -ChecksumFor none
