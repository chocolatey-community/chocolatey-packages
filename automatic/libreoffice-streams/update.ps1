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
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
      "(?i)(^\s*version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
    }
    ".\libreoffice-streams.nuspec"  = @{
      "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
    }
  }

  $linesToPatch = $filesToPatchHashTable[".\tools\chocolateyInstall.ps1"]
  if ($Latest.FileType -eq "exe") {
    $linesToPatch["(?i)(^\s*silentArgs\s*=\s*)('.*')"] = "`$1'/S'"
  } else {
    $linesToPatch["(?i)(^\s*silentArgs\s*=\s*)('.*')"] = "`$1'/qn /norestart /l*v `"$(`$env:TEMP)\`$(`$packageName).`$(`$env:chocolateyPackageVersion).MsiInstall.log`"'"
  }
  $filesToPatchHashTable[".\tools\chocolateyInstall.ps1"] = $linesToPatch

  return $filesToPatchHashTable
}

function global:au_AfterUpdate {
  # Patch the json stream file
  $global:streamsJson | ConvertTo-Json | Set-Content .\libreoffice-streams.json
}

function global:au_GetLatest {

  $global:streamsJson = (Get-Content .\libreoffice-streams.json) | ConvertFrom-Json

  $stillVersionFrom = $global:streamsJson.still
  $stillVersionTo = GetLatestStillVersionFromLibOUpdateChecker
  $freshVersionFrom = $global:streamsJson.fresh
  $freshVersionTo = GetLatestFreshVersionFromLibOUpdateChecker

  $global:streamsJson.still = $stillVersionTo
  $global:streamsJson.fresh = $freshVersionTo

  $streams = New-Object -TypeName System.Collections.Specialized.OrderedDictionary
  AddLibOVersionsToStreams $streams "still" $stillVersionFrom $stillVersionTo
  AddLibOVersionsToStreams $streams "fresh" $freshVersionFrom $freshVersionTo

  return @{ Streams = $streams }
}

update -ChecksumFor none