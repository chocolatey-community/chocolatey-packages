Import-Module Chocolatey-AU

$baseUrl = "https://dist.torproject.org/torbrowser"

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

function global:au_GetLatest {
  $downloadPage = Invoke-WebRequest -Uri "$baseUrl/" -UseBasicParsing
  $versions = [regex]::Matches($downloadPage.Content, 'href="(?<version>\d+(?:\.\d+)*)/"') |
    ForEach-Object { $_.Groups['version'].Value } |
    Sort-Object { [version]$_ } -Descending

  foreach ($version in $versions) {
    $checksumUrl = "$baseUrl/$version/sha256sums-signed-build.txt"
    try {
      $checksumContent = (Invoke-WebRequest -Uri $checksumUrl -UseBasicParsing).Content
    }
    catch {
      continue
    }

    $file32 = "tor-browser-windows-i686-portable-$version.exe"
    $file64 = "tor-browser-windows-x86_64-portable-$version.exe"
    $checksum32 = [regex]::Match($checksumContent, "(?m)^([a-fA-F0-9]{64})\s+$([regex]::Escape($file32))\s*$")
    $checksum64 = [regex]::Match($checksumContent, "(?m)^([a-fA-F0-9]{64})\s+$([regex]::Escape($file64))\s*$")

    # Some releases are Android-only; use the newest version with both Windows installers.
    if ($checksum32.Success -and $checksum64.Success) {
      return @{
        Version   = $version
        URL32     = "$baseUrl/$version/$file32"
        URL64     = "$baseUrl/$version/$file64"
        Checksum32 = $checksum32.Groups[1].Value
        Checksum64 = $checksum64.Groups[1].Value
      }
    }
  }

  throw "Could not find a stable Tor Browser release with both Windows installers at $baseUrl"
}

update -ChecksumFor none
