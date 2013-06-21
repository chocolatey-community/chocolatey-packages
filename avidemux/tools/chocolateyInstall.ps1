$validExitCodes = @(0,1223)
Install-ChocolateyPackage 'avidemux' 'exe' '/S' '{{DownloadUrl}}' -validExitCodes $validExitCodes