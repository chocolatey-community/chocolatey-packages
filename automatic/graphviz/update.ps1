import-module au

$releases = "https://graphviz.org/download"

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix -FileNameBase $Latest.FileName }

function global:au_SearchReplace {
    @{
        ".\tools\chocolateyInstall.ps1" = @{
          '(?i)(^\s*file64\s*=\s*)(".*")'       = "`$1`"`$toolsPath\$($Latest.FileName64)`""
        }

        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"                     = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*"                 = "`${1} $($Latest.Checksum64)"
        }
    }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -UseBasicParsing -Uri $releases

  $re  = "windows_10_cmake_Release.+-win64\.exe"
  $link = $download_page.links | ? outerHtml -match $re | select -first 1
  $link.outerHtml -match '>(.+)</a>' | Out-Null
  $fileName = $Matches[1]

  @{
    Version = $filename -split '-| ' | select -First 1 -Skip 1
    URL64 = $link.href
    FileName = $fileName
    FileType = 'exe'
  }
}

update -ChecksumFor none -NoCheckUrl
