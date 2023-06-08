import-module au

$releases = "https://www.torproject.org/download/languages/"
$baseUrl  = "https://www.torproject.org"

function global:au_SearchReplace {
  @{ 
    "tools\chocolateyinstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64\s*=\s*)('.*')" = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }	
  }
}

function global:au_BeforeUpdate() {
  $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
  $Latest.Checksum64 = Get-RemoteChecksum $Latest.Url64
}

function global:au_GetLatest {
  $download_page    = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
  $allExes          = $download_page.Links | Where-Object href -match "\.exe$" | Select-Object -expand href
  $url32            = $allExes | Where-Object { $_ -match "torbrowser-install-\d.*_All.exe$" } | Select-Object -First 1
  $url64            = $allExes | Where-Object { $_ -match "torbrowser-install-win64.*_All.exe$" } | Select-Object -First 1
  $version          = $url64 -split '\/' | Select-Object -last 1 -skip 1
  
  @{
    Version         = "$version"
    URL32           = $baseUrl + $url32
    URL64           = $baseUrl + $url64
  }
}

update -ChecksumFor none
