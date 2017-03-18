import-module au

$releases = 'http://www.ghisler.com/amazons3.php'

function global:au_SearchReplace {
    @{
        ".\legal\verification.txt" = @{
            "(?i)(setup:.+)\<.*\>"           = "`${1}<$($Latest.URL32)>"
            "(?i)(installer:.+)\<.*\>"       = "`${1}<$($Latest.URL64)>"
            "(?i)(checksum-setup:\s+).*"     = "`${1}$($Latest.Checksum32)"
            "(?i)(checksum-installer:\s+).*" = "`${1}$($Latest.Checksum64)"
        }
     }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix
    mv $PSScriptRoot\tools\installer.exe $PSScriptRoot\tools\installer.zip -ea 0
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases
    $re = 'x32_64.exe'
    $url = $download_page.links | ? href -match $re | % href
    $download_page.RawContent -match 'Download Total Commander ([0-9][0-9.a]+) ' | Out-Null
    $version = $Matches[1] -replace 'a', '.01'

    # Put combined installer as URL32 and installerzip as URL64 so I can use Get-RemoteFiles to download both later
    @{
        URL32    = $url
        URL64    = "http://ghisler.fileburst.com/addons/installer.zip"
        Version  = ([version]$version).ToString()  #prevent leading 0es, see https://github.com/chocolatey/chocolatey-coreteampackages/issues/600
        FileType = 'exe'
    }
}

update -ChecksumFor none
