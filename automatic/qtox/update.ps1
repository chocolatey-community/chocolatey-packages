import-module au

$releases = "https://github.com/qTox/qTox/blob/master/README.md"
$changelog = "https://github.com/qTox/qTox/blob/master/CHANGELOG.md"
$softwareName = 'qTox'

function global:au_BeforeUpdate {
  $Latest.ChecksumType32 = 'sha256'
  $toolsDir = "$PSScriptRoot\tools"
  Remove-Item -Force "$toolsDir\*.exe" -ea 0

  $Latest.FileName32 = "$($Latest.PackageName)_x86.exe"
  Get-WebFile $Latest.URL32 "$toolsDir\$($Latest.FileName32)"

  $Latest.FileName64 = "$($Latest.PackageName)_x64.exe"
  Get-WebFile $Latest.URL64 "$toolsDir\$($Latest.FileName64)"

  $Latest.Checksum32 = Get-FileHash "$toolsDir\$($Latest.FileName32)" -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash
  $Latest.Checksum64 = Get-FileHash "$toolsDir\$($Latest.FileName64)" -Algorithm $Latest.ChecksumType32 | ForEach-Object Hash
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt"        = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*32\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(\s*64\-Bit Software.*)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(^\s*checksum\s*type\:).*"     = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*"       = "`${1} $($Latest.Checksum32)"
      "(?i)(^\s*checksum(64)?\:).*"       = "`${1} $($Latest.Checksum64)"
    }
    ".\tools\chocolateyInstall.ps1"   = @{
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)^(\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^[$]filePath32\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName32)`""
      "(?i)(^[$]filePath64\s*=\s*`"[$]toolsPath\\)[^`"]*`""= "`${1}$($Latest.FileName64)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
      "(?i)(\-SoftwareName\s+)'.*'"       = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  # https://build.tox.chat/view/qtox/job/qTox_pkg_windows_x86_stable_release/lastSuccessfulBuild/artifact/setup-qtox.exe
  $re32 = '.+_x86_.+\.exe$'
  $url32 = $download_page.links | Where-Object href -match $re32 | Select-Object -First 1 -expand href

  # https://build.tox.chat/view/qtox/job/qTox_pkg_windows_x86-64_stable_release/lastSuccessfulBuild/artifact/setup-qtox.exe
  $re64 = '.+_x86-64_.+\.exe$'
  $url64 = $download_page.links | Where-Object href -match $re64 | Select-Object -First 1 -expand href

  $download_page = Invoke-WebRequest -Uri $changelog
  $reVersion = '<h2><a.+/a>v(.+) \(.+\)</h2>'
  $download_page.Content -match $reVersion

  if (!$Matches) {
    throw "qtox version not found on $releases"
  }

  $version = $Matches[1];
  @{
    URL32 = $url32
    URL64 = $url64
    Version = $version
  }
}

update -ChecksumFor none
