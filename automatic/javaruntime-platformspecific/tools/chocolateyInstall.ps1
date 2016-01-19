$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
# Import function to test if JRE in the same version is already installed
Import-Module (Join-Path $scriptDir 'thisJreInstalled.ps1')

$packageName = '{{PackageName}}'
# Find download URLs at http://www.java.com/en/download/manual.jsp
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'
$version = '{{PackageVersion}}'
$versionMajor = $version -replace '^(\d+)\..*', '$1'
$installerType = 'exe'
$installArgs = '/s REBOOT=Suppress SPONSORS=0'

# If both 32- and 64-bit versions are installed, it adds only the folder
# of the 64-bit version to the env variables
$javaHome = Join-Path $env:ProgramFiles "Java\jre$versionMajor"
$jreForPathVariable = Join-Path $javaHome 'bin'

$thisJreInstalledHash = thisJreInstalled($version)
$osBitness = Get-ProcessorBits

# This is the code for both javaruntime and javaruntime-platformspecific packages.
# If the package is javaruntime-platformspecific, only install the jre version
# based on the OS bitness, otherwise install both 32- and 64-bit versions
if ($packageName -match 'platformspecific') {
  if ($thisJreInstalledHash.x86_32 -or $thisJreInstalledHash.x86_64) {
    Write-Output "Java Runtime Environment $version is already installed. Skipping download and installation to avoid 1603 errors."
  } else {
    Install-ChocolateyPackage $packageName $installerType $installArgs $url $url64
  }
} else {
  # Otherwise it is the javaruntime package which installs both 32- and 64-bit jre versions on 64-bit systems

  # Checks if JRE 32/64-bit in the same version is already installed,
  # otherwise it downloads and installs it.
  # This is to avoid unnecessary downloads and 1603 errors.
  if ($thisJreInstalledHash.x86_32) {
    Write-Output "Java Runtime Environment $version (32-bit) is already installed. Skipping download and installation"
  } else {
    Install-ChocolateyPackage $packageName $installerType $installArgs $url
  }

  # Only check for the 64-bit version if the system is 64-bit

  if ($osBitness -eq 64) {
    if ($thisJreInstalledHash.x86_64) {
      Write-Output "Java Runtime Environment $version (64-bit) is already installed. Skipping download and installation"
    } else {
      # Here $url64 is used twice to obtain the correct message from Chocolatey
      # that it installed the 64-bit version, otherwise it would display 32-bit,
      # regardless of the actual bitness of the software.
      Install-ChocolateyPackage $packageName $installerType $installArgs $url64 $url64
    }
  }
}

# Only set the entry for the PATH variable and the JAVA_HOME env variable
# if the same version of JRE was not already installed (32- or 64-bit separately)
if (!($thisJreInstalledHash.x86_32) -or !($thisJreInstalledHash.x86_64)) {
  Install-ChocolateyPath $jreForPathVariable 'Machine'
   Start-ChocolateyProcessAsAdmin @"
[Environment]::SetEnvironmentVariable('JAVA_HOME', '$javaHome', 'Machine')
"@
}
