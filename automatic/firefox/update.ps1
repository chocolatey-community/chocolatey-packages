import-module au
. "$PSScriptRoot\update_helper.ps1"

$releases = 'https://www.mozilla.org/en-US/firefox/all/'
$product  = 'firefox'

function global:au_AfterUpdate {
  $version = $Latest.RemoteVersion
  CreateChecksumsFile -ToolsDirectory "$PSScriptRoot\tools" `
    -ExecutableName "Firefox Setup $version.exe" `
    -Version $version `
    -Product $product
}

function global:au_SearchReplace {
  $version = $Latest.RemoteVersion

  SearchAndReplace -PackageDirectory "$PSScriptRoot" `
    -Data $Latest
}

function global:au_GetLatest {
  $data  = GetVersionAndUrlFormats -UpdateUrl $releases -Product $product

  @{
    LocaleURL = "$releases"
    Version = $data.Version
    RemoteVersion = $data.Version
    Win32Format = $data.Win32Format
    Win64Format = $data.Win64Format
    SoftwareName = 'Mozilla Firefox'
    ReleaseNotes = "https://www.mozilla.org/en-US/firefox/$($data.Version)/releasenotes/"
    PackageName = 'Firefox'
  }
}

update -ChecksumFor none
