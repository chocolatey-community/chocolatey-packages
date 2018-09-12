import-module au

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix 
}

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
    }
    ".\tools\verification.txt" = @{
      "(?i)(32-Bit.+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(checksum type:\s+).*" = "`${1}$($Latest.ChecksumType32)"
      "(?i)(checksum32:\s+).*" = "`${1}$($Latest.Checksum32)"
    }
    "eid-belgium-viewer.nuspec" = @{
      "\<(releaseNotes)\>.*\<\/releaseNotes\>" = "<`$1>$($Latest.ReleaseNotes)</`$1>"
    }
  }
}

function global:au_GetLatest {

  $url = "https://eid.belgium.be/en/colorbox/nl/download/41/license"
  $content = Invoke-WebRequest -Uri $url -UseBasicParsing
  $parsedContent = $content | ConvertFrom-Json
  $parser = New-Object -Com "HTMLFile"
  $parser.IHTMLDocument2_write([string]$parsedContent[1])
  foreach ($i in $parser.getElementsByTagName("a") ) {
    if ($i.href.endswith("msi")) {
      $viewerUrl = $i.href.trim()
      break;
    }
  }
  
  if (!$viewerUrl) {
    throw "The viewer URL is empty. Maybe upstream changed their URLs?"
  }
  
  $version = $viewerUrl.split('_')[1].replace(".msi","")
  
  # Determine release notes URL
  $tags = Invoke-WebRequest 'https://api.github.com/repos/fedict/eid-mw/tags' | ConvertFrom-Json
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
    URL32 = $viewerUrl
    Version = $version
    ReleaseNotes = $urlReleaseNotes
  }
}

update -ChecksumFor none
