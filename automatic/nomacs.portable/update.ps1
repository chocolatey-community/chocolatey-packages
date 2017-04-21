import-module au
. "$PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1"

$releases = 'http://download.nomacs.org/versions'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]fileName\s*=\s*)('.*')"  = "`$1'$($Latest.FileName)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }

        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x64:).*"        = "`${1} $($Latest.URL)"
          "(?i)(checksum64:).*"    = "`${1} $($Latest.Checksum)"
        }
    }
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_BeforeUpdate {
  rm "$PSScriptRoot\tools\*.zip"

  $client = New-Object System.Net.WebClient
    $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
    $client.DownloadFile($Latest.URL, $filePath)
  $client.Dispose()

  $Latest.ChecksumType = 'sha256'
  $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | % Hash
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url     = $download_page.links | ? href -like '*/nomacs-*' | % href | sort -desc | select -First 1
    $version = $url -split '-|\.zip' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL          = $url
        ReleaseNotes = "https://github.com/nomacs/nomacs/releases/tag/${version}"
        FileName     = $url -split '/' | select -last 1
    }
}

update -ChecksumFor none
