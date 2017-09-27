import-module au

$domain = 'https://github.com'
$releases = "$domain/git-for-windows/git/releases/latest"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }
function global:au_SearchReplace {
    @{
        ".\legal\verification.txt" = @{
            "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    #https://github.com/git-for-windows/git/releases/download/v2.11.0.windows.1/PortableGit-2.11.0-32-bit.7z.exe
    $re32  = "PortableGit-.+-32-bit.7z.exe"
    $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href | % { $domain + $_ }

    #https://github.com/git-for-windows/git/releases/download/v2.11.0.windows.1/PortableGit-2.11.0-64-bit.7z.exe
    $re64  = "PortableGit-.+-64-bit.7z.exe"
    $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -expand href | % { $domain + $_ }

    $version32 = $url32 -split '-' | Select-Object -Skip 2 -Last 1
    $version64 = $url64 -split '-' | Select-Object -Skip 2 -Last 1
    if ($version32 -ne $version64) {  throw "Different versions for 32-Bit and 64-Bit detected." }

    @{
        Version = $version32
        URL32   = $url32
        URL64   = $url64
    }
}

if ($MyInvocation.InvocationName -ne '.') { # run the update only if script is not sourced
    update -ChecksumFor none
}
