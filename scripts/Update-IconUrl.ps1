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

.PARAMETER Quiet
  Do not write normal output to host.
  NOTE: Output from git and Write-Warning will still be available

.PARAMETER ThrowErrorOnIconNotFound
  Throw an error if a icon for the specified package is not found.
  NOTE: Only available when updating a single icon.

.OUTPUTS
  The number of packages that was updates,
  if some packages is already up to date, outputs how many.
  Writes a warning of how many packages where icons was not found,
  then optionally outputs which packages.

.NOTES
  Currently supports icons with the following extensions
  (png, svg, jpg, ico)

.EXAMPLE
  ps> .\Update-IconUrl.ps1
  Updates all nuspec files with matching icons
-    <iconUrl>https://cdn.rawgit.com/AdmiringWorm/chocolatey-packages/e4a49519947c3cff55c17a0b08266c56b0613e64/icons/thunderbird.png</iconUrl>
+    <iconUrl>https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/thunderbird.png</iconUrl>

.EXAMPLE
  ps> .\Update-IconUrl.ps1 -Name 'SQLite'
  Updates only a single nuspec file with the specified name with its matching icon
-    <iconUrl>https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/e4a49519947c3cff55c17a0b08266c56b0613e64/icons/speccy.png</iconUrl>
+    <iconUrl>https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/edba4a5849ff756e767cba86641bea97ff5721fe/icons/speccy.png</iconUrl>

.EXAMPLE
  ps> .\Updates-IconUrl.ps1 -Name 'youtube-dl' -IconName 'y-dl'
  Updates only a single nuspec file with the specified name with the icon matching the specified IconName
-    <iconUrl>https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/e4a49519947c3cff55c17a0b08266c56b0613e64/icons/y-dl.svg</iconUrl>
+    <iconUrl>https://cdn.rawgit.com/chocolatey/chocolatey-coreteampackages/a42da86c9cc480a5f3f23677e0d73d88416a3b3c/icons/y-dl.svg</iconUrl>

.EXAMPLE
  ps> .\Updates-IconUrl.ps1 -Name "thunderbird" -UseStopwatch
  ps> .\Updates-IconUrl.ps1 -UseStopwatch
  While also updating the nuspec file this will also output the time it took for the script to finish
  output> "Time Used: 00:00:27.4720531"

.EXAMPLE
  Possible output for all calls

  Output if found
  output> Updated 1 icon url(s)

  Output if already up to date
  output> Congratulations, all found icon urls is up to date.
  output> 1 icon url(s) was already up to date.

  Output if not found
  output> WARNING: 2 icon url(s) was not found!
  output> Do you want to view the package names?
  input< y
  output> tuniac
  output> youtube-dl
#>

param(
  [string]$Name = $null,
  [string]$IconName = $null,
  [string]$GithubRepository = "chocolatey/chocolatey-coreteampackages",
  [string]$RelativeIconDir = "../icons",
  [string]$PackagesDirectory = "../automatic",
  [switch]$UseStopwatch,
  [switch]$Quiet,
  [switch]$ThrowErrorOnIconNotFound
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
    git add $path | Out-Null;
    git commit -m "Added/Updated $Name icon" "$path" | Out-Null;
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
    [string]$GithubRepository,
    [bool]$Quiet
  )

  $possibleNames = @($Name);
  if ($IconName) { $possibleNames = @($IconName) + $possibleNames }

  $validSuffixes = @(".install"; ".portable"; ".commandline")

  $suffixMatch = $validSuffixes | ? { $Name.EndsWith($_) } | select -first 1

  if ($suffixMatch) {
    $possibleNames += $Name.TrimEnd($suffixMatch)
  }

  # Let check if the package already contains a url, and get the filename from that
  $content = gc "$PSScriptRoot/$PackagesDirectory/$Name/$Name.nuspec" -Encoding UTF8

  if ($content | ? { $_ -match 'Icon(Url)?:\s*Skip( check)?' }) {
    if (!($Quiet)) {
      Write-Warning "Skipping icon check for $Name"
    }
    return;
  }

  $content | ? { $_ -match "\<iconUrl\>(.+)\<\/iconUrl\>" } | Out-Null
  if ($Matches) {
    $url = $Matches[1]
    $index = $url.LastIndexOf('/')
    if ($index -gt 0) {
      $fileName = $url.Substring($index + 1)
      $index = $fileName.IndexOf('.')
      if ($index -gt 0) {
        $fileName = $fileName.Substring(0, $index)
        $possibleNames += @($fileName)
      }
    }
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
  Update-IconUrl -Name $Name -IconName $IconName -IconDir "$PSScriptRoot/$RelativeIconDir" -GithubRepository $GithubRepository -Quiet $Quiet
}
else {
  $directories = Get-ChildItem -Path "$PSScriptRoot/$PackagesDirectory" -Directory;

  foreach ($directory in $directories) {
    if ((Test-Path "$($directory.FullName)/$($directory.Name).nuspec")) {
      Update-IconUrl -Name $directory.Name -IconDir "$PSScriptRoot/$RelativeIconDir" -GithubRepository $GithubRepository -Quiet $Quiet
    }
  }
}

if ($UseStopwatch) {
  $stopWatch.Stop();
  if (!Quiet) {
    Write-Host "Time Used: $($stopWatch.Elapsed)"
  }
}
if ($counts.replaced -eq 0 -and !$Quiet) {
  Write-Host "Congratulations, all found icon urls is up to date."
} elseif (!$Quiet) {
  Write-Host "Updated $($counts.replaced) icon url(s)";
}
if ($counts.uptodate -gt 0 -and !$Quiet) {
  Write-Host "$($counts.uptodate) icon url(s) was already up to date.";
}
if ($counts.missing -gt 1) {
  Write-Warning "$($counts.missing) icon(s) was not found!"
  if (!$PrintMissingIcons -and !$Quiet) {
    $yes = New-Object System.Management.Automation.Host.ChoiceDescription "&Yes", "Hell Yeah"
    $no  = New-Object System.Management.Automation.Host.ChoiceDescription "&No","No WAY"
    $options = [System.Management.Automation.Host.ChoiceDescription[]]($yes, $no)
    [int]$defaultChoice = 1
    $message = "Do you want to view the package names?";
    $choice = $host.ui.PromptForChoice($caption, $message, $options, $defaultChoice);
  } elseif($Quiet) {
    $choice = 1
  } else {
    $choice = 0
  }
  if ($choice -eq 0) {
    Write-Warning "We did not found an icon for the following packages"
    $missingIcons -join "`n";
  }
}elseif ($counts.missing -eq 1) {
  $package = $missingIcons[0]
  if ($ThrowErrorOnIconNotFound) {
    throw "Unable to find icon url for $package"
  } else {
    Write-Warning "Unable to find icon url for $package"
  }
}
