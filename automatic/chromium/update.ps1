Import-Module Chocolatey-AU

$releases = 'https://chromium.woolyss.com/api/v5/?os=win<bit>&type=<type>&out=json'
$ChecksumType = 'sha256'

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
      "(?i)(\s*64\-Bit Software.*)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"            = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum64\:).*"                 = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      '(^[$]version\s*=\s*)(["''].*["''])'       = "`$1'$($Latest.Version)'"
      "(?i)(^\s*url\s*=\s*').*"                  = "`${1}$($Latest.URL32)'"
      "(?i)(^\s*checksumType\s*=\s*').*"         = "`${1}$($Latest.ChecksumType32)'"
      "(?i)(^\s*checksum\s*=\s*').*"           = "`${1}$($Latest.Checksum32)'"
      "(?i)(^\s*file64\s*=\s*`"[$]toolsdir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\chromium.nuspec" = @{
      "(?i)(^\s*\<title\>).*(\<\/title\>)"       = "`${1}$($Latest.Title)`${2}"
    }
  }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -FileNameBase "$($Latest.PackageName)"

    # Removing the 32-bit software in order to reduce package size.
    Remove-Item $PSScriptRoot\tools\chromium_x32.exe
}

function Get-Chromium {
  param(
    [string]$ReleasesBaseUrl = 'https://chromium.woolyss.com/api/v5/?os=win<bit>&type=<type>&out=json',

    [Parameter(Mandatory)]
    [string]$Title,

    [Parameter()]
    [ValidateNotNullOrEmpty()]
    [ValidateSet('dev-official','stable-sync','stable-nosync-arm')]
    [string]$Type = 'dev-official'
  )
  # Change the URI for the specific type and bit and get the information
  $chromium32 = Invoke-RestMethod -Uri ($ReleasesBaseUrl -replace '<type>', $type -replace '<bit>', '32') -UseBasicParsing
  $chromium64 = Invoke-RestMethod -Uri ($ReleasesBaseUrl -replace '<type>', $type -replace '<bit>', '64') -UseBasicParsing

  # Compare versions default to 64bit version for any variance
  $version = if ($chromium32.chromium.windows.version -ne $chromium64.chromium.windows.version) {
    $chromium64.chromium.windows.version
  } else {
    $chromium32.chromium.windows.version
  }

  # Update Version for Snapshots or Stable
  $version += @{$true="-snapshots";$false=""}[ $Type -eq 'dev-official' ]

	@{
		Title = $Title
		URL32 = $chromium32.chromium.windows.download
		URL64 = $chromium64.chromium.windows.download
		Version = $version
		ChecksumType32 = $checksumType
		ChecksumType64 = $checksumType
	}
}

function global:au_GetLatest {
  $streams = [ordered] @{
    stable = Get-Chromium -Title "Chromium" -Type "stable-sync"
    snapshots = Get-Chromium -Title "Chromium Snapshots" -Type "dev-official"
  }

  return @{ Streams = $streams }
}


update -ChecksumFor none
