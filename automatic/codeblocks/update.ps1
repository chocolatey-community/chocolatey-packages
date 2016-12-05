import-module au

$releases = 'http://www.codeblocks.org/downloads/26'

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.exe"

  $client = New-Object System.Net.WebClient

  $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"

  $client.DownloadFile($Latest.URL32, "$filePath")
  $client.Dispose()

  $Latest.ChecksumType = 'sha256'
  $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | % Hash
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(`"`[$]toolsDir\\).*`"" = "`${1}$($Latest.FileName)`""
    }
    ".\codeblocks.nuspec" = @{
      "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
    ".\tools\verification.txt"      = @{
      "(?i)(1\..+)\<.*\>"          = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:\s+).*"  = "`${1}$($Latest.ChecksumType)"
      "(?i)(checksum:\s+).*"       = "`${1}$($Latest.Checksum)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re    = 'sourceforge.*mingw-setup\.exe$'
  $url   = $download_page.links | ? href -match $re | select -first 1 -expand href

  if (!$url.StartsWith("https")) {
    $url = $url -replace "^http","https"
  }

  $version  = $url -split '[-]|mingw' | select -Last 1 -Skip 2

  $changelog = $download_page.links | ? title -match "^changelog$" | select -first 1 -expand href
  $fileName = $url -split '/' | select -last 1

  return @{
    URL32        = $url;
    Version      = $version
    ReleaseNotes = $changelog
    FileName     = $fileName
  }
}

update -NoCheckUrl -ChecksumFor none
