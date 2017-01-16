Install-ChocolateyZipPackage 'putty' '{{DownloadUrl}}'  "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
