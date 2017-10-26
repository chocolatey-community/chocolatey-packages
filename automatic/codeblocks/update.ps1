import-module au

$releases = 'http://www.codeblocks.org/downloads/26'

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameSkip 1 }

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(`"`[$]toolsDir\\).*`"" = "`${1}$($Latest.FileName32)`""
    }
    ".\codeblocks.nuspec"           = @{
      "(\<releaseNotes\>).*(\<\/releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
    }
    ".\legal\verification.txt"      = @{
      "(?i)(1\..+)\<.*\>"         = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum:\s+).*"      = "`${1}$($Latest.Checksum32)"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re = 'sourceforge.*mingw-setup\.exe$'
  $url = $download_page.links | ? href -match $re | select -first 1 -expand href

  if (!$url.StartsWith("https")) {
    $url = $url -replace "^http", "https"
  }

  $version = $url -split '[-]|mingw' | select -Last 1 -Skip 2

  $changelog = $download_page.links | ? title -match "^changelog$" | select -first 1 -expand href
  $fileName = $url -split '/' | select -last 1

  return @{
    URL32        = $url;
    Version      = $version
    ReleaseNotes = $changelog
    FileType     = 'exe'
  }
}

update -NoCheckUrl -ChecksumFor none
