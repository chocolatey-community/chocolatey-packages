import-module au

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix 
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
      "(?i)(^\s*file64\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName64)`""
    }
    ".\tools\verification.txt" = @{
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(64-Bit.+)\<.*\>" = "`${1}<$($Latest.URL64)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
      "(?i)(checksum64:\s+).*" = "`${1}$($Latest.Checksum64)"
    }
    "eid-belgium.nuspec" = @{
      "\<(releaseNotes)\>.*\<\/releaseNotes\>" = "<`$1>$($Latest.ReleaseNotes)</`$1>"
    }
  }
}

function global:au_GetLatest {

  $tags = Invoke-WebRequest 'https://api.github.com/repos/fedict/eid-mw/tags' | ConvertFrom-Json
  
  foreach ($tag in $tags) {
    $url32 = "https://eid.belgium.be/sites/default/files/software/beidmw_32_$($tag.Name -Replace '[A-Za-z]*','').msi"
    Write-Host "Checking: $url32"
    try {
        (Invoke-WebRequest -Uri $url32 -UseBasicParsing -DisableKeepAlive -Method HEAD).StatusCode
        $version32 = $tag.Name -Replace '[A-Za-z]*',''
        break
    } catch [Net.WebException] {
        [int]$_.Exception.Response.StatusCode
        continue
    }
  }
  
  if (!$version32) {
    throw "The URL to the 32 bits installer was not found. This shouldn't happen. Maybe upstream changed their URLs?"
  }
  
  foreach ($tag in $tags) {
    $url64 = "https://eid.belgium.be/sites/default/files/software/beidmw_64_$($tag.Name -Replace '[A-Za-z]*','').msi"
    Write-Host "Checking: $url64"
    try {
        (Invoke-WebRequest -Uri $url64 -UseBasicParsing -DisableKeepAlive -Method HEAD).StatusCode
        $version64 = $tag.Name -Replace '[A-Za-z]*',''
        break
    } catch [Net.WebException] {
        [int]$_.Exception.Response.StatusCode
        continue
    }
  }
  
  if (!$version64) {
    throw "The URL to the 64 bits installer was not found. This shouldn't happen. Maybe upstream changed their URLs?"
  }
  
  if ($version32.ToString() -ne $version64.ToString()) {
    throw "The detected 32 and 64 bits installers are not the same version. This shouldn't happen. Maybe upstream changed their URLs?"
  }
  
  # Determine release notes URL
  foreach ($tag in $tags) {
    $urlReleaseNotes = "https://eid.belgium.be/sites/default/files/content/pdf/rn$($tag.Name -Replace '[a-zA-Z._]*','').pdf"
    try {
        Write-Host "Checking: $urlReleaseNotes"
        (Invoke-WebRequest -Uri $urlReleaseNotes -UseBasicParsing -DisableKeepAlive -Method HEAD).StatusCode
        break
    } catch [Net.WebException] {
        [int]$_.Exception.Response.StatusCode
        continue
    }
    if (!$urlReleaseNotes) {
      throw "The URL to the release notes was not found. This shouldn't happen. Maybe upstream changed their URLs?"
    }
  }

  return @{
    URL32 = $url32
    URL64 = $url64
    Version = $version64
    ReleaseNotes = $urlReleaseNotes
  }
}

update -ChecksumFor none
