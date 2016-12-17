import-module au

$releases = 'https://technet.microsoft.com/en-us/sysinternals/bb842062.aspx'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }
    }
}

function global:au_BeforeUpdate {
    Write-Host 'Setting checksum'
    $Latest.Checksum64 = $Latest.Checksum32 = Get-RemoteChecksum $Latest.URL32
    $Latest.ChecksumType32 = $Latest.ChecksumType64 = 'sha256'
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases

    $re    = '(?<!Nano)\.zip$'
    $url   = $download_page.links | ? href -match $re | select -First 1 -Expand href

    $updated = $download_page.Content -split "`n" | sls '(?<=Updated: )[^/<>]+' | % Matches | % Value
    $updated = [datetime]::ParseExact($updated, 'MMMM dd, yyyy', [cultureinfo]::InstalledUICulture)
    @{
        Version  = $updated.ToString("yyyy.MM.dd")
        URL32    = $url
        URL64    = $url
    }
}

update -ChecksumFor none
