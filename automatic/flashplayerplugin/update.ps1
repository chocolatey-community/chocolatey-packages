import-module au
. "$PSScriptRoot\..\..\scripts\Get-Padded-Version.ps1"

$releases = 'https://get.adobe.com/flashplayer/'
$padVersionUnder = '24.0.1'

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
  $HTML = Invoke-WebRequest -Uri $releases
  $try = ($HTML.ParsedHtml.getElementsByTagName('p') | Where{ $_.className -eq 'NoBottomMargin' } ).innerText
  $try = $try  -split "\r?\n"
  $try = $try[0] -replace ' ', ' = '
  $try =  ConvertFrom-StringData -StringData $try
  $version = ( $try.Version )
  $major_version = ([version]$version).Major
    @{
        Version = Get-Padded-Version $version $padVersionUnder
        URL32   = "https://download.macromedia.com/get/flashplayer/pdc/${version}/install_flash_player_${major_version}_plugin.msi"
    }
}

update -ChecksumFor 32
