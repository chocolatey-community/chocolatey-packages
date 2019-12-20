Import-Module AU

$releases = 'http://www.abelhadigital.com/hostsman'

function global:au_SearchReplace {
  @{
    ".\legal\VERIFICATION.txt" = @{
      "(?i)(^\s*location on\:?\s*)\<.*\>" = "`${1}<$releases>"
      "(?i)(\s*1\..+)\<.*\>" = "`${1}<$($Latest.URL32)>"
      "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
      "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
    }

    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*[$]fileName\s*=\s*)('.*')"= "`$1'$($Latest.FileName)'"
    }
  }
}

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

  # <a class="btn btn-primary btn-lg btn-download" href="https://drive.google.com/uc?export=download&amp;id=0B0N7Pu7pijFBejcxNXlLZVVMSnM">                
  if ($download_page.Content -match '<a .+btn-primary.+btn-download.+ href="([^"]+)"') {
    $url = $Matches[1]
  } else { throw "Can't find download link"}

  iwr $url -OutFile hostsman.zip
  $hash = Get-FileHash hostsman.zip | % Hash
  set-alias 7z $Env:chocolateyInstall\tools\7z.exe
  rm tools\*.exe -ea 0
  7z x $PSScriptRoot\hostsman.zip -otools
  $setupFile = gi tools\*.exe
    
  @{
    Version = $setupFile.VersionInfo.FileVersion.Trim()
    URL32 = $url 
    FileName = $setupFile.Name
    Checksum32 = $hash
    ChecksumType32 = 'sha256'
  }
}

update -ChecksumFor none 
