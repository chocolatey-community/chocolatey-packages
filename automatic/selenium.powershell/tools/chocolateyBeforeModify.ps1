$ErrorActionPreference = 'Stop'

$ModuleName = "Selenium"

# The module shouldn't be present in the Chocolatey session, but...
if (Get-Module $ModuleName) {
  Remove-Module $ModuleName -Force -ErrorAction SilentlyContinue
}