import-module au

$releases = 'https://autohotkey.com/download/1.1'

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
    $version = Invoke-WebRequest -Uri "$releases\version.txt" -UseBasicParsing | % Content
    $url     = "$releases/AutoHotkey_${version}.zip"
    @{
        Version  = $version
        URL      = $url
        FileName = $url -split '/' | select -Last 1
    }
}

update -ChecksumFor none -NoCheckUrl
