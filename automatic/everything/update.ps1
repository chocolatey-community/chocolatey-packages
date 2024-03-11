Import-Module Chocolatey-AU

$releases = 'https://www.voidtools.com/Changes.txt'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}
function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version       = $download_page.Content -split "`n" | Select-String ': Version .+' | Select-Object -First 1
    $version       = ($version -split ' ' | Select-Object -Last 1).Trim()
    $choco_version = $version.Replace('b', '') -replace '\.([^.]+)$', '$1'
    @{
        Version      = $choco_version
        URL32        = "https://www.voidtools.com/Everything-${version}.x86-Setup.exe"
        URL64        = "https://www.voidtools.com/Everything-${version}.x64-Setup.exe"
        PackageName  = 'Everything'
    }
}

update -ChecksumFor none
