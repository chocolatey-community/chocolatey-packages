
import-module au
    $releases = 'https://chromium.woolyss.com/api/v5/?os=win<bit>&type=<type>&out=json'
    $ChecksumType = 'sha256'

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
    "(?i)(\s*32\-Bit Software.*)\<.*\>"        = "`${1}<$($Latest.URL32)>"
    "(?i)(\s*64\-Bit Software.*)\<.*\>"        = "`${1}<$($Latest.URL64)>"
    "(?i)(^\s*checksum\s*type\:).*"            = "`${1} $($Latest.ChecksumType32)"
    "(?i)(^\s*checksum32\:).*"                 = "`${1} $($Latest.Checksum32)"
    "(?i)(^\s*checksum64\:).*"                 = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
    '(^[$]version\s*=\s*)(".*")'               = "`$1""$($Latest.Version)"""
	  "(?i)(^\s*file\s*=\s*`"[$]toolsdir\\).*"   = "`${1}$($Latest.FileName32)`""
	  "(?i)(^\s*file64\s*=\s*`"[$]toolsdir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\chromium.nuspec" = @{
    "(?i)(^\s*\<title\>).*(\<\/title\>)"       = "`${1}$($Latest.Title)`${2}"
    }
  }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -FileNameBase "$($Latest.PackageName)"
}

function Get-Chromium {
param(
	[string]$releases,
	[string]$Title,
    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('dev-official','stable-sync','stable-nosync-arm')]
    [string]$type = 'dev-official'
)
 # Change the URI for the specific type and bit
    $releases = $releases -replace('<type>', $type )
    $releases_x32 = $releases -replace('<bit>','32')
    $releases_x64 = $releases -replace('<bit>','64')
    $download_page32 = Invoke-WebRequest -Uri $releases_x32
    $download_page64 = Invoke-WebRequest -Uri $releases_x64
 # Convert Respose from Json
    $chromium32 = $download_page32 | ConvertFrom-Json
    $chromium64 = $download_page64 | ConvertFrom-Json
 # Get values from the hashtable
    $url32 = $chromium32.chromium.windows.download
    $url64 = $chromium64.chromium.windows.download
    $version32 = $chromium32.chromium.windows.version
    $version64 = $chromium64.chromium.windows.version
 # Compare versions default to 64bit version for any variance
    if ($version32 -ne $version64) { $version = $version64 } else { $version = $version32 }
 # Build Version for Snapshots or Stable
    $build = @{$true="-snapshots";$false=""}[ $type -eq 'dev-official' ]
    
	@{
		Title = $Title
		URL32 = $url32
		URL64 = $url64
		Version = "$version$build"
		ChecksumType32 = $ChecksumType
		ChecksumType64 = $ChecksumType
	}
}

function global:au_GetLatest {
  $streams = [ordered] @{
    stable = Get-Chromium -releases $releases -Title "Chromium" -type "stable-sync"
    snapshots = Get-Chromium -releases $releases -Title "Chromium Snapshots" -type "dev-official"
  }

  return @{ Streams = $streams }
}


update -ChecksumFor none
