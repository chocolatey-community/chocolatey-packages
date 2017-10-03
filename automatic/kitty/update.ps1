import-module au

$releases = 'https://www.fosshub.com/KiTTY.html'

function global:au_SearchReplace {
   @{ }
}

function global:au_BeforeUpdate {
    $ErrorActionPreference = 'stop'

    if (!(gcm curl.exe)) { cinst curl }
    mkdir $PSScriptRoot\tools -ea 0 | Out-Null

    $files = gc $PSScriptRoot\legal\VERIFICATION.txt | select -Skip 5
    foreach ($file in $files) {
        $file = $file -split ' '

        Write-Host "Downloading $($file[1]) from $($file[2])"
        $fpath = "$PSScriptRoot\tools\" + $file[1]
        rm $fpath -ea 0
        curl.exe --silent --show-error $file[2] -o $fpath
        if (!(Test-Path $fpath)) {throw "Can't download $($file[1]) from $($file[2])" }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $download_page.RawContent -match 'version: ([0-9.]+)' | Out-Null
    @{ Version = $Matches[1] }
}

update -NoCheckUrl -ChecksumFor none
