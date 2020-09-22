Import-Module AU
. "$PSScriptRoot\update_helper.ps1"

$wix_ext_url = "https://marketplace.visualstudio.com/items?itemName=WixToolset.WiXToolset"
$PreURL = "https://marketplace.visualstudio.com"

function global:au_BeforeUpdate {
	  Set-ReadMeFile -keys "PackageName,Title,Year" -new_info "$($Latest.PackageName),$($Latest.Title),$($Latest.Year)"
    # Sleep is here due to the possible return of (429) from the URL32 if called too soon.
    sleep ( Get-Random (10..20) )
    Get-RemoteFiles -Purge -NoSuffix -verbose
}

function global:au_SearchReplace {
  @{
    ".\wixtoolsetextension.nuspec" = @{
      "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
    }
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*located at\:?\s*)\<.*\>" = "`${1}<$($Latest.ReleasesUrl)>"
      "(?i)(\s*1\..+)\<.*\>"             = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*"    = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"      = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*packageName\s*=\s*)'.*'"                    = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*fileType\s*=\s*)'.*'"                       = "`${1}'$($Latest.FileType)'"
      "(?i)(^\s*VsixUrl\s*=\s*`"file:\/\/[$]toolsPath\/).*" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function Get-WixExtensions {
param(
    [string]$release,
    [string]$regex = "VisualStudio",
    [ValidateSet('2010','2012','2013','2015','2017','2019')]
    [string]$year = '2010'

)

$page = Invoke-WebRequest -UseBasicParsing -Uri $release

$urls = $page.links
    foreach ( $link in $urls.href ) {
        if ( $link -match "${regex}${year}" ) {
            $name = ( $matches[0] ).ToLower()
            $title = ( $name -replace ‘(......)’,’$1 ’).trim(‘ ’)
            $releaseurl = $link
            $new_link = $PreUrl + (( Invoke-WebRequest -UseBasicParsing -Uri ( $releaseurl ) ).links | where { $_ -match "download" } ).href
            $version = Get-Version $new_link
            # Sleep is here due to the possible return of (429) from the URL32 if called too soon.
            sleep ( Get-Random (10..20) )
            $url32 = ( Get-RedirectedUrl $new_link -ErrorAction Continue )
        }
    }

return @{
                "Name"         = $name
                "packageName"  = "${name}-wixtoolset"
                "Title"        = "WiX Toolset Visual Studio ${year} Extension"
                "URL32"        = $url32
                "Version"      = $version
                "Year"         = $year
                "ReleasesUrl"  = $releaseurl
        }
}

function global:au_GetLatest {
  $streams = [ordered] @{
    WiX_VS2010_Extension = ( Get-WixExtensions -release $wix_ext_url -year "2010" )
    WiX_VS2012_Extension = ( Get-WixExtensions -release $wix_ext_url -year "2012" )
    WiX_VS2013_Extension = ( Get-WixExtensions -release $wix_ext_url -year "2013" )
    WiX_VS2015_Extension = ( Get-WixExtensions -release $wix_ext_url -year "2015" )
    WiX_VS2017_Extension = ( Get-WixExtensions -release $wix_ext_url -year "2017" )
    WiX_VS2019_Extension = ( Get-WixExtensions -release $wix_ext_url -year "2019" )
  }
  return @{ Streams = $streams }
}

update -ChecksumFor none
