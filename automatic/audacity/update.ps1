Import-Module Chocolatey-AU

function global:au_SearchReplace {
  $searchReplace = @{
    '.\tools\chocolateyInstall.ps1' = @{
      "(^\s*packageName\s*=\s*)('.*')"           = "`$1'$($Latest.PackageName)'"
      "(?i)(^\s*fileType\s*=\s*)('.*')"          = "`$1'$($Latest.FileType)'"
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*"   = "`${1}$($Latest.FileName64)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }

    '.\legal\VERIFICATION.txt'      = @{
      '(?i)(Go to).*<.*>'   = "`${1} <$($Latest.ReleasePage)>"
      '(?i)(\s+x64:).*'     = "`${1} $($Latest.URL64)"
      '(?i)(checksum64:).*' = "`${1} $($Latest.Checksum64)"
    }
  }
  
  # Only update x32 references if URL32 exists
  if ($Latest.URL32) {
    $searchReplace['.\legal\VERIFICATION.txt']['(?i)(\s+x32:).*'] = "`${1} $($Latest.URL32)"
    $searchReplace['.\legal\VERIFICATION.txt']['(?i)(checksum32:).*'] = "`${1} $($Latest.Checksum32)"
  }
  
  return $searchReplace
}

function global:au_BeforeUpdate {
  Get-RemoteFiles -Purge -NoSuffix
}

function global:au_GetLatest {
  $LatestRelease = Get-GitHubRelease audacity audacity
  
  # Determine file extension and architecture based on version
  # Version 4.0+ uses .msi and drops 32-bit support
  # Version 3.x uses .exe with 32-bit and 64-bit
  $version = [version]($LatestRelease.tag_name.TrimStart('Audacity-'))
  
  if ($version -ge [version]'4.0') {
    # Version 4.0+: MSI installers, 64-bit only
    $fileExt = 'msi'
    $url64 = $LatestRelease.assets | Where-Object {
      $_.name.EndsWith(".msi") -and $_.name -match "x86_64"
    } | Select-Object -First 1 -ExpandProperty browser_download_url
    
    # Return only URL64, no URL32 for version 4.0+
    @{
      URL64       = $url64
      Version     = $LatestRelease.tag_name.TrimStart('Audacity-')
      ReleasePage = $LatestRelease.html_url
      FileType    = $fileExt
    }
  }
  else {
    # Version 3.x: EXE installers with 32-bit and 64-bit
    $fileExt = 'exe'
    $url32 = $LatestRelease.assets | Where-Object {
      $_.name.EndsWith(".exe") -and $_.name -match "-32bit|-x32"
    } | Select-Object -First 1 -ExpandProperty browser_download_url
    $url64 = $LatestRelease.assets | Where-Object {
      $_.name.EndsWith(".exe") -and ($_.name -match "-64bit|-x64")
    } | Select-Object -First 1 -ExpandProperty browser_download_url
    
    @{
      URL32       = $url32
      URL64       = $url64
      Version     = $LatestRelease.tag_name.TrimStart('Audacity-')
      ReleasePage = $LatestRelease.html_url
      FileType    = $fileExt
    }
  }
}

update -ChecksumFor none
