$commProgs = Join-Path `
	([environment]::getfolderpath('CommonApplicationData')) `
	"Microsoft\Windows\Start Menu\Programs"
$userProgs = [environment]::getfolderpath('Programs')
Remove-Item -Path "$commProgs\VirtualDub.lnk" -ErrorAction SilentlyContinue
Remove-Item -Path "$userProgs\VirtualDub.lnk" -ErrorAction SilentlyContinue
