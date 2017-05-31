import-module au
. "$PSScriptRoot\..\Firefox\update_helper.ps1"

$releases = 'https://www.mozilla.org/en-US/firefox/organizations/all/'
$product  = 'firefox' # not a typo

function global:au_AfterUpdate {
  $version = $Latest.RemoteVersion
  CreateChecksumsFile -ToolsDirectory "$PSScriptRoot\tools" `
    -ExecutableName "Firefox Setup ${version}esr.exe" `
    -Version $version `
    -Product $product `
    -ExtendedRelease
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
    SoftwareName = 'Mozilla Firefox*ESR'
    ReleaseNotes = "https://www.mozilla.org/en-US/firefox/$($data.Version)/releasenotes/"
    PackageName = 'FirefoxESR'
  }
}

update -ChecksumFor none
