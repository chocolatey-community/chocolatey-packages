Import-Module AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        'legal\VERIFICATION.txt' = @{
            "(?i)(url:.+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum:\s+).*"      = "`${1}$($Latest.Checksum32)"
        }
    }
}

function global:au_GetLatest {
    $latestPage = Invoke-WebRequest -Uri 'https://github.com/gitextensions/gitextensions/releases/latest' -UseBasicParsing

    # e.g. https://github.com/gitextensions/gitextensions/releases/download/v2.51.01/GitExtensions-2.51.01-Setup.msi
    $re = 'GitExtensions-(.+)\.msi'
    $url = "https://github.com$($latestPage.links | Where-Object href -match $re | Select-Object -First 1 -expand href)"
    $version = $matches[1]

    @{
        Version = $version
        URL32   = $url
    }
}

Update-Package -ChecksumFor none
