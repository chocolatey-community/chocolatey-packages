import-module au

$releases = 'https://autohotkey.com/download'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*[$]fileName\s*=\s*)('.*')"  = "`$1'$($Latest.FileName)'"
        }

        ".\tools\verification.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL)"
        }
    }
}
function global:au_BeforeUpdate {
  rm "$PSScriptRoot\tools\*.zip"
  $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"
  Invoke-WebRequest $Latest.URL -OutFile $filePath -UseBasicParsing
  $Latest.ChecksumType = 'sha256'
  $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | % Hash
}

function global:au_GetLatest {
    $version1 = Invoke-WebRequest -Uri "$releases/1.1/version.txt" -UseBasicParsing | % Content
    $url1     = "$releases/1.1/AutoHotkey_${version1}.zip"

    $version2withHash = Invoke-WebRequest -Uri "$releases/2.0/version.txt" -UseBasicParsing | % Content
    $version2 = $version2withHash -replace '(\d+.\d+-\w+)-\w+', '$1'
    $url2     = "$releases/2.0/AutoHotkey_${version2withHash}.zip"

    @{
        Streams = [ordered] @{
            '2.0' = @{
                Version  = $version2
                URL      = $url2
                FileName = $url2 -split '/' | select -Last 1
            }
            '1.1' = @{
                Version  = $version1
                URL      = $url1
                FileName = $url1 -split '/' | select -Last 1
            }
        }
    }
}

update -ChecksumFor none -NoCheckUrl
