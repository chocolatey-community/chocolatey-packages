import-module au
Import-Module $env:chocolateyInstall\helpers\chocolateyInstaller.psm1

$releases = "https://www.torproject.org/download/languages/"
$domain   = $releases -split '(?<=//.+)/' | select -First 1

function GetChecksum() {
  param($url)
  Write-Host "Getting Checksum for '$url'..."
  $tempOut = [System.IO.Path]::GetTempFileName()

  try {
    Get-WebFile $url $tempOut # Get-WebFile have better download rate than Get-RemoteChecksum
    $checksum = Get-FileHash $tempOut -Algorithm SHA256 | % Hash
    return $checksum
  }
  finally {
    rm -force $tempOut -ea 0
  }
}

function global:au_BeforeUpdate {
  $data = $Latest.Keys | ? { $_.StartsWith('URL32') } | select `
  @{Name = 'Locale';     Expression = { $Latest[$_] -split '_|\.exe$' | select -last 1 -skip 1 } },
  @{Name = 'Checksum';   Expression = { $(GetChecksum $Latest[$_]) } },
  @{Name = 'Checksum64'; Expression = { $(GetChecksum $Latest[$($_ -replace "L32", "L64")]) } },
  @{Name = 'URL32';      Expression = { $Latest[$_] } },
  @{Name = 'URL64';      Expression = { $Latest[$($_ -replace "L32", 'L64')] } }

  $data | ConvertTo-Csv -Delimiter '|' | Out-File "$PSScriptRoot\tools\LanguageChecksums.csv" -Encoding utf8
}

function global:au_SearchReplace { @{ }
}

function global:au_GetLatest {
  $download_page    = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $allExes          = $download_page.Links | ? href -match "\.exe$" | select -expand href
  $usUrl            = $allExes | ? { $_ -match "torbrowser-install.*en-US\.exe$" } | select -First 1
  $version          = $usUrl -split '\/' | select -last 1 -skip 1
  [array]$all64Urls = $allExes | ? { $_ -match $version -and $_ -match "Win64" } | % { $domain + $_}
  if ($all64Urls.Count -eq 0) {
    throw "Missing urls was found for either 32 bit or 64 bit"
  }

  $Latest = @{
    Version = $version
  }
  $index  = 0
  $all64Urls | % {
    $Latest["URL32$($index)"] = $_ -replace '-win64', ''
    $Latest["URL64$($index)"] = $_
    $index++
  }
  $Latest
}

update -ChecksumFor none
