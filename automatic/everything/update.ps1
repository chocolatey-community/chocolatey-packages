import-module au

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
          "(?i)(checksum es.exe:).*"   = "`${1} $($Latest.ChecksumEsExe)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}
function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
    iwr 'https://www.voidtools.com/es.exe' -OutFile $PSScriptRoot\tools\es.exe
    $Latest.ChecksumEsExe = Get-FileHash $PSScriptRoot\tools\es.exe | % Hash
}
function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version       = $download_page.Content -split "`n" | sls ': Version .+' | select -First 1
    $version       = $version -split ' ' | select -Last 1
    $choco_version = $version.Replace('b', '') -replace '\.([^.]+)$', '$1'
    @{
        Version      = $choco_version
        URL32        = "https://www.voidtools.com/Everything-${version}.x86-Setup.exe"
        URL64        = "https://www.voidtools.com/Everything-${version}.x64-Setup.exe"
    }
}

update -ChecksumFor none
