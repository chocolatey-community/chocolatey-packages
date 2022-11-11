# If x86 exists, that is the default installation location for the previous version of Jenkins on an x64 system
$ProgramFiles = @($env:ProgramFiles, ${env:ProgramFiles(x86)})[[bool]${env:ProgramFiles(x86)}]

function Test-JenkinsMigrationRequirement {
    <#
        .Synopsis
            Tests to see if there is an installed version of Jenkins, and that it's <= 2.3.0

        .Description
            We need to test if we need to attempt to migrate from the previous installation of Jenkins.
            This test should show that an old version of Jenkins is installed.

        .Example
            Test-JenkinsMigrationRequirement
    #>
    [OutputType([bool])]
    [CmdletBinding()]
    param(
        # The registry path to find old Jenkins keys
        [string]$JenkinsRegistryRoot = "HKLM:\SOFTWARE\Jenkins\InstalledProducts\Jenkins"
    )
    end {
        -not (Test-Path $JenkinsRegistryRoot) -and
            (Test-Path $ProgramFiles\Jenkins\jenkins.exe) -and
            [version](Get-ItemProperty $ProgramFiles\Jenkins\jenkins.exe -ErrorAction SilentlyContinue).VersionInfo.ProductVersion -le "2.3.0"
    }
}

function Merge-JenkinsMigrationData {
    <#
        .Synopsis
            Migrates jobs, users, plugins, etc, from a 2.3.0 install of Jenkins to a newer version
        
        .Description
            The Windows installation of Jenkins significantly changed after 2.3.0. Consequently, user data needs to be
            migrated to the new storage location. This function attempts to do this.

        .Example
            Merge-JenkinsMigrationData
    #>
    [OutputType([null])]
    [CmdletBinding()]
    param(
        # The old data directory
        $PreviousDataDirectory = $(Convert-Path "$ProgramFiles\Jenkins\"),

        # The new data directory
        $NewDataDirectory = $(cmd /c "echo $(([xml](Get-Content $env:ProgramFiles\Jenkins\jenkins.xml)).service.env.value)")
    )
    end {
        

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
}