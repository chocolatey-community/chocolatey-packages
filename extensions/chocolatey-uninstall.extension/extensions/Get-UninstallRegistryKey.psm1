function Get-UninstallRegistryKey {
<#
.SYNOPSIS
  Retrieve registry uninstall key(s)

.DESCRIPTION
  This function will attempt to retrieve a matching registry key to be used
  within a chocolateyUninstall.ps1 script.

.PARAMETER SoftwareName
  Part or all of the Display Name as you see it in Programs and Features.
  It should be enough to be unique.

.EXAMPLE
  [array]$key = Get-UninstallRegistryKey -SoftwareName "Gpg4win (2.3.0)"
  [array]$key = Get-UninstallRegistryKey -SoftwareName "Launchy 2.5"
  [array]$key = Get-UninstallRegistryKey -SoftwareName "Mozilla Firefox*"
  
  $key.UninstallString
  
.INPUTS
  Accepts [string]

.OUTPUTS
  This script searches registry objects and returns PSCustomObject of the
  matched key's properties.
  
  Retrieve properties with dot notation, for example: $key.UninstallString

.NOTES
  This helper reduces the number of lines one would have to write to 
  retrieve registry keys to 1 line. It also prevents Get-ItemProperty from
  failing when handling wrongly encoded registry keys.
  
  Using this function in a package requires adding the extension as a
  dependency. Add the following the nuspec:
  
  <dependencies>
    <dependency id="chocolatey-uninstall.extension" />
  </dependencies>

.LINK
  Uninstall-ChocolateyPackage
#>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$True,
    ValueFromPipeline=$True)]
    [ValidateNotNullOrEmpty()]
    [string] $softwareName
  )
  Write-Debug "Running 'Get-UninstallRegistryKey' for `'$env:ChocolateyPackageName`' with SoftwareName:`'$softwareName`'";

  $ErrorActionPreference = 'Stop'
  $local_key       = 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
  $machine_key     = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\*'
  $machine_key6432 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'

  Write-Verbose "Retrieving all uninstall registry keys"
  [array]$keys = Get-ChildItem -Path @($machine_key6432, $machine_key, $local_key) `
                               -ErrorAction SilentlyContinue

  Write-Debug "Error handling check: Get-ItemProperty will fail if a registry key is written incorrectly."
  Write-Debug "If such a key is found, loop to try to bypass all badKeys"
  [int]$maxAttempts = 10
  for ([int]$attempt = 1; $attempt -le $maxAttempts; $attempt++) {
    [bool]$success = $FALSE
    
    try {
      [array]$foundKey = Get-ItemProperty -Path $keys.PsPath `
                                          -ErrorAction SilentlyContinue `
                         | Where-Object {$_.DisplayName -like $softwareName}
      $success = $TRUE
    } catch {
      Write-Debug "Found bad key."
      foreach ($key in $keys){try{Get-ItemProperty $key.PsPath > $null}catch{$badKey = $key.PsPath}}
      Write-Verbose "Skipping bad key: $($key.PsPath)"
      [array]$keys = Get-ChildItem -Path @($machine_key6432, $machine_key, $local_key) `
                                   -ErrorAction SilentlyContinue `
                     | Where-Object {$badKey -NotContains $_.PsPath}
    }
    
    if ($success) {break;}
  }
  
  return $foundKey
}