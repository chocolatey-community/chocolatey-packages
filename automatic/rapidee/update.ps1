import-module au

$releases = 'https://www.rapidee.com/en/download'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = $download_page.Content -split "`n" | sls 'Latest version' -Context 0,1
    $version = $version -split "<|>" | ? { $_ -match 'build' }
    $version = $version -replace ' build ', '.'
    @{
        Version      = $version.Trim()
        URL32        = 'https://www.rapidee.com/download/RapidEE.zip'
        URL64        = 'https://www.rapidee.com/download/RapidEEx64.zip'
    }
}

update -ChecksumFor none
