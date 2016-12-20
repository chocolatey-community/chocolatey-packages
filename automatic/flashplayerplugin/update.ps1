import-module au

$releases = 'https://get.adobe.com/flashplayer/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $version = ($download_page.links | ? href -match 'version=' | % href | select -last 1) -split '=|&' | ? { [version]::TryParse($_, [ref]($__))}
    $major_version = ([version]$version).Major
    @{
        Version = $version
        URL32   = "https://download.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_${major_version}_plugin.msi"
    }
}

update -ChecksumFor 32
