$packageName = '{{PackageName}}'
$installerType = 'EXE'
$silentArgs = '/S'
$validExitCodes = @(0)

$osBitness = Get-ProcessorBits

$regKey = "hklm:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\PowerISO";
  
if ($osBitness -eq 64) {
  $regKey = "hklm:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\PowerISO";
}
  
$file = (Get-ItemProperty -Path $regKey).UninstallString
Uninstall-ChocolateyPackage -PackageName $packageName -FileType $installerType -SilentArgs $silentArgs -validExitCodes $validExitCodes -File $file
