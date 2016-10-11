<#
.SYNOPSIS
  Updates Icon Url with correct hashes in the nuspec file

.DESCRIPTION
  Searches for icons matching the package name and
  extracts the latest commit hash for that icon (committing it first if it has changed).
  It then updates the package nuspec file with the correct rawgit url.

.PARAMETER Name
  If specified it only updates the package matching the specified name

.PARAMETER IconName
  If specified look for an icon matching the specified Icon Name.
  Is ignored if no Name parameter is specified.

.PARAMETER GithubRepository
  The github user/repository to use in the rawgit url

.PARAMETER RelativeIconDir
  The relative path to where icons are located (relative to the location of this script)

.PARAMETER PackagesDirectory
  The relative path to where packages are located (relative to the location of this script)

.PARAMETER UseStopwatch
  Uses a stopwatch to time how long this script used to execute

.OUTPUTS
  The number of packages that was updates,
  if some packages is already up to date, outputs how many.
  Writes a warning of how many packages where icons was not found,
  then optionally outputs which packages.

.NOTES
  Currently supports icons with the following extensions
  (png, svg, jpg, ico)
#>

param(
  [string]$Name = $null,
  [string]$IconName = $null,
  [string]$GithubRepository = "chocolatey/chocolatey-coreteampackages",
  [string]$RelativeIconDir = "../icons",
  [string]$PackagesDirectory = "../automatic",
  [switch]$UseStopwatch
)

$counts = @{
  replaced = 0
  missing = 0
  uptodate = 0
}

$missingIcons = New-Object System.Collections.Generic.List[object];

$encoding = New-Object System.Text.UTF8Encoding($false)
$validExtensions = @(
  "png"
  "svg"
  "jpg"
  "ico"
)

function Test-Icon{
  param(
    [string]$Name,
    [string]$Extension,
    [string]$IconDir
  )
  $path = "$IconDir/$Name.$Extension"
  if (!(Test-Path $path)) { return $false; }
  if ((git status "$path" -s)) {
    git add $path;
    git commit -m "Added/Updated $Name icon" "$path";
  }

  return git log -1 --format="%H" "$path";
}

function Replace-IconUrl{
  param(
    [string]$NuspecPath,
    [string]$CommitHash,
    [string]$IconPath,
    [string]$GithubRepository
  )

  $nuspec = gc "$NuspecPath" -Encoding UTF8
  $oldContent = ($nuspec | Out-String) -replace '\r\n?',"`n"

  $url = "https://cdn.rawgit.com/$GithubRepository/$CommitHash/$iconPath"

  $nuspec = $nuspec -replace '<iconUrl>.*',"<iconUrl>$url</iconUrl>"

  $output = ($nuspec | Out-String) -replace '\r\n?',"`n"
  if ($oldContent -eq $output) {
    $counts.uptodate++;
    return;
  }
  [System.IO.File]::WriteAllText("$NuspecPath", $output, $encoding);
  $counts.replaced++;
}

function Update-IconUrl{
  param(
    [string]$Name,
    [string]$IconName,
    [string]$IconDir,
    [string]$GithubRepository
  )

  $possibleNames = @($Name);
  if ($IconName) { $possibleNames = @($IconName) + $possibleNames }
  if ($Name.EndsWith('.install') -or $Name.EndsWith('.portable')) {
    $index = $Name.LastIndexOf('.');
    $possibleNames += @($Name.Substring(0, $index))
  }

  foreach ($possibleName in $possibleNames) {

    foreach ($extension in $validExtensions) {
      $iconNameWithExtension = "$possibleName.$extension";
      $commitHash = Test-Icon -Name $possibleName -Extension $extension -IconDir $IconDir;
      if ($commitHash) { break; }
    }
    if ($commitHash) { break; }
  }

  if (!($commitHash)) {
    $counts.missing++;
    $missingIcons.Add($Name);
    return;
  }
  $resolvedPath = Resolve-Path $IconDir/$iconNameWithExtension -Relative;
  $trimming = @(".", "\")
  $iconPath = $resolvedPath.TrimStart($trimming) -replace '\\','/';
  Replace-IconUrl `
    -NuspecPath "$PSScriptRoot/$PackagesDirectory/$Name/$Name.nuspec" `
    -CommitHash $commitHash `
    -IconPath $iconPath `
    -GithubRepository $GithubRepository
}

if ($UseStopwatch) {
  $stopWatch = New-Object System.Diagnostics.Stopwatch
  $stopWatch.Start();
}

If ($Name) {
  Update-IconUrl -Name $Name -IconName $IconName -IconDir "$PSScriptRoot/$RelativeIconDir" -GithubRepository $GithubRepository;
}
else {
  $directories = Get-ChildItem -Path "$PSScriptRoot/$PackagesDirectory" -Directory;

  foreach ($directory in $directories) {
    if ((Test-Path "$($directory.FullName)/$($directory.Name).nuspec")) {
      Update-IconUrl -Name $directory.Name -IconDir "$PSScriptRoot/$RelativeIconDir" -GithubRepository $GithubRepository;
    }
  }
}

if ($UseStopwatch) {
  $stopWatch.Stop();
  Write-Host "Time Used: $($stopWatch.Elapsed)"
}
if ($counts.replaced -eq 0) {
  Write-Host "Congratulations, all found icon urls is up to date."
} else {
  Write-Host "Updated $($counts.replaced) icon url(s)";
}
if ($counts.uptodate -gt 0) {
  Write-Host "$($counts.uptodate) icon url(s) was already up to date.";
}
if ($counts.missing -gt 0) {
  Write-Warning "$($counts.missing) icon(s) was not found!"
  $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Hell Yeah"
  $no  = New-Object System.Management.Automation.Host.ChoiceDescription "&No","No WAY"
  $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
  [int]$defaultChoice = 1
  $message = "Do you want to view the package names?";
  $choice = $host.ui.PromptForChoice($caption, $message, $options, $defaultChoice);
  if ($choice -eq 0) {
    $missingIcons -join "`n";
  }
}
