Import-Module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"
. "$PSScriptRoot\update_helper.ps1"

function global:au_AfterUpdate { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest { 
 $downloadEndpointUrl = 'https://www.dropbox.com/download?full=1&plat=win'
    $versionRegEx = '.*Dropbox%20([0-9\.]+).*'
    $downloadUrl = Get-RedirectedUrl $downloadEndpointUrl
    $fnd_version = $downloadUrl -replace $versionRegEx, '$1'
	  $version = ( drpbx-compare $fnd_version )
    return @{ URL32 = $downloadUrl; Version = $version }
}

Function Get-RedirectedUrl {
    Param (
        [Parameter(Mandatory = $true)][String]$url
    )

    $request = [System.Net.WebRequest]::Create($url)
    $request.AllowAutoRedirect = $false
    $response = $request.GetResponse()

    If ($response.StatusCode -eq "Found") {
        $response.GetResponseHeader("Location")
    }
}

update -ChecksumFor 32

