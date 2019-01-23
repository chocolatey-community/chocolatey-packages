Import-Module AU

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
  @{
    'legal\VERIFICATION.txt'        = @{
      "(?i)(url:.+)\<.*\>"        = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum:\s+).*"      = "`${1}$($Latest.Checksum32)"
    }
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s+\-File `"[$]toolsDir\\).*?`"" = "`${1}$($Latest.FileName32)`""
    }
  }
}

function global:au_GetLatest {
  $page = Invoke-WebRequest 'https://www.umlet.com/changes.htm' -UseBasicParsing
  $url = $page.Links `
    | Where-Object href -Match 'umlet-standalone-(.+)\.zip$' `
    | Select-Object -First 1 -Expand href `
    | ForEach-Object {"https://www.umlet.com/$_"}
  $version = $matches[1]

  @{
    Version = $version
    URL32   = $url
  }
}

Update-Package -ChecksumFor none
