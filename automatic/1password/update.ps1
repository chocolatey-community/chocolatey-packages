Import-Module AU
import-module $PSScriptRoot\..\..\extensions\chocolatey-core.extension\extensions\chocolatey-core.psm1

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)^(\s*url\s*=\s*)'.*'"                = "`${1}'$($Latest.URL32)'"
      "(?i)^(\s*checksum\s*=\s*)'.*'"           = "`${1}'$($Latest.Checksum32)'"
      "(?i)^(\s*checksumType\s*=\s*)'.*'"       = "`${1}'$($Latest.ChecksumType32)'"
      "(?i)^(\s*silentArgs\s*=\s*)['`"].*['`"]" = "`${1}`"$($Latest.SilentArgs)`""
    }
  }
}

function global:au_AfterUpdate {
  . "$PSScriptRoot/update_helper.ps1"
  if ($Latest.PackageName -eq '1password4') {
    removeDependencies ".\*.nuspec"
    addDependency ".\*.nuspec" "chocolatey-core.extension" "1.3.3"
  }
  else {
    addDependency ".\*.nuspec" 'dotnet4.7.2' '4.7.2.20180712'
  }
}

function global:au_BeforeUpdate {
  if ($Latest.PackageName -eq '1password4') {
    $Latest.SilentArgs = '/VERYSILENT /NORESTART /SUPPRESSMSGBOXES /SP- /LOG=`"$($env:TEMP)\$($env:chocolateyPackageName).$($env:chocolateyPackageVersion).InnoInstall.log`"'
  }
  else {
    $Latest.SilentArgs = '--silent'
  }
}

function Get-LatestOPW {
  param (
    [string]$url,
    [string]$kind

  )

  $url32 = Get-RedirectedUrl $url
  $verRe = 'Setup-|word-|\.exe$'
  $version = $url32 -split $verRe | select -last 1 -skip 1
  $version = $version -replace ('\.BETA', ' beta')
  $version = Get-Version $version
  $major = $version.ToString(1)

  @{
    URL32       = $url32
    Version     = $version.ToString()
    PackageName = $kind
  }
}

$releases = 'https://downloads.1password.com/win/1PasswordSetup-8.8.0.exe'

function global:au_GetLatest {
  $destination = Join-Path -Path $env:TEMP -ChildPath '1PasswordSetup-8.8.0.exe'
  Invoke-WebRequest -Uri $releases -UseBasicParsing -OutFile $destination

  (Get-ItemProperty $destination).VersionInfo.ProductVersion

  $version = Get-Item $destination | ForEach-Object { [System.Diagnostics.FileVersionInfo]::GetVersionInfo($_).FileVersion }
  $checksum = Get-FileHash $destination | ForEach-Object Hash
  Remove-Item $destination -ErrorAction:Stop
  @{
      Version     = $version
      URL         = $releases
      Checksum    = $checksum
  }
}

update -ChecksumFor 32 -Force:$Force
