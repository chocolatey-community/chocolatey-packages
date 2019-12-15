$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Get-Content -Path "$toolsDir\installDir"
$shortversion = '82'
$statement = '-nsis'
$exeToRun  = "$installDir\vim\vim$shortversion\uninstall.exe"
# From vim-tux.install.  Make input.
Set-Content -Path "$env:TEMP\vimuninstallinput" -Value 'y'
Join-Path $env:windir 'vimtutor.bat' | Remove-Item
Start-Process -FilePath $exeToRun -ArgumentList $statement -RedirectStandardInput "$env:TEMP\vimuninstallinput" -Wait -WindowStyle Hidden
Remove-Item "$env:TEMP\vimuninstallinput"
Remove-Item -Recurse "$installDir\vim"
