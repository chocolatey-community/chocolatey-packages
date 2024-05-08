$ErrorActionPreference = 'Stop'
$toolsDir = Split-Path $MyInvocation.MyCommand.Definition
. $toolsDir\helpers.ps1

if (Get-OSArchitectureWidth 32) {
  throw "Sonatype Nexus Repository 3.0 and greater only supports 64-bit Windows."
}

$Version = '3.68.0-04'
$NexusVersionedFolder = "nexus-$Version"
$TargetFolder = "$env:ProgramData\nexus"
$ExtractFolder = "$env:TEMP\NexusExtract"
$TargetDataFolder = "$env:ProgramData\sonatype-work"
$NexusConfigFile = "$TargetDataFolder\nexus3\etc\nexus.properties"
$ServiceName = 'nexus'

# Handle Package Parameters
$pp = Get-PackageParameters

$Hostname = if ($pp.ContainsKey("Fqdn")) {
  $pp["Fqdn"]
} else {
  "localhost"
}

$NexusPort = if ($pp.ContainsKey("Port")) {
  $pp["Port"]
  Write-Host "/Port was used, Nexus will listen on port $($NexusPort)."
} else {
  "8081"
}

if (Test-Path "$env:ProgramFiles\nexus\bin") {
  throw "Previous version of Nexus 3 installed by setup.exe is present, please uninstall before running this package."
}

if ((Get-Service $ServiceName -ErrorAction SilentlyContinue)) {
  Write-Warning "Nexus web app is already present, shutting it down so that we can upgrade it."
  Get-Service $ServiceName | Stop-Service -Force
}

if ($pp.ContainsKey("BackupSslConfig")) {
  if ($pp.ContainsKey("BackupLocation")) {
    Backup-NexusSSL -BackupLocation $pp["BackupLocation"]
  } else {
    Backup-NexusSSL
  }
}

# Extract the Nexus program files, and overwrite any previous program files
if (Test-Path "$ExtractFolder") {
  Remove-Item "$ExtractFolder" -Recurse -Force
}

$PackageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $ExtractFolder
  url64          = 'https://sonatype-download.global.ssl.fastly.net/repository/downloads-prod-group/3/nexus-3.68.0-04-win64.zip'
  checksum64     = '90e11f2cd38dd451c7ca2f961b8c14b03a6ed205f48fc68b490462627879e92a'
  checksumType64 = 'SHA256'
}

Install-ChocolateyZipPackage @PackageArgs

Write-Host "Copying files to '$TargetFolder' with overwrite"
if (Test-Path "$TargetFolder") {
  Copy-Item "$ExtractFolder\$nexusversionedfolder\*" "$TargetFolder" -Force -Recurse
} else {
  Copy-Item "$ExtractFolder\$nexusversionedfolder" "$TargetFolder" -Force -Recurse
}

# Create the Nexus data directory, if it doesn't exist
if (!(Test-Path "$TargetDataFolder")) {
  Move-Item "$extractfolder\sonatype-work" "$TargetDataFolder"
} else {
  Write-Warning "`"$TargetDataFolder`" already exists, not overwriting, residual data from previous installs will not be reset."
}

Remove-Item "$ExtractFolder" -Force -Recurse

# Install the Nexus service
$processArgs = @{
  ExeToRun       = "$TargetFolder\bin\nexus.exe"
  Statements     = "/install $servicename"
  ValidExitCodes = @(0)
}

$null = Start-ChocolateyProcessAsAdmin @processArgs

if ($pp.ContainsKey("BackupSslConfig")) {
  if ($pp.ContainsKey("BackupLocation")) {
    Restore-NexusSSL -BackupLocation $pp['BackupLocation']
  } else {
    Restore-NexusSSL
  }
}

# Update Port in Configuration before starting the service
if ($NexusPort -ne '8081') {
  if (Test-Path "$NexusConfigFile") {
    Write-Host "Configuring Nexus to listen on port $NexusPort."
        (Get-Content "$NexusConfigFile") -replace "^#\s*application-port=.*$", "application-port=$NexusPort" |
    Set-Content "$NexusConfigFile"
  } else {
    Write-Warning "Cannot find `"$NexusConfigFile`", skipping configuring Nexus to listen on port $NexusPort."
  }
}

# Start the service, and wait for the site to become available
if ((Start-Service $ServiceName -PassThru).Status -eq 'Running') {
  Wait-NexusAvailability -Hostname $Hostname -Port $NexusPort -Config $NexusConfigFile -SSL:$pp.ContainsKey("BackupSslConfig")
} else {
  Write-Warning "The Nexus Repository service ($ServiceName) did not start."
}

$generatedAdminPasswordFile = Join-Path $TargetDataFolder '\nexus3\admin.password'
Write-Host -ForegroundColor Yellow @"
*******************************************************************************************
*
*  You MAY receive the error 'localhost refused to connect.' until Nexus is fully started.
*
*  For new installs, you must login as admin to complete some setup steps
*  You can manage the repository by typing 'start http://$($Hostname):$($NexusPort)'
*
*  The default user is 'admin'
*  ADMIN PASSWORD:
$(if (Test-Path $generatedAdminPasswordFile) {
"*    NEW INSTALLS: The password generated for your instance is recorded
*       in '$($generatedAdminPasswordFile)'"
} else {
"*    UPGRADES/REINSTALLS: As you upgraded (or uninstalled and reinstalled) without cleaning
*      up $TargetDataFolder - the password will be the same as it was before and the password file
*      will not exist.
*    RESET PASSWORD WITH INSTALL: Uninstall Nexus and remove the directory '$TargetDataFolder'
*      and then reinstall.  This time a password file will be generated."
})
*
*  Nexus availability is controlled via the service `"$Servicename`"
*  Use the following command to open port $NexusPort for access from off this machine (one line):
*   netsh advfirewall firewall add rule name=`"Nexus Repository`" dir=in action=allow
*   protocol=TCP localport=$NexusPort
*
*******************************************************************************************
"@
