import-module au

$releases = 'https://github.com/keepassxreboot/keepassxc/releases'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    ".\legal\verification.txt" = @{
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType64)"
      "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
      "(?i)(^\s*checksum\s*=\s*)'(.*)'" = "`${1}'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)'(.*)'" = "`${1}'$($Latest.Checksum64)'"
    }
  }
}

function global:au_GetLatest {

  $downloadedPage = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $url32 = $downloadedPage.links | ? href -match 'Win32.msi$' | select -First 1 -expand href
  # By default packages hosted on github do not have a full path, but only the
  # path from the root. Cast the URL to a full URL.
  $baseUrl = $([System.Uri]$releases).Authority
  $scheme = $([System.Uri]$releases).Scheme
  if ($url32.Authority -cnotmatch $baseUrl) {
    $url32 = $scheme + '://' + $baseUrl + $url32
  }
  $url32SegmentSize = $([System.Uri]$url32).Segments.Length
  $filename32 = $([System.Uri]$url32).Segments[$url32SegmentSize - 1]

  $url64 = $downloadedPage.links | ? href -match 'Win64.msi$' | select -First 1 -expand href
  if ($url64.Authority -cnotmatch $baseUrl) {
    $url64 = $scheme + '://' + $baseUrl + $url64
  }
  $url64SegmentSize = $([System.Uri]$url64).Segments.Length
  $filename64 = $([System.Uri]$url64).Segments[$url64SegmentSize - 1]

  $version = [regex]::match($url32,'(.*)*([0-9]+.[0-9]+.[0-9]+)(.*)msi').Groups[2].Value
  
  # Since upstream is providing hashes, let's rely on these instead.
  $digestPage = Invoke-WebRequest -Uri "$url32.DIGEST" -UseBasicParsing
  $readStream = New-Object System.IO.StreamReader($digestPage.RawContentStream)
  $hash32 = $readStream.ReadLine().Split(' ')[0]
  
  $digestPage = Invoke-WebRequest -Uri "$url64.DIGEST" -UseBasicParsing
  $readStream = New-Object System.IO.StreamReader($digestPage.RawContentStream)
  $hash64 = $readStream.ReadLine().Split(' ')[0]
  
  return @{
    url32 = $url32;
    url64 = $url64;
    checksum32 = $hash32;
    checksum64 = $hash64;
    checksumType32 = 'SHA256';
    checksumType64 = 'SHA256';
    filename32 = $filename32;
    filename64 = $filename64;
    version = $version;
  }
}

update -ChecksumFor none