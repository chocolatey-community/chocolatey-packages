import-module au

$releases = "https://archive.torproject.org/tor-package-archive/torbrowser/13.0.6/"
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
  $url32            = $releases + ($allExes | Where-Object { $_ -match "tor-browser-windows-x86_64-portable-\d.*.exe$" } | Select-Object -First 1)
  $url64            = $releases + ($allExes | Where-Object { $_ -match "tor-browser-windows-x86_64-portable-\d.*.exe$" } | Select-Object -First 1)
  $version          = $releases -split '\/' | Select-Object -last 1 -skip 1
  
  @{
    Version         = "$version"
    URL32           = $url32
    URL64           = $url64
  }
}

update -ChecksumFor none
