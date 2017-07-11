import-module au

$releases     = "https://qtox-win.pkg.tox.chat/qtox/win64"
$softwareName = 'qTox'

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -FileNameBase "setup-$($softwareName)-$($Latest.Version)"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $download_page.Links | ? href -match 'setup-qtox64-([\d\.]+).*.exe.asc$' | Out-Null
  $version = $Matches[1]
  if (!$version) { throw "qtox version not found on $releases" }

  @{
    URL32    = 'https://qtox-win.pkg.tox.chat/qtox/win32/download'
    URL64    = 'https://qtox-win.pkg.tox.chat/qtox/win64/download'
    Version  = $version
    FileType = 'exe'
  }
}

update -ChecksumFor none
