<#
.SYNOPSIS
  Updates Package Source Url with correct URL in the nuspec file

.DESCRIPTION
  It updates the package nuspec file with the correct package source url.

.PARAMETER Name
  If specified it only updates the package matching the specified name

.PARAMETER GithubRepository
  The github user/repository to use

.PARAMETER PackagesDirectory
  The relative path to where packages are located (relative to the location of this script)

.PARAMETER UseStopwatch
  Uses a stopwatch to time how long this script used to execute

.PARAMETER Quiet
  Do not write normal output to host.
  NOTE: Output from git and Write-Warning will still be available

.OUTPUTS
  The number of packages that was updates,
  if some packages is already up to date, outputs how many.

.EXAMPLE
  ps> .\Update-PackageSourceUrl.ps1
  Updates all nuspec files with correct package source
-    <packageSourceUrl>https://github.com/mkevenaar/chocolatey-packages</packageSourceUrl>
+    <packageSourceUrl>https://github.com/mkevenaar/chocolatey-packages/tree/master/automatic/anyrail6</packageSourceUrl>

.EXAMPLE
  ps> .\Update-PackageSourceUrl.ps1 -Name 'bitvise-ssh-server'
  Updates only a single nuspec file with the specified name with its matching icon
-    <packageSourceUrl>https://github.com/mkevenaar/chocolatey-packages</packageSourceUrl>
+    <packageSourceUrl>https://github.com/mkevenaar/chocolatey-packages/tree/master/automatic/bitvise-ssh-server</packageSourceUrl>

.EXAMPLE
  ps> .\Updates-packageSourceUrl.ps1 -Name "bitvise-ssh-server" -UseStopwatch
  ps> .\Updates-packageSourceUrl.ps1 -UseStopwatch
  While also updating the nuspec file this will also output the time it took for the script to finish
  output> "Time Used: 00:00:27.4720531"

.EXAMPLE
  Possible output for all calls

  Output if found
  output> Updated 1 url(s)

  Output if already up to date
  output> Congratulations, all found urls are up to date.
  output> 1 icon url(s) was already up to date.
#>

param(
  [string]$Name,
  [string]$GithubRepository = $null,
  [string]$PackagesDirectory = "../automatic",
  [switch]$UseStopwatch,
  [switch]$Quiet
)

if (!$GithubRepository) {
  $allRemotes = . git remote
  $remoteName = if ($allRemotes | ? { $_ -eq 'upstream' }) { "upstream" }
                elseif ($allRemotes | ? { $_ -eq 'origin' }) { 'origin' }
                else { $allRemotes | select -first 1 }

  if ($remoteName) { $remoteUrl = . git remote get-url $remoteName }

  if ($remoteUrl) {
    $GithubRepository = ($remoteUrl -split '\/' | select -last 2) -replace '\.git$','' -join '/'
  } else {
    Write-Warning "Unable to get repository and user, setting dummy values..."
    $GithubRepository = "USERNAME/REPOSITORY-NAME"
  }
}

$counts = @{
  replaced = 0
  uptodate = 0
}

$missingIcons = New-Object System.Collections.Generic.List[object];

$encoding = New-Object System.Text.UTF8Encoding($false)

function Replace-PackageSourceUrl{
  param(
    [string]$NuspecPath,
    [string]$PackageName,
    [string]$GithubRepository,
    [string]$PackagesDirectory
  )

  $nuspec = Get-Content "$NuspecPath" -Encoding UTF8

  $oldContent = ($nuspec | Out-String) -replace '\r\n?',"`n"

  $url = "https://github.com/${GithubRepository}/tree/master/$PackagesDirectory/$PackageName"

  $nuspec = $nuspec -replace '<packageSourceUrl>.*',"<packageSourceUrl>$url</packageSourceUrl>"

  $output = ($nuspec | Out-String) -replace '\r\n?',"`n"
  if ($oldContent -eq $output) {
    $counts.uptodate++;
    return;
  }
  [System.IO.File]::WriteAllText("$NuspecPath", $output, $encoding);

  $counts.replaced++;
}

function Update-PackageSourceUrl{
  param(
    [string]$Name,
    [string]$GithubRepository,
    [bool]$Quiet
  )

  # Let check if the package already contains a url
  $content = Get-Content "$PSScriptRoot/$PackagesDirectory/$Name/$Name.nuspec" -Encoding UTF8

  if ($content | Where-Object { $_ -match 'packageSource(Url)?:\s*Skip( check)?' }) {
    if (!($Quiet)) {
      Write-Warning "Skipping check for $Name"
    }
    return;
  }

  $FolderName = $PackagesDirectory -split '/' | Select-Object -Last 1

  Replace-packageSourceUrl `
    -NuspecPath "$PSScriptRoot/$PackagesDirectory/$Name/$Name.nuspec" `
    -PackageName $Name `
    -GithubRepository $GithubRepository `
    -PackagesDirectory $FolderName
}

if ($UseStopwatch) {
  $stopWatch = New-Object System.Diagnostics.Stopwatch
  $stopWatch.Start();
}

If ($Name) {
  Update-PackageSourceUrl -Name $Name -GithubRepository $GithubRepository -Quiet $Quiet
}
else {
  $directories = Get-ChildItem -Path "$PSScriptRoot/$PackagesDirectory" -Directory;

  foreach ($directory in $directories) {
    if ((Test-Path "$($directory.FullName)/$($directory.Name).nuspec")) {
      Update-PackageSourceUrl -Name $directory.Name -GithubRepository $GithubRepository -Quiet $Quiet
    }
  }
}

if ($UseStopwatch) {
  $stopWatch.Stop();
  if (!$Quiet) {
    Write-Host "Time Used: $($stopWatch.Elapsed)"
  }
}
if ($counts.replaced -eq 0 -and !$Quiet) {
  Write-Host "Congratulations, all found urls are up to date."
} elseif (!$Quiet) {
  Write-Host "Updated $($counts.replaced) url(s)";
}
if ($counts.uptodate -gt 0 -and !$Quiet) {
  Write-Host "$($counts.uptodate) url(s) was already up to date.";
}
