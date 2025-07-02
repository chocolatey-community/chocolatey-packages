<#
.SYNOPSIS
Manages Chocolatey package updates by checking for new versions and optionally updating metadata.

.DESCRIPTION
This script serves as a central manager for checking and updating Chocolatey packages
located in the specified 'AllPackagesFolder' (typically '../automatic').
It first uses functionality similar to 'Check-PackageVersions.ps1' to identify packages
with newer versions available online.
Based on the 'UpdateMode', it then either:
- Reports these findings ('CheckOnly').
- Automatically updates the metadata for these packages ('Update') using 'Update-PackageMetadata.ps1'.
- Prompts the user for each package before updating ('Interactive').

.PARAMETER AllPackagesFolder
The root folder containing all package subdirectories.
Defaults to '../automatic' relative to this script's location.

.PARAMETER UpdateMode
Specifies the action to take when a new version is found.
- 'CheckOnly' (default): Only reports packages with new versions. No files are changed.
- 'Update': Reports new versions and automatically attempts to update their metadata files
  (nuspec and potentially version variables in update.ps1).
- 'Interactive': Reports new versions and prompts the user for each package whether to proceed
  with the metadata update.

.PARAMETER SpecificPackages
An array of package names (IDs) to check. If this parameter is not provided,
all packages found in 'AllPackagesFolder' will be checked.
Example: -SpecificPackages "7zip", "notepadplusplus"

.EXAMPLE
.\Manage-PackageUpdates.ps1
Checks all packages in '../automatic' and reports new versions (CheckOnly mode).

.EXAMPLE
.\Manage-PackageUpdates.ps1 -UpdateMode Update
Checks all packages and attempts to update metadata for those with new versions.

.EXAMPLE
.\Manage-PackageUpdates.ps1 -SpecificPackages "7zip", "git" -UpdateMode Interactive
Checks only '7zip' and 'git' packages and prompts before attempting to update their metadata if new versions are found.

.EXAMPLE
.\Manage-PackageUpdates.ps1 -SpecificPackages "nonexistentpackage"
Checks only 'nonexistentpackage' and will likely report it's not found.

.NOTES
This script orchestrates 'Check-PackageVersions.ps1' (by importing its functions) and 'Update-PackageMetadata.ps1'.
Ensure these two scripts are present in the same directory as 'Manage-PackageUpdates.ps1'.
Requires the Chocolatey-AU module for many of its underlying operations (version checking, nuspec updating).
Error handling for individual package updates is logged, but the script continues with other packages.
The 'Update-PackageMetadata.ps1' script handles the specifics of modifying .nuspec and update.ps1 files.
#>
#Requires -Module Chocolatey-AU

param (
    [string]$AllPackagesFolder = "$PSScriptRoot/../automatic",
    [ValidateSet('CheckOnly', 'Update', 'Interactive')]
    [string]$UpdateMode = 'CheckOnly',
    [string[]]$SpecificPackages # Optional: array of specific package names to target
)

# Define paths for the helper scripts, assuming they are in the same directory
$CheckerScriptFunctionsPath = Join-Path -Path $PSScriptRoot -ChildPath "Check-PackageVersions.ps1" # We'll dot-source this for functions
$UpdaterScriptPath = Join-Path -Path $PSScriptRoot -ChildPath "Update-PackageMetadata.ps1"       # This will be invoked

# Validate helper script presence
if (-not (Test-Path $CheckerScriptFunctionsPath)) {
    Write-Error "Required script 'Check-PackageVersions.ps1' not found in '$PSScriptRoot'. Aborting."
    exit 1
}
if (-not (Test-Path $UpdaterScriptPath)) {
    Write-Error "Required script 'Update-PackageMetadata.ps1' not found in '$PSScriptRoot'. Aborting."
    exit 1
}

# Dot-source the checker script to make its functions (Get-PackageInfo, Get-LatestVersionFromUrl) available locally.
# This is a common PowerShell technique for reusing functions without creating a formal module.
. $CheckerScriptFunctionsPath
Write-Host "Successfully imported functions from Check-PackageVersions.ps1"

