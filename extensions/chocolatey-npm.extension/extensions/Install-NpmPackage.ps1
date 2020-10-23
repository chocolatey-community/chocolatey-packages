<#
.SYNOPSIS
    Installs an NPM package gloabl for the current user.

.DESCRIPTION
    Installs an NPM package gloabl for the current user.

    Requires that NodeJS is installed, otherwise an error is shown.

    Supports installing packages for the user which initiated the process when running in background mode.

.EXAMPLE
    PS> Install-NpmPackage markdownlint

    Installs the 'markdownlint' package

.EXAMPLE
    PS> Install-NpmPackage markdownlint@0.23.2

    Installs version 0.23.2 of the 'markdownlint' package.
#>
function Install-NpmPackage {
    [CmdletBinding()]
    param(
        # Scope, name and version of the package to install
        [Parameter(Mandatory = $true)]
        [string]$package
    )

    if (-Not (Get-Command "node" -errorAction SilentlyContinue)) {
        $packageName = $env:ChocolateyPackageName
        Write-Error "$packageName requires Node.js to be installed. To install with Chocolatey, use either of the commands below:"
        Write-Error "  choco install nodejs"
        Write-Error "  choco install nodejs-lts"
        throw "Node.js not found"
    } else {
        $user = $env:USER_CONTEXT
        if ($user) {
            Write-Host "Detected running in background mode"
            Write-Host "Installing for user '$user'"

            $profilesDirectory = (Get-ItemProperty -Path "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\ProfileList" -Name "ProfilesDirectory").ProfilesDirectory
            $userNpmDirectory = "$profilesDirectory\$user\AppData\Roaming\npm"

            $currentPrefix = npm prefix -g
            try {
                # Set folder for global packages to user folder of user which initiated the installation.
                npm config set prefix $userNpmDirectory

                npm install -g $package
            }
            finally {
                npm config set prefix $currentPrefix
            }

        }
        else {
            npm install -g $package
        }
    }
}
