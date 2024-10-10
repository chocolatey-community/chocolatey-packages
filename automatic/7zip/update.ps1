Import-Module Chocolatey-AU

$domain = 'http://www.7-zip.org/'
$releases = "${domain}download.html"

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest $releases

  $streams = @{}

  $download_page.AllElements | Where-Object innerText -match "^Download 7\-Zip ([\d\.]+) ?(alpha|beta|rc)? \([\d]{4}[\-\d]+\)" | ForEach-Object {
    if ($Matches[1] -and $Matches[2]) {
      $streamName = "pre"
      $version = "$($Matches[1])"
      $versionFull = "$version-$($Matches[2])"
    }
    elseif ($Matches[1]) {
      $streamName = "stable"
      $version = $Matches[1]
      $versionFull = $version
    }
    else {
      return
    }
    if ($streams.ContainsKey($streamName)) { return }

    $URLS = $download_page.links | Where-Object href -match "7z$($version -replace '\.','')" | Select-Object -expand href

    $streams["$streamName"] = @{
      URL32     = $domain + ($URLS | Where-Object { $_ -notmatch "x64" } | Select-Object -first 1)
      URL64     = $domain + ($URLS | Where-Object { $_ -match "x64" } | Select-Object -first 1)
      URL_EXTRA = $domain + ($URLS | Where-Object { $_ -match "extra" } | Select-Object -first 1)
      Version   = (Get-Version $versionFull).ToString()
    }
  }

  return @{ Streams = $streams }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none -NoCheckUrl # NoCheckUrl is now required due to server misconfiguration
}