# Determine which package folders to process based on SpecificPackages or all
$packageFoldersToProcess = @()
if ($PSBoundParameters.ContainsKey('SpecificPackages') -and $SpecificPackages) {
    Write-Host "Processing specific packages: $($SpecificPackages -join ', ')"
    foreach ($pkgName in $SpecificPackages) {
        $pkgDir = Join-Path -Path $AllPackagesFolder -ChildPath $pkgName
        if (Test-Path $pkgDir -PathType Container) {
            $packageFoldersToProcess += Get-Item $pkgDir
        } else {
            Write-Warning "Specified package folder for '$pkgName' not found in '$AllPackagesFolder'."
        }
    }
} else {
    Write-Host "Processing all packages in '$AllPackagesFolder'."
    $packageFoldersToProcess = Get-ChildItem -Path $AllPackagesFolder -Directory -ErrorAction SilentlyContinue
}

if ($packageFoldersToProcess.Count -eq 0) {
    Write-Host "No package folders found to process with the given criteria."
    exit 0 # No packages to process is not an error state.
}

Write-Host "Starting package update management process (Mode: $UpdateMode)."
Write-Host "Packages to check: $($packageFoldersToProcess.Name -join ', ')"
Write-Host "--------------------------------------------------"

$updatesFound = @{} # Hashtable to store packages that have updates: $updatesFound['packageName'] = 'newVersion'

# Phase 1: Check for updates (similar to Check-PackageVersions.ps1 logic)
foreach ($packageFolder in $packageFoldersToProcess) {
    $nuspecFiles = Get-ChildItem -Path $packageFolder.FullName -Filter "*.nuspec" -Recurse -File
    if ($nuspecFiles.Count -eq 0) {
        Write-Host "No .nuspec file found in $($packageFolder.Name) directory. Skipping."
        Write-Host "--------------------------------------------------"
        continue
    }
    $nuspecFile = $nuspecFiles[0].FullName # Assume one .nuspec per folder
    $packageInfo = Get-PackageInfo -NuspecFile $nuspecFile # Function imported from CheckerScriptFunctionsPath

    if (-not $packageInfo) {
        # Get-PackageInfo already wrote a warning
        Write-Host "--------------------------------------------------"
        continue
    }

    Write-Host "Checking package: $($packageInfo.Name) (Current Version: $($packageInfo.Version))"

    if (-not $packageInfo.ProjectUrl) {
        Write-Warning "Skipping $($packageInfo.Name) as ProjectUrl (or fallback LicenseUrl) is not defined in the nuspec."
        Write-Host "--------------------------------------------------"
        continue
    }

    # URL determination logic (copied & adapted from Check-PackageVersions.ps1)
    $checkUrl = $packageInfo.ProjectUrl
    $updateScriptPath = Join-Path -Path $packageFolder.FullName -ChildPath "update.ps1"
    if (Test-Path $updateScriptPath) {
        $updateScriptContent = Get-Content $updateScriptPath -Raw -ErrorAction SilentlyContinue
        $urlPatternMatch = $updateScriptContent | Select-String -Pattern '\$(?:url|nugetUrl)\s*=\s*["'']([^"'']+)["'']' -AllMatches
        if ($urlPatternMatch) {
            $checkUrl = $urlPatternMatch.Matches[-1].Groups[1].Value
            Write-Host " Using potential update URL from update.ps1: $checkUrl"
        } else {
            Write-Host " No specific \$url or \$nugetUrl found in update.ps1, using ProjectUrl from nuspec: $checkUrl"
        }
    } else {
        Write-Host " No update.ps1 found, using ProjectUrl from nuspec: $checkUrl"
    }

    $latestVersion = Get-LatestVersionFromUrl -ProjectUrl $checkUrl -PackageName $packageInfo.Name # Function imported

    if ($latestVersion) {
        if ($latestVersion.ToString() -ne $packageInfo.Version.ToString()) {
            Write-Host "  New version available for $($packageInfo.Name): $latestVersion (Current: $($packageInfo.Version))" -ForegroundColor Green
            $updatesFound[$packageInfo.Name] = $latestVersion.ToString()
        } else {
            Write-Host "  $($packageInfo.Name) is up to date." -ForegroundColor Cyan
        }
    }
    # If $latestVersion is null, Get-LatestVersionFromUrl already issued a warning.
    Write-Host "--------------------------------------------------"
}

