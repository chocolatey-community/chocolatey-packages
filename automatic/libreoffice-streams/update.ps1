import-module au

function global:au_BeforeUpdate {
  if ($Latest.Title -like '*Fresh*') {
    cp "$PSScriptRoot\README.fresh.md" "$PSScriptRoot\README.md" -Force
  }
  else {
    cp "$PSScriptRoot\README.still.md" "$PSScriptRoot\README.md" -Force
  }
}

function global:au_SearchReplace {
  $filesToPatchHashTable = @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL32)'"
      "(?i)(^\s*url64bit\s*=\s*)('.*')"   = "`$1'$($Latest.URL64)'"
      "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
      "(?i)(^\s*checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
    }
    ".\libreoffice-streams.nuspec"  = @{
      "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
    }
  }

  $linesToPatch = $filesToPatchHashTable[".\tools\chocolateyInstall.ps1"]
  if ($Latest.FileType -eq "exe") {
    $linesToPatch["(?i)(^\s*silentArgs\s*=\s*)('.*')"] = "`$1'/S'"
  } else {
    $linesToPatch["(?i)(^\s*silentArgs\s*=\s*)('.*')"] = "`$1'/passive /norestart /l*v `"`$Env:TEMP\chocolatey\`$Env:ChocolateyPackageName\`$Env:ChocolateyPackageVersion\install.log`"'"
  }
  $filesToPatchHashTable[".\tools\chocolateyInstall.ps1"] = $linesToPatch

  return $filesToPatchHashTable
}

