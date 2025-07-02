#Requires -Module Chocolatey-AU
<#
.SYNOPSIS
Updates the metadata for a specified Chocolatey package.

.DESCRIPTION
This script updates the .nuspec file of a given package to a new version.
It can also attempt to update a '$version' variable within the package's 'update.ps1' script if found.
This script primarily relies on Chocolatey-AU's Update-PackageNuspec function for robust .nuspec modification.

.PARAMETER PackageName
(Mandatory) The name (ID) of the package to update. This should match the subfolder name in AllPackagesFolder and the ID in the .nuspec.

.PARAMETER NewVersion
(Mandatory) The new version string to set for the package.

.PARAMETER AllPackagesFolder
The root folder containing all package subdirectories. Defaults to '../automatic' relative to this script.
This is used to locate the package's folder and its .nuspec file.

.EXAMPLE
.\Update-PackageMetadata.ps1 -PackageName "mypackage" -NewVersion "1.2.3"
Updates 'mypackage' in '../automatic/mypackage' to version '1.2.3'.

.EXAMPLE
.\Update-PackageMetadata.ps1 -PackageName "anotherpackage" -NewVersion "2.0.0" -AllPackagesFolder "C:\my\chocorepo"
Updates 'anotherpackage' in 'C:\my\chocorepo\anotherpackage' to version '2.0.0'.

.OUTPUTS
Outputs messages to the console about the update process, success, or failures.

.NOTES
Relies heavily on the Chocolatey-AU module, especially for the 'Update-PackageNuspec' and 'Get-PackageInfo' (helper) functions.
The update of 'update.ps1' is a best-effort attempt and might require manual adjustments for complex scripts.
#>
param (
    [Parameter(Mandatory=$true)]
    [string]$PackageName,

    [Parameter(Mandatory=$true)]
    [string]$NewVersion,

    [string]$AllPackagesFolder = "$PSScriptRoot/../automatic"
    # Add other parameters as needed, e.g., for checksums, release notes URL for Update-PackageNuspec
)

# Helper function to locate the .nuspec file for a given package ID
function Find-NuspecFile {
    param (
        [string]$RootFolder, # Base folder like ../automatic
        [string]$PackageId   # The ID of the package, e.g., "7zip"
    )
    $packageFolderItem = Get-ChildItem -Path $RootFolder -Directory | Where-Object { $_.Name -eq $PackageId } | Select-Object -First 1
    if (-not $packageFolderItem) {
        Write-Warning "Package folder '$PackageId' not found in '$RootFolder'."
        return $null
    }
    $packageFolder = $packageFolderItem.FullName
    $nuspecFiles = Get-ChildItem -Path $packageFolder -Filter "*.nuspec" -Recurse -File
    if ($nuspecFiles.Count -eq 0) {
        Write-Warning "No .nuspec file found in '$packageFolder'."
        return $null
    }
    return $nuspecFiles[0].FullName # Return the full path of the first .nuspec file found
}

# Main script execution
$nuspecFile = Find-NuspecFile -RootFolder $AllPackagesFolder -PackageId $PackageName

if (-not $nuspecFile) {
    Write-Error "Nuspec file not found for package '$PackageName' in '$AllPackagesFolder'. Cannot proceed."
    exit 1 # Exit with an error code
}

Write-Host "Updating nuspec for $PackageName: $nuspecFile"
Write-Host "Target New Version: $NewVersion"

try {
    # Use Chocolatey-AU's Update-PackageNuspec to update the version.
    # This function is robust and handles many aspects of nuspec modification.
    # It also respects au_SearchReplace functions if defined in an update.ps1, for things like dependency version updates.
    if (Get-Command Update-PackageNuspec -ErrorAction SilentlyContinue) {
        Update-PackageNuspec -Path $nuspecFile -Version $NewVersion -WarningAction SilentlyContinue # Use SilentlyContinue for WarningAction if appropriate
        # Add other parameters like -Checksum, -ReleaseNotesUrl if they are passed to this script and needed by Update-PackageNuspec
    } else {
        Write-Error "Update-PackageNuspec command not found (Chocolatey-AU module might be missing or not loaded). Cannot update nuspec file."
        exit 1
    }

    # Verification step: Read the nuspec again to confirm the version
    $xml = [xml](Get-Content -Path $nuspecFile -Raw)
    $updatedVersion = $xml.package.metadata.version

    if ($updatedVersion -eq $NewVersion) {
        Write-Host "Successfully updated $PackageName to version $NewVersion in $nuspecFile" -ForegroundColor Green
    } else {
        Write-Warning "Nuspec update verification failed. Expected version $NewVersion, but found $updatedVersion in $nuspecFile."
    }

    # Placeholder for Changelog update logic
    $changelogPath = Join-Path -Path (Split-Path $nuspecFile) -ChildPath "CHANGELOG.md" # Common location
    if (Test-Path $changelogPath) {
        Write-Host "Changelog found at $changelogPath. Consider updating it manually or with a dedicated script (e.g., Update-ChangelogVersion.ps1 if available and compatible)."
    }

}
catch {
    Write-Error "Failed to update nuspec file for $PackageName. Error: $($_.Exception.Message)"
    exit 1 # Exit with an error code
}

