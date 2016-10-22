function Get-InstallProperties() {
  return (
    Get-ChildItem -ErrorAction SilentlyContinue -Path `
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' |
    Get-ItemProperty |
    Where-Object {$_.DisplayName -match '^KeePass Password Safe 1\.\d+$' } |
    Select-Object -Property InstallLocation
  ) | Select -First 1
}
