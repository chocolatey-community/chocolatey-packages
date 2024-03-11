Import-Module Chocolatey-AU

$releases = 'https://www.ghisler.com/download.htm'

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            '(^\s*file\s*=\s*)(".*")'      = "`$1""`$toolsPath\$($Latest.FileName32)"""
        }
        ".\legal\verification.txt" = @{
            "(?i)(setup:.+)\<.*\>"           = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum-setup:\s+).*"     = "`${1}$($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases
    $re = 'x32_64.exe'
    $url = $download_page.links | Where-Object href -match $re | ForEach-Object href | Select-Object -First 1
    $download_page.RawContent -match 'Download\s+version\s+([0-9][0-9.a]+)\s+' | Out-Null
    $version = $Matches[1] -replace 'a', '.01'

    # Put combined installer as URL32 and installerzip as URL64 so I can use Get-RemoteFiles to download both later
    @{
        URL32    = $url
        Version  = ([version]$version).ToString()  #prevent leading 0es, see https://github.com/chocolatey/chocolatey-coreteampackages/issues/600
    }
}

update -ChecksumFor none