function global:au_GetLatest {

  # Send a generic request to the LibreOffice update service
  function UpdateService.GetLatestVersion($userAgent) {
    $url = "https://update.libreoffice.org/check.php"
    $answer = Invoke-WebRequest $url -UserAgent $userAgent -UseBasicParsing
    [xml]$xmlAnswer = $answer.Content
    return $xmlAnswer.description.version
  }

  # Send a request to the LibreOffice update service to get the latest stable
  # version
  function UpdateService.GetLatestStableVersion() {
    # We are taking the build UUID of 3.5.7. This is needed because the update
    # service is determining which branch to take depending on the third dot
    # number. If the latest fresh release has a third dot number greater or
    # equal to the third dot number we specified (here 7), the fresh branch is
    # returned, otherwise this is the stable branch.
    # src.: https://web.archive.org/web/20190806174607/https://cgit.freedesktop.org/libreoffice/website/tree/check.php?h=update&id=c0c4940e998a0f5fbeb57910b1dfe6778226c51b#n665
    return UpdateService.GetLatestVersion "LibreOffice 0 (3215f89-f603614-ab984f2-7348103-1225a5b; Chocolatey; x86; )"
  }

  # Send a request to the LibreOffice update service to get the latest fresh
  # version
  function UpdateService.GetLatestFreshVersion() {
    # We are taking the build UUID of 3.5.0.1 here for the same explanation
    # as before.
    return UpdateService.GetLatestVersion "LibreOffice 0 (b6c8ba5-8c0b455-0b5e650-d7f0dd3-b100c87; Chocolatey; x86; )"
  }

  # Get all the links from a MirrorBrain instance without the copyright
  # and owner links
  function MirrorBrain.GetAllBuildsFromUrl($url) {
    $page = Invoke-WebRequest -Uri $url -UseBasicParsing
    $linksArray = @($page.Links)
    # ? outputs all items that conform with condition (here: TryParse returning
    # a boolean). As if it was "foreach { if (...) {return ... } }"
    # The returned values are still a string that must be parsed to a Version object.
    return @($linksArray | % href | % {$_ -Split '/' } | ? { [version]::TryParse($_, [ref]($__)) })
  }

  function MirrorBrain.GetLatestVersion($builds) {
    # Declaring a [version] typed variable is needed because TryParse expects a
    # reference. The object must thus exist.
    [version]$buildVersion = New-Object -TypeName System.Version
    foreach ($release in $builds) {
      [void][version]::TryParse($release, [ref]$buildVersion)
      if ($freshVersion -eq $null) {
        [version]$freshVersion = $buildVersion
      } elseif ("$($buildVersion.Major).$($buildVersion.Minor)" -ne
                "$($previousRelease.Major).$($previousRelease.Minor)") {
          [version]$stillVersion = $buildVersion
          break
      }
      $previousRelease = $buildVersion
    }
    return @{fresh = $freshVersion; still = $stillVersion}
  }

  function GetBuildHash($url) {
    if ([string]::IsNullOrEmpty($url)) {
      return $null
    }
    [xml]$page = Invoke-WebRequest -Uri "$url.mirrorlist" -UseBasicParsing
    return $page.html.body.div.div.ul.li[4].tt
  }

  function IsUrlValid($url) {
    try {
      [System.Net.HttpWebRequest]$request = [System.Net.WebRequest]::Create($url)
      $request.Method = "HEAD"
      # GetResponse raises a WebException when an error occurred.
      $response = $request.GetResponse()
      $status = [int]$response.StatusCode
      $response.Close()
      if ($status -eq 200) {
        return $true
      } else {
        return $false
      }
    } catch {
      return $false
    }
  }

  function GetBranchVersion([version]$version) {
    [version]$branchVersion = New-Object -TypeName System.Version
    [void][version]::TryParse("$($version.Major).$($version.Minor)", [ref]$branchVersion)
    return $branchVersion
  }

  function GetReleasesToBuildsMapping($builds) {
    # Get correspondance between release and build versions. This step is
    # needed to determinate the URL and get releases without CDN.
    # e.g. 6.2.0 => 6.2.0.3
    $mapping = [ordered]@{}
    [version]$buildVersion = New-Object -TypeName System.Version

    # The last one is never populated, prevent this by adding one additional
    # different item in order for the loop to work properly.
    [System.Collections.ArrayList]$buildsPlusOne = $builds
    $buildsPlusOne.Add("0.0.0.")

    foreach ($build in $buildsPlusOne) {
      [void][version]::TryParse($build, [ref]$buildVersion)
      $releaseId = "$($buildVersion.Major).$($buildVersion.Minor).$($buildVersion.Build)"

      if ($releaseId -ne $previousReleaseId -and $previousReleaseId -ne $null) {
        $mapping.add($previousReleaseId, $previousBuildId)
      }

      $previousReleaseId = $releaseId
      $previousBuildId = $build

    }

    return $mapping
  }

  function GetFilename($url, $releasesMapping, $release, $arch) {
    # Sorted to most likely to less likely to avoid unneeded tests
    $filenamePatterns = @(
      "LibreOffice_[VERSION]_Win_[ARCH].msi",
      "LibO_[VERSION]_Win_[ARCH]_install_multi.msi",
      "LibO_[VERSION]_Win_[ARCH]_install_multi.exe",
      "LibO_[VERSION]_Win_[ARCH]_install_all_lang.msi",
      "LibO_[VERSION]_Win_[ARCH]_install_all_lang.exe"
    )
    $filename64bitsPatterns = @(
      "x86_64",
      "x64"
    )
    $filename32bitsPatterns = @(
      "x86"
    )

    if ($arch -eq "x64") {
      $folderArchPattern = "x86_64"
      $filenameArchPatterns = $filename64bitsPatterns
    } else {
      $folderArchPattern = "x86"
      $filenameArchPatterns = $filename32bitsPatterns
    }

    $urlFolder = "${url}$($releasesMapping.$release)/win/$folderArchPattern/"

    # No need to go further if the folder doesn't even exist. i.e. typically
    # the case when only 32 bits version are available.
    if (!(IsUrlValid "$urlFolder")) {
      Write-Host "$urlFolder doesn't exist"
      return $null
    }

    [System.Collections.ArrayList]$filenames = @()

    # Test all possible URL variants with filename patterns and arch patterns
    foreach ($filename in $filenamePatterns) {
      foreach ($archPattern in $filenameArchPatterns) {
        # Replace template URL by assuming the release id is used, e.g. 6.2.0
        [void]$filenames.Add($($filename -Replace "\[VERSION\]","$release" -Replace "\[ARCH\]","$archPattern"))
        # Replace template URL by assuming the build id is used instead, e.g. 6.2.0.0
        [void]$filenames.Add($($filename -Replace "\[VERSION\]","$($releasesMapping.$release)" -Replace "\[ARCH\]","$archPattern"))
      }
    }

    foreach ($filename in $filenames) {
      $completeUrl = "${urlFolder}${filename}"
      Write-Host "Testing $completeUrl..."
      # As soon we have a valid URL, break the loop and go to the next release
      if (IsUrlValid "$completeUrl") {
        Write-Host "Testing $completeUrl is valid."
        return "$completeUrl"
      }
    }
    return $null
  }

  # Generate an array with all the LibreOffice versions that exist from one
  # branch to another with checksum and valid links ath the time.
  function GetBigArrayMapping($fromBranch, $toBranch) {

    # Principle:
    # All builds are located on the stable release, we are just replacing the
    # build URLs from the stable server with URLs from CDN servers when
    # available.

    # Define table
    # src.: https://blogs.msdn.microsoft.com/rkramesh/2012/02/01/creating-table-using-powershell/
    $table = New-Object System.Data.DataTable

    # Define and add columns
    $table.columns.add($(New-Object System.Data.DataColumn Branch))
    $table.columns.add($(New-Object System.Data.DataColumn Version))
    $table.columns.add($(New-Object System.Data.DataColumn Build))
    $table.columns.add($(New-Object System.Data.DataColumn Url64))
    $table.columns.add($(New-Object System.Data.DataColumn Checksum64))
    $table.columns.add($(New-Object System.Data.DataColumn Url32))
    $table.columns.add($(New-Object System.Data.DataColumn Checksum32))

    $url = 'https://downloadarchive.documentfoundation.org/libreoffice/old/'
    $builds = MirrorBrain.GetAllBuildsFromUrl $url | Sort-Object
    $releasesMapping = GetReleasesToBuildsMapping $builds

    foreach ($release in $releasesMapping.Keys) {

      # Check limits
      $branch = GetBranchVersion $release
      if ($branch -lt $fromBranch) {
        continue
      } elseif ($branch -gt $toBranch) {
        break
      }

      # Create a row
      $row = $table.NewRow()

      $row.Branch = $branch
      $row.Version = $release
      $row.Build = $releasesMapping.$release

      # Find 64 bits version if any. At the beginning of the LibreOffice
      # project, there weren't 64 bits versions for Windows.
      $row.Url64 = GetFilename $url $releasesMapping $release "x64"
      $row.Checksum64 = GetBuildHash $row.Url64
      
      $row.Url32 = GetFilename $url $releasesMapping $release "x86"
      $row.Checksum32 = GetBuildHash $row.Url32

      # Add the row to the table
      $table.Rows.Add($row)
    }

    # At TDF, all released builds in the stable folder are those that are being
    # under CDN. Change link to those in CDN instead.
    $url = 'https://download.documentfoundation.org/libreoffice/stable/'
    $builds = MirrorBrain.GetAllBuildsFromUrl $url | Sort-Object
    $releasesMapping = [ordered]@{}
    foreach ($release in $builds) {
      $releasesMapping.Add($release, $release)
    }
    foreach ($release in $releasesMapping.Keys) {
      foreach ($row in $table) {
        if ($row.Version -eq $release) {
          $row.Url64 = GetFilename $url $releasesMapping $release "x64"
          $row.Url32 = GetFilename $url $releasesMapping $release "x86"
        }
      }
    }

    return $table
  }

  function BuildStreams($fromBranch, $toBranch) {

    $table = GetBigArrayMapping $fromBranch $toBranch

    # Create an OrderedDictionary dictionary for the streams
    $streams = [ordered]@{}
    
    foreach ($row in $table) {
      # The package variable needs to be a hashtable. Therefore, we cannot use
      # an OrderedDictionary with the [ordered] keyword. The dictionary keys
      # will unfortunately appear in random order.
      $package = @{}
      if ($row.Branch -lt $toBranch) {
        $package.PackageName = "libreoffice-still"
        $package.Title = "LibreOffice Still"
        $package.StreamName = "$($row.Version).still"
      } else {
        $package.PackageName = "libreoffice-fresh"
        $package.Title = "LibreOffice Fresh"
        $package.StreamName = "$($row.Version).fresh"
      }
      $package.Version = $row.Version
      $package.URL64 = $row.URL64
      $package.Checksum64 = $row.Checksum64
      $package.URL32 = $row.URL32
      $package.Checksum32 = $row.Checksum32

      # Remove package type. Msi installers do not need a chocolatey filetype.
      # This change is needed to detect the installer arguments and change
      # installer parameters in au_SearchReplace.
      $package.FileType = $package.URL32 -Replace ".*",""

      # Add package to streams
      $streams["$($package.StreamName)"] = $package

      # Also add still versions to the fresh branch in order to keep the whole
      # history in the fresh branch as well.
      # If the limits are branch 6.1 and 6.2, this adds the 6.1 version to
      # the fresh branch as well, because with the condition from above, this
      # was only adding to the still branch.
      if ($row.Branch -lt $toBranch) {
        $package.PackageName = "libreoffice-fresh"
        $package.Title = "LibreOffice Fresh"
        $package.StreamName = "$($row.Version).fresh"
        $streams["$($package.StreamName)"] = $package
      }
    }

    # Sort streams in reverse order (latest versions above) in order to comply
    # with assumption made by AU, the chocolatey extension to auto update
    $sortedStreams = $streams.GetEnumerator() | Sort-Object -Property Name -Descending
    $streams = [ordered]@{}
    for ($i = 0; $i -lt $sortedStreams.count; $i++) {
      Write-Host "DEBUG:::: $($sortedStreams.Name[$i])"
      $streams.Add($sortedStreams.Name[$i], $sortedStreams.Value[$i])
    }

    return $streams
  }

  #$streams = BuildStreams "6.1" "6.2"
  $streams = BuildStreams "6.1" "6.2"

  return @{ Streams = $streams }
}

update -ChecksumFor none