import-module au

$releases = 'http://www.nirsoft.net/utils/nircmd.html'

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
    $download_page = Invoke-WebRequest -Uri $releases
    $download_page.RawContent -match 'NirCmd v(.+)' | Out-Null

    @{
      Version = $Matches[1]
      URL32 = 'http://www.nirsoft.net/utils/nircmd.zip'
      URL64 = 'http://www.nirsoft.net/utils/nircmd-x64.zip'
    }
}

update -ChecksumFor none
