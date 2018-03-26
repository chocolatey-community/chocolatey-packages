import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.Url32)'"
        }
    }
}

function global:au_GetLatest {
  $exeUrl = 'https://go.skype.com/classic.skype'

  $exePath = [System.IO.Path]::GetTempFileName()
  Invoke-WebRequest -Uri $exeUrl -OutFile $exePath -UseBasicParsing
  try
  {
    $fileVersion = (Get-Item -Path $exePath).VersionInfo.FileVersion
  }
  finally
  {
    Remove-Item -Path $exePath -ErrorAction SilentlyContinue
  }

  @{
    Url32 = 'https://download.skype.com/msi/SkypeSetup_{0}.msi' -f $fileVersion
    Version = $fileVersion
  }
}

update -ChecksumFor none
