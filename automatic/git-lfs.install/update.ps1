. $PSScriptRoot\..\git-lfs\update.ps1

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.exe"

  $client = New-Object System.Net.WebClient
  try
  {
    $filePath = "$PSScriptRoot\tools\$($Latest.FileName)"

    $client.DownloadFile($Latest.URL32, "$filePath")
  }
  finally
  {
    $client.Dispose()
  }

  $Latest.ChecksumType = "sha256"
  $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | % Hash
}

function global:au_SearchReplace {
    @{
        ".\git-lfs.install.nuspec" = @{
            "(<releaseNotes>https:\/\/github.com\/git-lfs\/git-lfs\/releases\/tag\/v)(.*)(<\/releaseNotes>)" = "`${1}$($Latest.Version.ToString())`$3"
        }
        "tools\chocolateyInstall.ps1" = @{
            "(?i)(`"`[$]toolsDir\\).*`"" = "`${1}$($Latest.FileName)`""
        }
        ".\tools\verification.txt" = @{
            "(?i)(1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
            "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType)"
            "(?i)(checksum:\s+).*" = "`${1}$($Latest.Checksum)"
        }
     }
}

update -ChecksumFor none
