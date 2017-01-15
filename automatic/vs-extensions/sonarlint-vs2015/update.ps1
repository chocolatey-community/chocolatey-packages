import-module au

$releases = 'https://marketplace.visualstudio.com/items?itemName=SonarSource.SonarLintforVisualStudio'

function global:au_BeforeUpdate {
  Remove-Item "$PSScriptRoot\tools\*.vsix"

  $client = New-Object System.Net.WebClient
  try
  {
    $filePath = "$PSScriptRoot\tools\$($Latest.FileName32)"

    $client.DownloadFile($Latest.URL32, "$filePath")
  }
  finally
  {
    $client.Dispose()
  }

  $Latest.ChecksumType = "sha256"
  $Latest.Checksum = Get-FileHash -Algorithm $Latest.ChecksumType -Path $filePath | ForEach-Object Hash
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(1\..+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType)"
      "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum)"
    }
    'tools\chocolateyInstall.ps1' = @{
      "(PackageName\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.PackageName)`""
      "(^[$]filePath\s*=\s*`"[$]toolsPath\\)(.*)`"" = "`$1$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $json = $download_page.AllElements | ? class -eq 'vss-extension' | Select-Object -expand innerHtml | ConvertFrom-Json | Select-Object -expand versions
  $url = $json.files | ? source -match "\.vsix$" | Select-Object -expand source -first 1

  $filename = [IO.Path]::GetFilename($url)

  $version = $json.version | Select-Object -first 1

  @{
    Version   = $version
    URL32     = $url
    Filename32  = $filename
  }
}

update -ChecksumFor none
