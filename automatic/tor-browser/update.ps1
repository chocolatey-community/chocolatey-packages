import-module au

$releases = "https://www.torproject.org/download/download-easy.html.en"

function global:au_SearchReplace {
    @{
        "tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    #https://www.torproject.org/dist/torbrowser/6.0.8/torbrowser-install-6.0.8_en-US.exe
    $re  = "torbrowser-install-.+_en-US.exe"
    $url = $download_page.links | Where-Object href -match $re | Select-Object -First 1 -expand href

    $url32 = "https://www.torproject.org" + $url.trimStart("..")

    $filenameVersionPart = $url -split '-' | Select-Object -Skip 1 -Last 1
    $version = $filenameVersionPart.trimEnd("_en")

    $filename = $url -split '/' | Select-Object -Last 1

    return @{ URL32 = $url32; Version = $version; FileName = $filename }
}

update