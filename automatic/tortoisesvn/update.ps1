import-module au
import-module "$PSScriptRoot/../../extensions/extensions.psm1"

$releases = 'https://tortoisesvn.net/downloads.html'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -FileNameBase "TortoiseSVN" }

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]filePath32\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName32)`""
            "(^[$]filePath64\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName64)`""
        }
        ".\legal\verification.txt" = @{
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
        }
     }
}

function Get-ActualUrl([uri]$url) {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $url

  $path = $download_page.links | ? href -match 'redir.*\.msi$' | select -first 1 -expand href

  return $url.Scheme + "://" + $url.Host + $path
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

    #https://sourceforge.net/projects/tortoisesvn/files/1.9.5/Application/TortoiseSVN-1.9.5.27581-win32-svn-1.9.5.msi/download
    $re32  = "TortoiseSVN-(.*)-win32-svn-(.*).msi"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href

    #https://sourceforge.net/projects/tortoisesvn/files/1.9.5/Application/TortoiseSVN-1.9.5.27581-x64-svn-1.9.5.msi/download
    $re64  = "TortoiseSVN-(.*)-x64-svn-(.*).msi"
    $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -expand href

    $version32 = $url32 -split 'svn-|-win32' | Select-Object -Skip 2 -Last 1
    $version64 = $url64 -split 'svn-|-x64' | Select-Object -Skip 2 -Last 1

    if ($version32 -ne $version64) {
        throw "Different versions for 32-Bit and 64-Bit detected."
    }

    $result = @{
        URL32 = Get-ActualUrl $url32
        URL64 = Get-ActualUrl $url64
        Version = $version32
    }
    return $result
}

update -ChecksumFor none
