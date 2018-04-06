import-module au

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.Url32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_BeforeUpdate() {
  $pp = $global:ProgressPreference
  $global:ProgressPreference = 'SilentlyContinue'
  try
  {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
    $Latest.ChecksumType32 = 'SHA256'
  }
  finally
  {
    $global:ProgressPreference = $pp
  }
}

function global:au_GetLatest {
  $exeUrl = 'https://go.skype.com/classic.skype'

  $exePath = [System.IO.Path]::GetTempFileName()
  $ProgressPreference = 'SilentlyContinue'
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
