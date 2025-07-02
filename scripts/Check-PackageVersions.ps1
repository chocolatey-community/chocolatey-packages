#Requires -Module Chocolatey-AU
<#
.SYNOPSIS
Checks for new versions of Chocolatey packages.

.DESCRIPTION
This script iterates through all package subdirectories in the specified 'AllPackagesFolder'.
For each package, it reads the .nuspec file to determine the current version and project URL.
It then attempts to find a more specific update check URL from an 'update.ps1' file if present.
Finally, it uses Chocolatey-AU's Get-VersionFromUrl (if the Chocolatey-AU module is available)
to determine the latest available version from the determined URL and reports if a newer version is found.

.PARAMETER AllPackagesFolder
The root folder containing package subdirectories. Defaults to '../automatic' relative to this script.

.EXAMPLE
.\Check-PackageVersions.ps1
Checks all packages in the default '../automatic' directory.

.EXAMPLE
.\Check-PackageVersions.ps1 -AllPackagesFolder "C:\my\choco\packages"
Checks all packages in the 'C:\my\choco\packages' directory.

.OUTPUTS
Outputs messages to the console indicating which packages are being checked,
if they are up to date, or if a new version is available.

.NOTES
This script relies on the Chocolatey-AU module's Get-VersionFromUrl function for optimal version detection.
If Chocolatey-AU is not available, version checking capabilities will be significantly limited or non-functional.
The script reads .nuspec files and potentially update.ps1 files.
#>
param (
    [string]$AllPackagesFolder = "$PSScriptRoot/../automatic"
)

# Helper function to extract package information from a .nuspec file
function Get-PackageInfo {
    param (
        [string]$NuspecFile # The full path to the .nuspec file
    )
    try {
        $nuspecContent = Get-Content -Path $NuspecFile -Raw -ErrorAction Stop
        $xml = [xml]$nuspecContent
        $packageName = $xml.package.metadata.id
        $currentVersion = $xml.package.metadata.version
        # Try to find project URL, fallback to license URL if not found, as projectUrl is more relevant for version checks
        $projectUrl = $xml.package.metadata.projectUrl
        if (-not $projectUrl) {
            $projectUrl = $xml.package.metadata.licenseUrl # Fallback, though less ideal
        }
        return @{
            Name = $packageName
            Version = $currentVersion
            ProjectUrl = $projectUrl # This is the primary URL the script attempts to use or find alternatives for
            NuspecFile = $NuspecFile
        }
    }
    catch {
        Write-Warning "Error processing nuspec file: $NuspecFile. Error: $($_.Exception.Message)"
        return $null
    }
}

# Function to get the latest version from a given URL, primarily using Chocolatey-AU
function Get-LatestVersionFromUrl {
    param (
        [string]$ProjectUrl, # The URL to check for the latest version
        [string]$PackageName # For logging/error messages
    )
    if (-not $ProjectUrl) {
        Write-Warning "No ProjectUrl provided for package $PackageName."
        return $null
    }

    try {
        # Attempt to get the latest version using Chocolatey-AU's Get-VersionFromUrl
        # This function is quite powerful and can extract versions from various sources.
        # Ensure Chocolatey-AU module is loaded, though #Requires should handle this.
        if (Get-Command Get-VersionFromUrl -ErrorAction SilentlyContinue) {
            $latestVersion = Get-VersionFromUrl -Url $ProjectUrl
            if ($latestVersion) {
                return $latestVersion
            } else {
                Write-Warning "Could not automatically determine latest version for $PackageName from $ProjectUrl using Get-VersionFromUrl."
                return $null
            }
        } else {
            Write-Warning "Get-VersionFromUrl command not found (Chocolatey-AU module might be missing or not loaded). Cannot determine latest version for $PackageName."
            return $null
        }
    }
    catch {
        Write-Warning "Error retrieving latest version for $PackageName from $ProjectUrl. Error: $($_.Exception.Message)"
        return $null
    }
}

# Main script execution
Write-Host "Starting package version check..."
$allPackageFolders = Get-ChildItem -Path $AllPackagesFolder -Directory -ErrorAction SilentlyContinue

if (-not $allPackageFolders) {
    Write-Warning "No package folders found in '$AllPackagesFolder' or the path is incorrect."
    exit 1
}

foreach ($packageFolder in $allPackageFolders) {
    $nuspecFiles = Get-ChildItem -Path $packageFolder.FullName -Filter "*.nuspec" -Recurse -File
    if ($nuspecFiles.Count -eq 0) {
        Write-Host "No .nuspec file found in $($packageFolder.Name)"
        continue
    }

    # Assuming one .nuspec per folder for simplicity, take the first one
    $nuspecFile = $nuspecFiles[0].FullName
    $packageInfo = Get-PackageInfo -NuspecFile $nuspecFile

    if (-not $packageInfo) {
        continue # Warning already issued by Get-PackageInfo
    }

    Write-Host "Checking package: $($packageInfo.Name) (Current Version: $($packageInfo.Version))"

    if (-not $packageInfo.ProjectUrl) {
        Write-Warning "Skipping $($packageInfo.Name) as ProjectUrl (or fallback LicenseUrl) is not defined in the nuspec."
        Write-Host "--------------------------------------------------"
        continue
    }

    # Determine the most appropriate URL to check for updates
    $checkUrl = $packageInfo.ProjectUrl # Default to projectUrl from nuspec
    $updateScriptPath = Join-Path -Path $packageFolder.FullName -ChildPath "update.ps1"

    if (Test-Path $updateScriptPath) {
        # Attempt to parse $url or $nugetUrl from update.ps1 as these might be more specific
        $updateScriptContent = Get-Content $updateScriptPath -Raw
        # Regex to find $url = "..." or $nugetUrl = "..."
        $urlPatternMatch = $updateScriptContent | Select-String -Pattern '\$(?:url|nugetUrl)\s*=\s*["'']([^"'']+)["'']' -AllMatches
        if ($urlPatternMatch) {
            $checkUrl = $urlPatternMatch.Matches[-1].Groups[1].Value # Use the last assignment
            Write-Host " Found potential update URL in update.ps1: $checkUrl"
        } else {
             Write-Host " No specific \$url or \$nugetUrl found in update.ps1, using ProjectUrl from nuspec: $checkUrl"
        }
    } else {
        Write-Host " No update.ps1 found, using ProjectUrl from nuspec: $checkUrl"
    }

    $latestVersion = Get-LatestVersionFromUrl -ProjectUrl $checkUrl -PackageName $packageInfo.Name

    if ($latestVersion) {
        # Normalize version strings for comparison if necessary, though direct comparison often works
        if ($latestVersion.ToString() -ne $packageInfo.Version.ToString()) {
            Write-Host "  New version found for $($packageInfo.Name): $latestVersion (Current: $($packageInfo.Version))" -ForegroundColor Green
        } else {
            Write-Host "  $($packageInfo.Name) is up to date." -ForegroundColor Cyan
        }
    }
    # If $latestVersion is null, a warning was already issued by Get-LatestVersionFromUrl
    Write-Host "--------------------------------------------------"
}

Write-Host "Version check complete."
