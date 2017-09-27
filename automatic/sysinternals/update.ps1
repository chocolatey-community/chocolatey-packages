import-module au

$releases = 'https://technet.microsoft.com/en-us/sysinternals/bb842062.aspx'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]packageArgs\.url\s*=\s*)('.*')" = "`$1'$($Latest.URLNano)'"
            "(?i)(^\s*[$]packageArgs\.checksum\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumNano)'"
        }
    }
}

function global:au_BeforeUpdate {
    Write-Host 'Setting checksum'
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
    $Latest.ChecksumType32 = 'sha256'
    $Latest.ChecksumNano = Get-RemoteChecksum $Latest.URLNano
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re      = '(?<!Nano)\.zip$'
    $url     = $download_page.links | ? href -match $re | select -First 1 -Expand href
    $urlNano = $download_page.links | ? href -match 'Nano\.zip$' | select -First 1 -Expand href

    # Previous version of this script extracted $updated from the html page content:
    # $updated = $download_page.Content -split "`n" | sls '(?<=Updated: )[^/<>]+' | % Matches | % Value
    # $updated = [datetime]::ParseExact($updated, 'MMMM dd, yyyy', [cultureinfo]::InstalledUICulture)
    #
    # But sometimes Microsoft publishes new versions of SysinternalsSuite.zip without changing html.
    # After PR #760 (https://github.com/chocolatey/chocolatey-coreteampackages/pull/760) $updated fills from 'Last-Modified' HTTP header.
    $lastModified = (Invoke-WebRequest -Uri $url -Method HEAD).Headers['Last-Modified'] -as [DateTime]
    $lastModifiedNano = (Invoke-WebRequest -Uri $urlNano -Method HEAD).Headers['Last-Modified'] -as [DateTime]
    $updated = If ($lastModified -gt $lastModifiedNano) {$lastModified} Else {$lastModifiedNano}

    @{
        Version  = $updated.ToString("yyyy.M.d")
        URL32    = $url
        URLNano  = $urlNano
    }
}

update -ChecksumFor none
