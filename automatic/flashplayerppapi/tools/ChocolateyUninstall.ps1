$registryPaths = @(
  'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
  'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
)

$uninstallString = (Get-ChildItem -Path $registryPaths |
    Get-ItemProperty |
    Where-Object {$_.DisplayName -match 'Mp3tag' } |
    Select-Object -Property DisplayName, UninstallString).uninstallString -replace "maintain","uninstall"

if ($uninstString) {
    Uninstall-ChocolateyPackage 'flashplayerppapi' 'exe' '' $uninstString
}
