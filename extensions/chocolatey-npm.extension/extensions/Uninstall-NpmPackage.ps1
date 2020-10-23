<#
.SYNOPSIS
    Uninstalls an NPM package.

.DESCRIPTION
    Uninstalls an NPM package.

    Supports uninstalling packages for the user which initiated the process when running in background mode.

.EXAMPLE
    PS> Uninstall-NpmPackage markdownlint-cli

    Uninstalls the 'markdownlint-cli' package.
#>
function Uninstall-NpmPackage {
    [CmdletBinding()]
    param(
        # Name of the package to uninstall
        [Parameter(Mandatory = $true)]
        [string]$package
    )

    $user = $env:USER_CONTEXT
    if ($user) {
        Write-Host "Detected running in background mode"
        Write-Host "Uninstalling for user '$user'"

        $profilesDirectory = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList" -Name "ProfilesDirectory").ProfilesDirectory
        $userNpmDirectory = "$profilesDirectory\$user\AppData\Roaming\npm"

        $currentPrefix = npm prefix -g
        try {
            # Set folder for global packages to user folder of user which initiated the uninstallation.
            npm config set prefix $userNpmDirectory

            npm uninstall -g $package
        }
        finally {
            npm config set prefix $currentPrefix
        }

    }
    else {
        npm uninstall -g $package
    }
}
