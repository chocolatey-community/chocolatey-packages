import-module au

$releases = 'https://github.com/protocolbuffers/protobuf/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*FileFullPath\s*=\s*`"[$]toolsDir\\).*"   = "`$1$($Latest.FileName32)`""
            "(?i)(^\s*FileFullPath64\s*=\s*`"[$]toolsDir\\).*" = "`$1$($Latest.FileName64)`""
        }
        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
        ".\legal\VERIFICATION.txt" = @{
            "(?i)(32-bit zip file:\s+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-bit zip file:\s+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*"       = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum32:\s+).*"          = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*"          = "`${1}$($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {


    $download_page = Invoke-WebRequest -Uri "$releases" -UseBasicParsing
    $url32 = $download_page.links | ? href -match '/protoc-(.+)-win32\.zip$' | % href | select -First 1
    $url64 = $download_page.links | ? href -match '/protoc-(.+)-win64\.zip$' | % href | select -First 1

    $version = $Matches[1]

    @{
        URL32   = "https://github.com/$url32"
        URL64   = "https://github.com/$url64"
        Version = $version
        ReleaseNotes = "${releases}/tag/v${version}"
    }
}

update -ChecksumFor none
