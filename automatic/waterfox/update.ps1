import-module au

$releases = 'https://www.waterfoxproject.org/downloads'
$softwareName = 'Waterfox*'

function global:au_BeforeUpdate {
  $Latest.ChecksumType64 = 'sha256'
  $fileName = $Latest.URL64 -split '/' | select -last 1
  $fileName = ($fileName -replace '%20',' ').TrimEnd('.exe')
  Get-RemoteFiles -Purge -FileNameBase $fileName
  $Latest.FileName64 = $fileName + "_x64.exe"
}

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(listed on\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(1\..+)\<.*\>"        = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:).*"   = "`${1} $($Latest.ChecksumType64)"
      "(?i)(checksum:).*"        = "`${1} $($Latest.Checksum64)"
    }

    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(`"`[$]toolsDir\\).*`""        = "`${1}$($Latest.FileName64)`""
      "(?i)(^\s*softwareName\s*=\s*)'.*'" = "`${1}'$softwareName'"
      "(?i)(^\s*packageName\s*=\s*)'.*'"  = "`${1}'$($Latest.PackageName)'"
    }

    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)'.*'" = "`${1}'$($Latest.PackageName)'"
      "(?i)(\s*\-SoftwareName\s+)'.*'"   = "`${1}'$softwareName'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  $re    = 'Setup\.exe$'
  $url   = $download_page.links | ? href -match $re | select -First 1 -expand href

  $version  = $url -split '%20' | select -Last 1 -Skip 1

  return @{ URL64 = $url; Version = $version }
}

update -ChecksumFor none
