Import-Module Chocolatey-AU

$domain = 'https://github.com'
$releases = "$domain/git-for-windows/git/releases/latest"

function global:au_BeforeUpdate {
  $releaseAssets = Get-GitHubRelease -Owner 'git-for-windows' -Name 'git' -Tag $Latest.TagName | ForEach-Object assets

  $Latest.URL32 = $releaseAssets | Where-Object name -match "Git-.+-32-bit.exe" | ForEach-Object browser_download_url
  $Latest.URL64 = $releaseAssets | Where-Object name -match "Git-.+-64-bit.exe" | ForEach-Object browser_download_url

  if (!$Latest.URL32 -or !$Latest.URL64) {
    throw "64bit or 32bit URL is missing"
  }

  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]fileName32\s*=\s*)('.*')" = "`$1'$($Latest.FileName32)'"
            "(^[$]fileName64\s*=\s*)('.*')" = "`$1'$($Latest.FileName64)'"
        }

        ".\legal\verification.txt" = @{
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $tagUrl = $download_page.Links | Where-Object href -match 'releases/tag/.*windows' | Select-Object -First 1 -ExpandProperty href
    $tagName = $tagUrl -split '\/' | Select-Object -Last 1

    $version = $tagName -split '^v|\.windows' | Select-Object -Last 1 -Skip 1

    @{
        Version = $version
        TagName = $tagName
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
