import-module au

$releases = "https://dist.nuget.org/tools.json"

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s*download the.*)<.*>" = "`$1<$($Latest.URL32)>"
          "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
          "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
        }
   }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $json = Invoke-WebRequest -UseBasicParsing -Uri $releases | ConvertFrom-Json

    $latestVersion = $json."nuget.exe" | Sort-Object uploaded -Descending | Select-Object -First 1

    @{
        Version = $latestVersion.version
        Url32   = $latestVersion.url
    }
}

update -ChecksumFor none
