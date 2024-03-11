Import-Module Chocolatey-AU

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $Latest.Checksum32 = Get-RemoteChecksum -Algorithm $Latest.ChecksumType32 -Url $Latest.URL32
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"                = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"           = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'"       = "`${1}'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_GetLatest {
	$downloadSite = "https://www.sourcetreeapp.com/download/"

	$Splat = @{
		Method = 'GET'
		Uri = $downloadSite
	}

	$results = Invoke-RestMethod @Splat

	$urlRegEx = '"enterpriseURL":"(.*?)"'

	if ($results -match $URLregEx){
		$url = $matches[1]
		$versionFromUrl = ($url -split "/")[-1]
		$version = $versionFromUrl -replace "^(\w+)_", "" -replace ".msi$", ""
	}

  @{ URL32 = $url; Version = $version }
}

update -ChecksumFor none
