$ErrorActionPreference = 'Stop'

# Set all passed package parameters as variables
(Get-PackageParameters).GetEnumerator().ForEach{
    Set-Variable -Name $_.Key -Value $_.Value
}

$ToolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
$JenkinsRegistryRoot = "HKLM:\SOFTWARE\Jenkins\InstalledProducts\Jenkins"

# If x86 exists, that is the default installation location for the previous version of Jenkins on an x64 system
$ProgramFiles = @($env:ProgramFiles, ${env:ProgramFiles(x86)})[[bool]${env:ProgramFiles(x86)}]
$MsiUpgrade = -not (Test-Path $JenkinsRegistryRoot) -and
    (Test-Path $ProgramFiles\Jenkins\jenkins.exe) -and
    [version](Get-ItemProperty $ProgramFiles\Jenkins\jenkins.exe -ErrorAction SilentlyContinue).VersionInfo.ProductVersion -le "2.3.0"

if (-not $env:JAVA_HOME -and -not $JAVA_HOME) {
    if ($JavaPath = Convert-Path "$env:ProgramFiles\*\jre-11*") {
        Write-Verbose "Found '$JavaPath', using '$(@($JavaPath)[0])'"
        $JAVA_HOME = @($JavaPath)[0]
    } else {
        throw 'Jenkins will fail to install if Java is not available. Pass the JAVA_HOME as a param or ensure $env:JAVA_HOME is set.'
    }
}

$packageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'msi'
    file          = Join-Path $ToolsDir 'jenkins.msi'
    silentArgs  = "/qn /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
    validExitCodes= @(0, 3010, 1641)
    softwareName  = 'Jenkins*'
}

if ($INSTALLDIR) {
    $packageArgs.silentArgs += " INSTALLDIR=`"$($INSTALLDIR)`""
}

if ($JENKINS_ROOT) {
    $packageArgs.silentArgs += " JENKINS_ROOT=`"$($JENKINS_ROOT)`""

    if ($CurrentRoot = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Jenkins\InstalledProducts\Jenkins" -Name JenkinsRoot -ErrorAction SilentlyContinue).JenkinsRoot) {
        Write-Warning "The Jenkins Msi Installer does not support changing JENKINS_ROOT after installation. JENKINS_ROOT is currently set to '$($CurrentRoot)'"
    }
} elseif (-not (Get-ItemProperty -Path "HKLM:\SOFTWARE\Jenkins\InstalledProducts\Jenkins" -Name JenkinsRoot -ErrorAction SilentlyContinue)) {
    $packageArgs.silentArgs += " JENKINS_ROOT=`"$env:ProgramData\Jenkins\`""
}

if ($PORT) {
    $packageArgs.silentArgs += " PORT=$($PORT)"
}

if ($JAVA_HOME) {
    $packageArgs.silentArgs += " JAVA_HOME=`"$($JAVA_HOME)`""
}

if ($SERVICE_USERNAME) {
    $packageArgs.silentArgs += " SERVICE_USERNAME=`"$($SERVICE_USERNAME)`""
}

if ($SERVICE_PASSWORD) {
    $packageArgs.silentArgs += " SERVICE_PASSWORD=`"$($SERVICE_PASSWORD)`""
}

Install-ChocolateyInstallPackage @packageArgs

<# This logic is here to deal with upgrades from the MSI installer for 2.222 to the newer 2.3* #>
if ($MsiUpgrade) {
    $PreviousDataDirectory = Convert-Path $ProgramFiles\Jenkins\
    $NewDataDirectory = $(cmd /c "echo $(([xml](Get-Content $env:ProgramFiles\Jenkins\jenkins.xml)).service.env.value)")

    # Installing the new MSI should have uninstalled the application data for Jenkins 2.3.0 without removing user data
    Write-Warning "Migrating Jenkins 2.3.0 Data from '$($PreviousDataDirectory)' to '$($NewDataDirectory)' (Copy Only)"
    Stop-Service -Name Jenkins -Force

    if (-not (Test-Path $NewDataDirectory)) {
        $null = New-Item -Path $NewDataDirectory -ItemType Directory -Force
    }

    foreach ($Item in @(
        "jobs"
        "nodes"
        "plugins"
        "secrets"
        "userContent"
        "users"
        "identity.key.enc"
        "secret.key"
        "secret.key.not-so-secret"
        "credentials.xml"
        "jenkins.install.InstallUtil.installingPlugins"
        "jenkins.install.InstallUtil.lastExecVersion"
        "jenkins.install.UpgradeWizard.state"
        "jenkins.model.JenkinsLocationConfiguration"
    )) {
        Remove-Item -Path (Join-Path $NewDataDirectory $Item) -Recurse -ErrorAction SilentlyContinue
        Copy-Item -Path (Join-Path $PreviousDataDirectory $Item) -Destination $NewDataDirectory -Recurse -ErrorAction SilentlyContinue
    }

    if (-not (Test-Path $PreviousDataDirectory\secrets\initialAdminPassword) -and (Test-Path $NewDataDirectory\secrets\initialAdminPassword)) {
        Rename-Item $NewDataDirectory\secrets\initialAdminPassword -NewName "initialAdminPassword.backup"
    }
}

Start-Service Jenkins