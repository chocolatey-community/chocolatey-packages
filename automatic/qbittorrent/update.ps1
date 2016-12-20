import-module au

$releases = 'http://www.qbittorrent.org/download.php'

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
        ".\tools\verification.txt"      = @{
          "(?i)(1\..+)\<.*\>"          = "`${1}<$($Latest.URL32)>"
          "(?i)(checksum type:\s+).*"   = "`${1}$($Latest.ChecksumType)"
          "(?i)(checksum:\s+).*"       = "`${1}$($Latest.Checksum)"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = 'setup\.exe'
    $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

    $version  = $url -split '[_]' | select -Last 1 -Skip 1
    $fileName = $url -split '/' | select -last 1 -skip 1

    return @{ URL32 = $url; Version = $version; FileName = $fileName }
}

update -ChecksumFor none
