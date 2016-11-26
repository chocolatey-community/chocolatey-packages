import-module au
. "$PSScriptRoot\update_helper.ps1"

$releases = 'https://www.mozilla.org/en-US/firefox/all/'
$product  = 'firefox'

function global:au_SearchReplace {
  $version = $Latest.RemoteVersion
  $softwareName = 'Mozilla Firefox'

  CreateChecksumsFile -ToolsDirectory "$PSScriptRoot\tools" `
    -ExecutableName "Firefox Setup $version.exe" `
    -Version $version

  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)('.*')"      = "`$1'$($Latest.PackageName)'"
      "(?i)(^[$]softwareName\s*=\s*)('.*')"     = "`$1'$softwareName'"
      "(?i)(^[$]allLocalesListURL\s*=\s*)('.*')"= "`$1'$($Latest.LocaleURL)'"
      "(?i)(-version\s*)('.*')"                 = "`$1'$($Latest.RemoteVersion)'"
      '(?i)(\s*Url\s*=\s*)(".*")'               = "`$1`"$($Latest.Win32Format)`""
      '(?i)(\.Url64\s*=\s*)(".*")'              = "`$1`"$($Latest.Win64Format)`""
    }
    ".\tools\chocolateyUninstall.ps1" = @{
      "(?i)(^[$]packageName\s*=\s*)('.*')"      = "`$1'$($Latest.PackageName)'"
      "(?i)(-SoftwareName\s*)('.*')"            = "`$1'$softwareName*'"
    }
  }
}

function global:au_GetLatest {
  $data  = GetVersionAndUrlFormats -UpdateUrl $releases -Product $product

  @{
    LocaleURL = "$releases"
    Version = $data.Version
    RemoteVersion = $data.Version
    Win32Format = $data.Win32Format
    Win64Format = $data.Win64Format
  }
}

update -NoCheckUrl -ChecksumFor none
