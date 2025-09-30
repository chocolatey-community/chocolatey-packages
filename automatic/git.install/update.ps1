Import-Module Chocolatey-AU

$domain = 'https://github.com'
$releases = "$domain/git-for-windows/git/releases/latest"

function global:au_BeforeUpdate {
  $releaseAssets = Get-GitHubRelease -Owner 'git-for-windows' -Name 'git' -Tag $Latest.TagName | ForEach-Object assets

  $Latest.URL64 = $releaseAssets | Where-Object name -match "Git-.+-64-bit.exe" | ForEach-Object browser_download_url

  if (!$Latest.URL64) {
    throw "64bit URL is missing"
  }

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]fileName64\s*=\s*)('.*')" = "`$1'$($Latest.FileName64)'"
        }

        ".\legal\verification.txt" = @{
            "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $tagUrl = $download_page.Links | Where-Object href -match 'releases/tag/.*windows' | Select-Object -First 1 -ExpandProperty href
    $tagName = $tagUrl -split '\/' | Select-Object -Last 1

    $re = 'v(?<version>[\d\.]+)\.windows\.(?<revision>[2-9])?'

    if ($tagName -match $re) {
      if ($Matches['revision']) {
        $version = "$($Matches['version']).$($Matches['revision'])"
      } else {
        $version = "$($Matches['version'])"
      }
    }

    @{
        Version = $version
        TagName = $tagName
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
