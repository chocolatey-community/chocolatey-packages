$validExitCodes = @(0,1223)
Install-ChocolateyPackage '{{PackageName}}' 'exe' '/S' '{{DownloadUrl}}' -validExitCodes $validExitCodes