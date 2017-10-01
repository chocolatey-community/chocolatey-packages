import-module au

$releases = 'https://get.geo.opera.com/pub/opera/desktop/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(^\s*url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
            "(^[$]version\s*=\s*)('.*')"    = "`$1'$($Latest.Version)'"
        }
        ".\opera.nuspec" = @{
          "(?i)(^\s*\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`${2}"
        }
    }
}

function global:au_BeforeUpdate {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
    $Latest.Checksum64 = Get-RemoteChecksum $Latest.URL64
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $versionSort = { [version]$_.href.TrimEnd('/') }
    $versionLink = $download_page.links | ? href -match '^[\d]+[\d\.]+\/$' | sort $versionSort | select -Last 1

    [version] $version = $versionLink.href -replace '/', ''

    $url = "https://get.geo.opera.com/pub/opera/desktop/$version/win/"
    try {
      $download_page = Invoke-WebRequest -Uri $url -UseBasicParsing
    } catch {
        if ($_ -match 'not found') { Write-Host 'Windows version can not be found'; return 'ignore'}
        throw $_
    }

    $url32 = $download_page.Links | ? href -NotMatch 'x64' | ? href -Match 'Setup\.exe$' | select -First 1 -expand href | % { $url + $_ }
    $url64 = $download_page.Links | ? href -Match "(x64.*Setup|Setup_x64)\.exe$" | select -First 1 -expand href | % { $url + $_ }

    if (!$url32 -or !$url64) {
      throw "32bit or 64bit url was not found, investigate or ignore."
    }

    return @{
      URL32 = $url32
      URL64 = $url64
      Version = $version
      PackageName = 'Opera'
      ReleaseNotes = "https://blogs.opera.com/desktop/changelog-for-$($version.Major)/#b$($version.Build).$($version.Revision)"
    }
}

update -ChecksumFor none
