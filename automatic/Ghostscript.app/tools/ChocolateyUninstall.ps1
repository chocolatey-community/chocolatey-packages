. (Join-Path (Split-Path -parent $MyInvocation.MyCommand.Definition) chocolateyInclude.ps1)

$uninstallPath = (Get-ItemProperty $uninstallRegKey UninstallString).UninstallString
Start-ChocolateyProcessAsAdmin -exeToRun $uninstallPath  -statements '/S'