# Phase 2: Process updates based on UpdateMode
if ($updatesFound.Count -eq 0) {
    Write-Host "No updates found for any of the checked packages."
    exit 0
}

Write-Host "$($updatesFound.Count) package(s) have new versions available: $($updatesFound.Keys -join ', ')"

if ($UpdateMode -eq 'CheckOnly') {
    Write-Host "UpdateMode is 'CheckOnly'. No files will be modified. Exiting."
    exit 0
}

# Proceed with updates if mode is 'Update' or 'Interactive'
foreach ($packageNameInLoop in $updatesFound.Keys) { # Use a different variable name to avoid PSBoundParameters confusion
    $newVersionForLoop = $updatesFound[$packageNameInLoop]
    $performUpdate = $false

    if ($UpdateMode -eq 'Update') {
        $performUpdate = $true
    } elseif ($UpdateMode -eq 'Interactive') {
        $promptMessage = "Update $packageNameInLoop from current to $newVersionForLoop? [Y]es / [N]o / [A]ll / [S]kip All Remaining"
        $choice = Read-Host -Prompt $promptMessage
        switch ($choice.ToUpper()) {
            'Y' { $performUpdate = $true }
            'A' {
                $performUpdate = $true
                Write-Host "Updating this and all subsequent packages found with updates."
                $UpdateMode = 'Update' # Change mode to 'Update' for the rest of the session
            }
            'S' {
                Write-Host "Skipping all further package updates in this run."
                $UpdateMode = 'CheckOnly' # Effectively stop further updates by changing mode
                $performUpdate = $false # Don't update current
            }
            default { # 'N' or anything else
                Write-Host "Skipping update for $packageNameInLoop."
                $performUpdate = $false
            }
        }
    }

    if ($performUpdate) {
        Write-Host "Attempting to update metadata for $packageNameInLoop to $newVersionForLoop..."

        # Prepare parameters for Update-PackageMetadata.ps1
        $updateParams = @{
            PackageName       = $packageNameInLoop
            NewVersion        = $newVersionForLoop
            AllPackagesFolder = $AllPackagesFolder # Pass the correct base folder
            ErrorAction       = 'Continue' # So one script error doesn't stop this loop
        }

        try {
            # Execute Update-PackageMetadata.ps1.
            # Using Invoke-Expression is one way, direct call is another.
            # & $UpdaterScriptPath @updateParams is generally safer if $UpdaterScriptPath doesn't have spaces.
            # For robustness with paths:
            Invoke-Command -ScriptBlock ([scriptblock]::Create((Get-Content $UpdaterScriptPath -Raw))) -ArgumentList $updateParams

            # $LASTEXITCODE might not be reliable with Invoke-Command for script blocks in this manner.
            # Success/failure is primarily determined by Write-Error in the called script or try/catch here.
            Write-Host "Update script execution attempted for $packageNameInLoop. Review its output above for details." -ForegroundColor Green
        }
        catch {
            Write-Error "Failed to execute or error within update script for $packageNameInLoop. Error: $($_.Exception.Message)"
            # The loop will continue to the next package due to ErrorAction='Continue' or implicit try/catch behavior.
        }
        Write-Host "--------------------------------------------------"
    } elseif ($UpdateMode -eq 'CheckOnly' -and $choice.ToUpper() -eq 'S') {
        # This condition handles when 'Skip All' was chosen in interactive mode
        break # Exit the loop entirely
    }
}

Write-Host "Package update management process finished."
