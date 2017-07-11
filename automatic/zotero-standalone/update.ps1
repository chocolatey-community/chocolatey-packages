import-module au

$releases = 'https://www.zotero.org/download/client/dl?channel=release&platform=win32'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_GetLatest {
    $url = GetRedirectedUrl -url $releases

    $version  = $url -split '/' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = $url
    }
}

function GetRedirectedUrl() {
  param([string]$url)

  $req = [System.Net.WebRequest]::Create($url)
  $resp = $req.GetResponse()
  if ($resp.ResponseUri.OriginalString -eq $url) { $res = $url }
  else {
    $res = $resp.ResponseUri.OriginalString
  }

  $resp.Dispose() | Out-Null
  return $res
}

update -ChecksumFor 32
