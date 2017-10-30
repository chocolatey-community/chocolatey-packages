import-module au

$releases = 'http://windows.php.net/download'

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

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
            "(\<dependency .+?`")vcredist[^`"]+`"( version=`"[^`"]+`")?" = "`$1$($Latest.Dependency)`""
        }
    }
}

function Get-Dependency() {
  param($url)

  $dep = $url -split '\-' | select -last 1 -skip 1

  @{
    'vc14' = 'vcredist140'
    'vc11' = 'vcredist2012'
  }.GetEnumerator() | ? Key -eq $dep | select -first 1 -expand Value
}

function CreateStream {
  param([uri]$url32Bit, [uri]$url64bit, [version]$version)

  $Result = @{
    Version = $version
    URLNTS32 = 'http://windows.php.net' + $url32bit
    URLNTS64 = 'http://windows.php.net' + $url64bit
    URLTS32  = 'http://windows.php.net' + ($url32bit | % { $_ -replace '\-nts','' })
    URLTS64 = 'http://windows.php.net' + ($url64bit | % { $_ -replace '\-nts','' })
    ReleaseNotes = "https://secure.php.net/ChangeLog-$($version.Major).php#${version}"
    Dependency = Get-Dependency $url32Bit
  }

  if ($Result.URLNTS32 -eq $Result.TS32) {
    throw "The threadsafe and non-threadsafe 32bit url is equal... This is not expected"
  }

  if ($Result.URLNTS64 -eq $Result.TS64) {
    throw "The threadsafe and non-threadsafe 64bit url is equal... This is not expected"
  }

  return $Result
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $url32Bits = $download_page.links | ? href -match 'nts.*x86\.zip$' | ? href -notmatch 'debug' | select -expand href
    $url64Bits = $download_page.links | ? href -match 'nts.*x64\.zip$' | ? href -notmatch 'debug' | select -expand href

    $streams = @{ }

    $url32Bits | sort | % {
      $version = $_ -split '-' | select -first 1 -Skip 1
      $url64Bit = $url64Bits | ? { $_ -split '-' | select -first 1 -skip 1 | ? { $_ -eq $version } }

      $streams.Add((Get-Version $version).ToString(2), (CreateStream $_ $url64Bit $version))

    } | Out-Null

    return @{ Streams = $streams }
}

update -ChecksumFor none
