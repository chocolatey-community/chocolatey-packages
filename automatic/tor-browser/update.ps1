import-module au

$domain   = 'https://www.torproject.org'
$releases = "$domain/projects/torbrowser.html"

function GetChecksum() {
  param($url)
  $checksum = Get-RemoteChecksum -Url $url -Algorithm 'sha256'
  return $checksum
}

function global:au_BeforeUpdate {
  $data = $Latest.Keys | ? { $_.StartsWith('URL') } | select `
    @{Name = 'Locale';   Expression = { $Latest[$_] -split '_|\.exe$' | select -last 1 -skip 1}},
    @{Name = 'Checksum'; Expression = { $(GetChecksum $Latest[$_]) }},
    @{Name = 'URL';      Expression = { $Latest[$_] }}

  $data | ConvertTo-Csv -Delimiter '|' | Out-File "$PSScriptRoot\tools\LanguageChecksums.csv" -Encoding utf8
}

function global:au_SearchReplace { @{} }

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $usUrl   = $download_page.Links | ? href -match "torbrowser-install.*en-US\.exe$" | select -First 1 -expand href
  $version = $usUrl -split '\/' | select -last 1 -skip 1
  $allUrls = $download_page.Links | ? href -match "torbrowser-install-${version}_[a-z\-]+\.exe$" | select -expand href | % { $_ -replace '^\.\.\/',"$domain/"}

  $Latest = @{
    Version = $version
  }
  $index = 0
  $allUrls | % { $Latest["URL$($index)"] = $_; $index++ }
  $Latest
}

update -ChecksumFor none
