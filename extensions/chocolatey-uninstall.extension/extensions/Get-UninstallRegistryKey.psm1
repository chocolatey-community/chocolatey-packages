function Get-UninstallRegistryKey {
<#
.SYNOPSIS
Retrieve registry key(s) for system-installed applications from an 
exact or wildcard search.

.DESCRIPTION
This function will attempt to retrieve a matching registry key for an
already installed application, usually to be used with a 
chocolateyUninstall.ps1 automation script.

The function also prevents `Get-ItemProperty` from failing when 
handling wrongly encoded registry keys.

.PARAMETER SoftwareName
Part or all of the Display Name as you see it in Programs and Features.
It should be enough to be unique.

If the display name contains a version number, such as "Launchy (2.5)", 
it is recommended you use a fuzzy search `"Launchy (*)"` (the wildcard `*`)
so if Launchy auto-updates or is updated outside of chocolatey, the 
uninstall script will not fail.

Take care not to abuse fuzzy/glob pattern searches. Be conscientious of
programs that may have shared or common root words to prevent overmatching.
"SketchUp*" would match two keys with software names "SketchUp 2016" and 
"SketchUp Viewer" that are different programs released by the same company.

.INPUTS
System.String

.OUTPUTS
PSCustomObject

This function searches registry objects and returns PSCustomObject of the
matched key's properties.

Retrieve properties with dot notation, for example: $key.UninstallString

.NOTES
This helper reduces the number of lines one would have to write to 
retrieve registry keys to 1 line. It also prevents Get-ItemProperty from
failing when handling wrongly encoded registry keys.

Using this function in a package requires adding the extension as a
dependency. Add the following to the nuspec:

<dependencies>
  <dependency id="chocolatey-uninstall.extension" />
</dependencies>

.EXAMPLE
[array]$key = Get-UninstallRegistryKey -SoftwareName "VLC media player"
$key.UninstallString

Exact match: software name in Programs and Features is "VLC media player"

.EXAMPLE
[array]$key = Get-UninstallRegistryKey -SoftwareName "Gpg4win (*)"
$key.UninstallString

Version match: software name is "Gpg4Win (2.3.0)"

.EXAMPLE
[array]$key = Get-UninstallRegistryKey -SoftwareName "SketchUp [0-9]*"
$key.UninstallString

Version match: software name is "SketchUp 2016"
Note that the similar software name "SketchUp Viewer" would not be matched.

.LINK
Uninstall-ChocolateyPackage
#>
  [CmdletBinding()]
  param(
    [Parameter(Mandatory=$true, Position=0, ValueFromPipeline=$true)]
    [ValidateNotNullOrEmpty()]
    [string] $softwareName,
    [Parameter(ValueFromRemainingArguments = $true)][Object[]] $ignoredArguments
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
  Write-Debug "If such a key is found, loop up to 10 times to try to bypass all badKeys"
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
      Write-Verbose "Skipping bad key: $badKey"
      [array]$keys = $keys | Where-Object {$badKey -NotContains $_.PsPath}
    }
    
    if ($success) {break;}
  }
  
  return $foundKey
}