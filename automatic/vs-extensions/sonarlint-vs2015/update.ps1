import-module au

$releases = 'https://marketplace.visualstudio.com/items?itemName=SonarSource.SonarLintforVisualStudio'

function global:au_SearchReplace {
  @{
    'tools\chocolateyInstall.ps1' = @{
      "(PackageName\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.PackageName)`""
      "(VsixUrl\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.URL32)`""
      "(Checksum\s*=\s*)`"([^*]+)`"" = "`$1`"$($Latest.Checksum)`""
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases

  $json = $download_page.AllElements | ? class -eq 'vss-extension' | Select-Object -expand innerHtml | ConvertFrom-Json | Select-Object -expand versions
  $url = $json.files | ? source -match "\.vsix$" | Select-Object -expand source -first 1

  $version = $json.version | Select-Object -first 1
  $checksum = Get-RemoteChecksum $url

  @{
    Version   = $version
    URL32     = $url
    Checksum  = $checksum
  }
}

update -ChecksumFor none