import-module au
Import-Module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

$releases = 'https://www.zotero.org/download/client/dl?channel=release&platform=win32'
$softwareName = 'Zotero Standalone *'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_AfterUpdate { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_SearchReplace {
  $version = [version]$Latest.Version

  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsPath\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
    ".\$($Latest.PackageName).nuspec" = @{
      "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}https://www.zotero.org/support/$($version.Major).$($version.Minor)_changelog`${2}"
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

update -ChecksumFor none
