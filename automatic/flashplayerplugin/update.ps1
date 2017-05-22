import-module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'http://fpdownload2.macromedia.com/get/flashplayer/update/current/xml/version_en_win_pl.xml'
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

  $XML = New-Object  System.Xml.XmlDocument
  $XML.load($releases)
  $version = $XML.XML.update.version.replace(',', '.')
  $major_version = ([version]$version).Major

    @{
        Version = Get-PaddedVersion $version $padVersionUnder
        URL32   = "https://download.macromedia.com/get/flashplayer/pdc/${version}/install_flash_player_${major_version}_plugin.msi"
    }
}

update -ChecksumFor 32
