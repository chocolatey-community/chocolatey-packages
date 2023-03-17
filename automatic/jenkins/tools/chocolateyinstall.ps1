$ErrorActionPreference = 'Stop'

$ToolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition
Import-Module $ToolsDir\helpers.psm1

$PackageArgs = @{
    packageName   = $env:ChocolateyPackageName
    fileType      = 'msi'
    file          = "$ToolsDir\jenkins.msi"
    silentArgs  = "/qn /norestart /l*v `"$($env:TEMP)\$($env:ChocolateyPackageName).$($env:chocolateyPackageVersion).MsiInstall.log`""
    validExitCodes= @(0, 3010, 1641)
    softwareName  = 'Jenkins*'
}

# Handle Package Parameters
$PackageParameters = Get-PackageParameters

if ($PackageParameters["INSTALLDIR"]) {
    $PackageArgs.silentArgs += " INSTALLDIR=`"$($PackageParameters["INSTALLDIR"])`""
}

if ($PackageParameters["JENKINS_ROOT"]) {
    if ($CurrentRoot = (Get-ItemProperty -Path "HKLM:\SOFTWARE\Jenkins\InstalledProducts\Jenkins" -Name JenkinsRoot -ErrorAction SilentlyContinue).JenkinsRoot) {
        Write-Warning "The Jenkins Msi Installer does not support changing JENKINS_ROOT after installation. JENKINS_ROOT is currently set to '$($CurrentRoot)'"
    } else {
        $PackageArgs.silentArgs += " JENKINS_ROOT=`"$($PackageParameters["JENKINS_ROOT"])`""
    }
} elseif (-not (Get-ItemProperty -Path "HKLM:\SOFTWARE\Jenkins\InstalledProducts\Jenkins" -Name JenkinsRoot -ErrorAction SilentlyContinue)) {
    $PackageArgs.silentArgs += " JENKINS_ROOT=`"$env:ProgramData\Jenkins\`""
}

if ($PackageParameters["PORT"]) {
    $PackageArgs.silentArgs += " PORT=$($PackageParameters["PORT"])"
}

if (-not $env:JAVA_HOME -and -not $PackageParameters["JAVA_HOME"]) {
    if ($JavaPath = Convert-Path "$env:ProgramFiles\*\jre-11*") {
        Write-Verbose "Found '$JavaPath', using '$(@($JavaPath)[0])'"
        $JAVA_HOME = @($JavaPath)[0]
    } else {
        throw 'Jenkins will fail to install if Java is not available. Pass JAVA_HOME as a param or ensure $env:JAVA_HOME is set. See package notes for further details.'
    }
} elseif ($PackageParameters["JAVA_HOME"]) {
    $JAVA_HOME = $PackageParameters["JAVA_HOME"]
}

if ($JAVA_HOME) {
    $PackageArgs.silentArgs += " JAVA_HOME=`"$($JAVA_HOME)`""
}

if ($PackageParameters["SERVICE_USERNAME"]) {
    $PackageArgs.silentArgs += " SERVICE_USERNAME=`"$($PackageParameters["SERVICE_USERNAME"])`""
}

if ($PackageParameters["SERVICE_PASSWORD"]) {
    $PackageArgs.silentArgs += " SERVICE_PASSWORD=`"$($PackageParameters["SERVICE_PASSWORD"])`""
}

Install-ChocolateyInstallPackage @PackageArgs

<# This logic is here to deal with upgrades from the MSI installer for 2.222 to the newer 2.3* #>
if (Test-JenkinsMigrationRequirement) {Merge-JenkinsMigrationData}

Start-Service Jenkins
