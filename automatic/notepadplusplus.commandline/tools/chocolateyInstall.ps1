Install-ChocolateyZipPackage 'notepadplusplus.commandline' '{{DownloadUrl}}' "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
