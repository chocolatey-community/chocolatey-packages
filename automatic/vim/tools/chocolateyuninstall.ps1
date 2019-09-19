$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$shortversion = '81'
$statement = '-nsis'
$exeToRun  = "$toolsDir\vim\vim$shortversion\uninstal.exe"
# From vim-tux.install.  Make input.
Set-Content -Path "$env:TEMP\vimuninstallinput" -Value 'y'
Join-Path $env:windir 'vimtutor.bat' | Remove-Item
Start-Process -FilePath $exeToRun -ArgumentList $statement -RedirectStandardInput "$env:TEMP\vimuninstallinput" -Wait -WindowStyle Hidden
Remove-Item "$env:TEMP\vimuninstallinput"
