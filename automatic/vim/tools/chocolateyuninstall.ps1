$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installDir = Get-Content "$toolsDir\installDir"
$shortversion = '90'
$statement = '-nsis'
$exeToRun  = "$installDir\vim\vim$shortversion\uninstall.exe"

# From vim-tux.install.  Make input.
Set-Content -Path "$env:TEMP\vimuninstallinput" -Value 'y'
Start-Process -FilePath $exeToRun -ArgumentList $statement -RedirectStandardInput "$env:TEMP\vimuninstallinput" -Wait -WindowStyle Hidden
Remove-Item "$env:TEMP\vimuninstallinput"

Remove-Item "$installDir\vim" -Recurse -Force