# Attempt to update $version variable in the package's update.ps1 script, if it exists
$updatePs1File = Join-Path -Path (Split-Path $nuspecFile -Parent) -ChildPath "update.ps1"
if (Test-Path $updatePs1File) {
    Write-Host "Found update.ps1 at $updatePs1File. Attempting to update version variable..."
    try {
        $updateScriptContent = Get-Content $updatePs1File -Raw

        # Get current version from the (now updated) nuspec to be precise in replacement, if needed for complex patterns
        # However, for simple $version replacement, this is not strictly necessary if we assume $NewVersion is the target.
        $currentNuspecVersionInfo = Get-PackageInfoFromNuspec -NuspecFile $nuspecFile # Using a slightly renamed helper
        $previousVersionInNuspec = $currentNuspecVersionInfo.Version # This will actually be NewVersion if Update-PackageNuspec succeeded.
                                                                 # To get old version, would need to read before Update-PackageNuspec or pass it in.
                                                                 # For simplicity, we'll try to replace any version with NewVersion for a generic $version variable.

        # Regex to find '$version = "ANYTHING"' or '$version = ''ANYTHING'''
        # This is a general approach. Some update.ps1 scripts might not have such a variable or might construct it differently.
        $versionVariablePattern = '(\$version\s*=\s*["''])[^''"]+([''"])'

        if ($updateScriptContent -match $versionVariablePattern) {
            # Replace the old version with the new version
            $newUpdateScriptContent = $updateScriptContent -replace $versionVariablePattern, "`$1$NewVersion`$2"

            if ($newUpdateScriptContent -ne $updateScriptContent) {
                Set-Content -Path $updatePs1File -Value $newUpdateScriptContent
                Write-Host "Updated general `$version pattern in $updatePs1File to $NewVersion." -ForegroundColor Green
            } else {
                Write-Host "General `$version pattern found but content was unchanged (perhaps already $NewVersion) in $updatePs1File. Manual check advised."
            }
        } else {
            Write-Warning "Could not find a simple `$version = \"...\"` or `$version = '...'` variable to update in $updatePs1File. Manual update may be required if the script uses a version variable."
        }

        # Note: Updating checksums or other complex variables within update.ps1 is highly package-specific
        # and generally beyond the scope of this generic metadata update script.
        # Chocolatey-AU's `au update` process handles this by re-downloading and recalculating checksums.
        Write-Host "If $updatePs1File uses hardcoded checksums or complex version logic, those may need manual review or rely on a full 'au update' run."

    }
    catch {
        Write-Warning "Error processing $updatePs1File for version variable update: $($_.Exception.Message)"
    }
} else {
    Write-Host "No update.ps1 file found for $PackageName in its directory. No script variables to attempt to update."
}

Write-Host "Metadata update process finished for $PackageName."

# Helper function to get package info (especially current version) from a nuspec file
# Slightly renamed to avoid conflict if this script and Check-PackageVersions.ps1 were dot-sourced together in a complex way.
function Get-PackageInfoFromNuspec {
    param (
        [string]$NuspecFile
    )
    try {
        $xml = [xml](Get-Content -Path $NuspecFile -Raw -ErrorAction Stop)
        return @{
            Name = $xml.package.metadata.id
            Version = $xml.package.metadata.version
            ProjectUrl = $xml.package.metadata.projectUrl # Included for completeness, though not used in this script's main logic
            LicenseUrl = $xml.package.metadata.licenseUrl # Included for completeness
        }
    }
    catch {
        Write-Warning "Helper Get-PackageInfoFromNuspec: Error processing nuspec file '$NuspecFile'. Error: $($_.Exception.Message)"
        return $null
    }
}
