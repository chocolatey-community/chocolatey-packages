function Get-InstallProperties() {
  return (
    Get-ChildItem -ErrorAction SilentlyContinue -Path `
    'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall',
    'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall' |
    Get-ItemProperty |
    Where-Object {$_.DisplayName -match '^maxima-[\d\.]+$' } |
    Select-Object -Property DisplayName, UninstallString, DisplayVersion
  ) | Select -First 1
}
