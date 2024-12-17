Import-Module Chocolatey-AU

$releases = 'https://aka.ms/downloadazcopy-v10-windows'

# Define a function to handle the 301 redirection and retrieve headers
function Get-RedirectedUrl {
  param (
      [string]$Url
  )
  # Use .NET HttpClient for better control
  $handler = New-Object System.Net.Http.HttpClientHandler
  $handler.AllowAutoRedirect = $false  # Prevent auto-following redirects

  $client = New-Object System.Net.Http.HttpClient($handler)

  try {
      # Create a HEAD request
      $request = [System.Net.Http.HttpRequestMessage]::new([System.Net.Http.HttpMethod]::Head, $Url)
      $response = $client.SendAsync($request).Result

      if ($response.StatusCode -eq [System.Net.HttpStatusCode]::MovedPermanently -or `
          $response.StatusCode -eq [System.Net.HttpStatusCode]::Found) {
          return $response.Headers.Location.AbsoluteUri
      } else {
          throw "Unexpected status code: $($response.StatusCode)"
      }
  }
  finally {
      $client.Dispose()
  }
}

function global:au_GetLatest {
    $url64 = Get-RedirectedUrl -Url $releases
    $url32 = $url64 -replace "amd64", "386"
    $version = $url64 -replace ".zip", "" -split "_" | Select-Object -Last 1

    @{
        URL32   = $url32
        URL64   = $url64
        Version = $version
    }
}

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url64\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*checksumType64\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
            "(?i)(^\s*url\s*=\s*)('.*')"            = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"       = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')"   = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

update -ChecksumFor all
