import-module au


$releases = 'http://www.graphviz.org/Download_windows.php'

function global:au_SearchReplace {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.msi$'
    $url = $download_page.links | ? href -match $re | select -First 1 -expand href
    $version  =  $url -split '-|\.msi' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = "http://www.graphviz.org" + $url
    }
}

update -ChecksumFor none
