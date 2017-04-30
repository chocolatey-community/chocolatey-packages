$commProgs = [environment]::getfolderpath('CommonPrograms')
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item -Path "$commProgs\VirtualDub.lnk" -ErrorAction SilentlyContinue
Remove-Item -Path "$userProgs\VirtualDub.lnk" -ErrorAction SilentlyContinue
