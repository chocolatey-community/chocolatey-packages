import-module au

$releases = 'https://www.python.org/downloads/windows/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"    = "`$1'$($Latest.FileType)'"
        }

      ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
      }
    }
}

function global:au_BeforeUpdate { rm tools\*.msi, tools\*.exe -ea 0; Get-RemoteFiles -Purge }

function GetStreams() {
  param($releaseUrls)
  $streams = @{ }

  $releaseUrls | % {
    $version = $_.InnerText.Trim() -split ' ' | select -Index 1
    #if ($version -match '[a-z]') { Write-Host "Skipping prerelease: '$version'"; return }
    $versionTwoPart = $version -replace '([\d]+\.[\d]+).*',"`$1"

    if ($streams.$versionTwoPart) { return }

    $download_page = Invoke-WebRequest -Uri "https://www.python.org$($_.href)" -UseBasicParsing

    $url32 = $download_page.links | ? href -match "python-.+.(exe|msi)$" | select -first 1 -expand href
    $url64 = $download_page.links | ? href -match "python-.+amd64\.(exe|msi)$" | select -first 1 -expand href
    if (!$url32 -or !$url64) {
        Write-Host "Skipping due to missing installer: '$version'"; return }

    if (!$url32.StartsWith('http')) {
        $url32 = 'https://www.python.org' + $url32
        $url64 = 'https://www.python.org' + $url64
    }
    $streams.$versionTwoPart = @{ URL32 = $url32 ; URL64 = $url64 ; Version = Get-Version $version }
  }

  Write-Host $streams.Count 'streams collected'
  $streams
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $releaseUrls = $download_page.links | ? { $_.href -match 'release' -and $_.InnerText -match "^Python 3\..+$" }

    @{ Streams = GetStreams $releaseUrls }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced by the virtual package python
    update -ChecksumFor none
}
