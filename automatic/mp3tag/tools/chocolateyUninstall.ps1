$uninstString = (Get-ChildItem -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' |
    Get-ItemProperty |
    Where-Object {$_.DisplayName -match 'Mp3tag' } |
    Select-Object -Property DisplayName, UninstallString).uninstallString

if ($uninstString) {
    Uninstall-ChocolateyPackage '{{PackageName}}' 'exe' '/S' $uninstString
}
