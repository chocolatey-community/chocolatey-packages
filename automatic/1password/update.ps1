param($IncludeStream = $global:au_IncludeStream, $Force)

Import-Module Chocolatey-AU

if (($IncludeStream -match "^OPW(?<major>\d+)") -and (Test-Path "$PSScriptRoot\..\..\manual\1password$($Matches['major'])")) {
  # Since this is a manual package, we will assume that the package itself needs to be updated.
  Push-Location "$PSScriptRoot\..\..\manual\1password$($Matches['major'])"
  try {
    $oldVersion = $global:au_Version
    . "./update.ps1" -NoUpdateCheck
    $packages = Get-ChildItem "*.nupkg"

    if ($packages) {
      Copy-Item $packages -Destination $PSScriptRoot
      # We also need to commit any changes, but only do this when running in a CI environment
      if ($env:APPVEYOR -eq $true) {
        git add . --update
      }
    }

    if ($oldVersion) {
      $global:au_Version = $oldVersion
    } else {
      $global:au_Version = $global:Latest.Version.ToString()
    }
    $global:au_Latest = $null
    $global:Latest = $null
  }
  finally {
    Pop-Location
  }
}
else {
  Get-ChildItem "$PSScriptRoot\..\1password*" | Where-Object { $_.Name -ne '1password' } | ForEach-Object {
    . "$_\update.ps1"
  }
}

function global:au_BeforeUpdate($Package) {
  # This is done in the before update, otherwise the dependency is not updated.
  $readmePath = $Latest.Readme

  if ($readmePath -and (Test-Path $readmePath)) {
    Set-DescriptionFromReadme $Package -SkipFirst 2 -ReadmePath $readmePath
  }
}

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(?i)(\<dependency .+?)`"1password\d*(`" version=)`"([^`"]+)`"" = "`$1`"$($Latest.DependencyName)`$2`"[$($Latest.Version)]`""
    }
  }
}

function global:au_AfterUpdate {
  . "$PSScriptRoot\..\..\scripts\Update-IconUrl.ps1" -Name '1password' -IconName $Latest.DependencyName -ThrowErrorOnIconNotFound
}


function global:au_GetLatest {
  $commands = Get-Command "Find-1Password*"

  $streams = @{}

  $null = $commands | ForEach-Object {
    $result = & $_
    $streams.Add('OPW' + $result.VersionMajor, $result)
  }

  return @{ Streams = $streams }
}

update -ChecksumFor None -IncludeStream $IncludeStream -Force:$Force
