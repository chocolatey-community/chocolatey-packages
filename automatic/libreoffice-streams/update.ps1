import-module au

$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)\tools\"
. $toolsDir\helpers.ps1

function global:au_BeforeUpdate {
  if ($Latest.Title -like '*Fresh*') {
    cp "$PSScriptRoot\README.fresh.md" "$PSScriptRoot\README.md" -Force
  }
  else {
    cp "$PSScriptRoot\README.still.md" "$PSScriptRoot\README.md" -Force
  }
}

function global:au_SearchReplace {
  $filesToPatchHashTable = @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*fileType\s*=\s*)('.*')"    = "`$1'$($Latest.FileType)'"
      "(?i)(^\s*url\s*=\s*)('.*')"         = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')"    = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*version\s*=\s*)('.*')"     = "`$1'$($Latest.Version)'"
    }
    ".\libreoffice-streams.nuspec"  = @{
      "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
    }
  }

  $linesToPatch = $filesToPatchHashTable[".\tools\chocolateyInstall.ps1"]
  if ($Latest.FileType -eq "exe") {
    $linesToPatch["(?i)(^\s*silentArgs\s*=\s*)('.*')"] = "`$1'/S'"
  } else {
    $linesToPatch["(?i)(^\s*silentArgs\s*=\s*)(`".*`")"] = "`$1`"/qn /passive /norestart /l*v `"`$(`$env:TEMP)\`$(`$env:ChocolateyPackageName).`$(`$env:ChocolateyPackageVersion).MsiInstall.log`"`""
  }
  $filesToPatchHashTable[".\tools\chocolateyInstall.ps1"] = $linesToPatch

  return $filesToPatchHashTable
}

function global:au_AfterUpdate {
  # Patch the json stream file
  $global:chocolateyCoreteampackagesLibreofficeStreamJson | ConvertTo-Json | Set-Content .\libreoffice-streams.json
}

function global:au_GetLatest {

  $global:chocolateyCoreteampackagesLibreofficeStreamJson = (Get-Content .\libreoffice-streams.json) | ConvertFrom-Json

  $stillVersionFrom = $global:chocolateyCoreteampackagesLibreofficeStreamJson.still
  $stillVersionTo = GetLatestStillVersionFromLibOUpdateChecker
  $freshVersionFrom = $global:chocolateyCoreteampackagesLibreofficeStreamJson.fresh
  $freshVersionTo = GetLatestFreshVersionFromLibOUpdateChecker

  $global:chocolateyCoreteampackagesLibreofficeStreamJson.still = $stillVersionTo
  $global:chocolateyCoreteampackagesLibreofficeStreamJson.fresh = $freshVersionTo

  $streams = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
  AddLibOVersionsToStreams $streams "still" $stillVersionFrom $stillVersionTo
  AddLibOVersionsToStreams $streams "fresh" $freshVersionFrom $freshVersionTo

  return @{ Streams = $streams }
}

update -ChecksumFor none