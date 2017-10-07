import-module au

$releases = 'https://www.lwks.com/index.php?option=com_lwks&view=download&Itemid=206&tab=0'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    [System.Net.ServicePointManager]::SecurityProtocol = 'Ssl3,Tls,Tls11,Tls12' #https://github.com/chocolatey/chocolatey-coreteampackages/issues/366
    $download_page = Invoke-WebRequest $releases

    $version = $download_page.AllElements | ? class -eq 'release_table' | % InnerText | Select -First 1
    $version = ($version -split ":|\n" | select -Index 1).Trim()
    @{
        Version = $version
        URL32   = "https://s3.amazonaws.com/lightworks/lightworks_v${version}_full_32bit_setup.exe"
        URL64   = "https://s3.amazonaws.com/lightworks/lightworks_v${version}_full_64bit_setup.exe"
    }
}

update
