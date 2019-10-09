# Send a generic request to the LibreOffice update service
function GetLatestVersionFromLibOUpdateChecker($userAgent) {
  $url = "https://update.libreoffice.org/check.php"
  $request = [System.Net.WebRequest]::Create($url)
  $request.UserAgent = $userAgent
  $s = $request.GetResponse().GetResponseStream()
  $sr = New-Object -TypeName System.IO.StreamReader($s)
  [xml]$xmlAnswer = $sr.ReadToEnd()
  return $xmlAnswer.description.version
}

# Send a request to the LibreOffice update service to get the latest Still
# version
function GetLatestStillVersionFromLibOUpdateChecker() {
  # We are taking the build UUID of 3.5.7. This is needed because the update
  # service is determining which branch to take depending on the third dot
  # number. If the latest fresh release has a third dot number greater or
  # equal to the third dot number we specified (here 7), the fresh branch is
  # returned, otherwise this is the Still branch.
  # src.: https://web.archive.org/web/20190806174607/https://cgit.freedesktop.org/libreoffice/website/tree/check.php?h=update&id=c0c4940e998a0f5fbeb57910b1dfe6778226c51b#n665
  return GetLatestVersionFromLibOUpdateChecker "LibreOffice 0 (3215f89-f603614-ab984f2-7348103-1225a5b; Chocolatey; x86; )"
}

# Send a request to the LibreOffice update service to get the latest fresh
# version
function GetLatestFreshVersionFromLibOUpdateChecker() {
  # We are taking the build UUID of 3.5.0.1 here for the same explanation
  # as before.
  return GetLatestVersionFromLibOUpdateChecker "LibreOffice 0 (b6c8ba5-8c0b455-0b5e650-d7f0dd3-b100c87; Chocolatey; x86; )"
}

# Get all the links from a MirrorBrain instance without the copyright
# and owner links
function GetAllBuildsFromMirrorBrainUrl($url) {

  $request = [System.Net.WebRequest]::Create($url)
  $s = $request.GetResponse().GetResponseStream()
  $sr = New-Object -TypeName System.IO.StreamReader($s)
  $answer = $sr.ReadToEnd()
  [xml]$xmlAnswer = [System.Net.WebUtility]::HtmlDecode($answer)
  $linksArray =  $xmlAnswer.GetElementsByTagName("a")
  # ? outputs all items that conform with condition (here: TryParse returning
  # a boolean). As if it was "foreach { if (...) {return ... } }"
  # The returned values are still a string that must be parsed to a Version object.
  return @($linksArray | % href | % {$_ -Split '/' } | ? { [version]::TryParse($_, [ref]($__)) })
}

function GetAllBuildsFromMirrorBrainBuilds($builds) {
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

function GetBuildHashFromMirrorBrainUrl($url) {
  if ([string]::IsNullOrEmpty($url)) {
    return $null
  }

  # We are not using the $url/sha256 suffix because that file is missing
  # from downloadarchive :/
  $request = [System.Net.WebRequest]::Create("$url.sha256")
  $s = $request.GetResponse().GetResponseStream()
  $sr = New-Object -TypeName System.IO.StreamReader($s)
  $answer = $sr.ReadToEnd()

  return $answer.Split(" ")[0]
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

# Get correspondance between release and build versions
# e.g. 6.2.0 => 6.2.0.3
function BuildLibOReleasesToBuildsMapping($builds) {

  $mapping = New-Object -TypeName System.Collections.Specialized.OrderedDictionary  
  $buildVersion = New-Object -TypeName System.Version

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
    Write-Debug "$urlFolder doesn't exist"
    return $null
  }

  [System.Collections.ArrayList]$filenames = @()

  # Build all possible URL variants with filename patterns and arch patterns
  foreach ($filename in $filenamePatterns) {
    foreach ($archPattern in $filenameArchPatterns) {
      # Replace template URL by assuming the release id is used, e.g. 6.2.0
      [void]$filenames.Add($($filename -Replace "\[VERSION\]","$release" -Replace "\[ARCH\]","$archPattern"))
      # Replace template URL by assuming the build id is used instead, e.g. 6.2.0.0
      [void]$filenames.Add($($filename -Replace "\[VERSION\]","$($releasesMapping.$release)" -Replace "\[ARCH\]","$archPattern"))
    }
  }

  # test all the filename variants we crafted
  foreach ($filename in $filenames) {
    $completeUrl = "${urlFolder}${filename}"
    Write-Debug "Testing $completeUrl..."
    # As soon we have a valid URL, break the loop and go to the next release
    if (IsUrlValid "$completeUrl") {
      Write-Debug "Testing $completeUrl is valid."
      return "$completeUrl"
    }
  }
  return $null
}

# Generate an array with all the LibreOffice versions that exist from one
# version to another with checksums and valid links at the time.
function GetLibOVersions($fromVersion, $toVersion) {

  # Define table and columns
  # src.: https://blogs.msdn.microsoft.com/rkramesh/2012/02/01/creating-table-using-powershell/
  $table = New-Object System.Data.DataTable
  $table.columns.add($(New-Object System.Data.DataColumn Version))
  $table.columns.add($(New-Object System.Data.DataColumn Build))
  $table.columns.add($(New-Object System.Data.DataColumn Url64))
  $table.columns.add($(New-Object System.Data.DataColumn Checksum64))
  $table.columns.add($(New-Object System.Data.DataColumn Url32))
  $table.columns.add($(New-Object System.Data.DataColumn Checksum32))

  # Get all versions from the downloadarchive according to the limits
  # specified above.
  $url = 'https://downloadarchive.documentfoundation.org/libreoffice/old/'
  $builds = GetAllBuildsFromMirrorBrainUrl $url | Sort-Object
  $releasesMapping = BuildLibOReleasesToBuildsMapping $builds
  foreach ($release in $releasesMapping.Keys) {

    if ($release -lt $fromVersion) {
      continue
    } elseif ($release -gt $toVersion) {
      break
    }

    $row = $table.NewRow()
    $row.Version = $release
    $row.Build = $releasesMapping.$release

    # Find 64 bits version if any. At the beginning of the LibreOffice
    # project, there weren't 64 bits versions for Windows.
    $row.Url64 = GetFilename $url $releasesMapping $release "x64"
    $row.Checksum64 = GetBuildHashFromMirrorBrainUrl $row.Url64

    $row.Url32 = GetFilename $url $releasesMapping $release "x86"
    $row.Checksum32 = GetBuildHashFromMirrorBrainUrl $row.Url32

    $table.Rows.Add($row)
  }

  # If versions are under CDN use the links from the CDN instead.
  # We assume, all released builds in the stable folder are those that are
  # being under CDN.
  $url = 'https://download.documentfoundation.org/libreoffice/stable/'
  $builds = GetAllBuildsFromMirrorBrainUrl $url | Sort-Object
  # $releasesMapping is an ordered dictionnary containing
  # mappings like 6.2.0 => 6.2.0.3
  $releasesMapping = New-Object -TypeName System.Collections.Specialized.OrderedDictionary  
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

  # Powershell doesn't have all the enumerable tools implemented with the
  # .NET collections reponsible of the proper unrolling arrays/collections,
  # which means if we want our DataTable to be returned under this type,
  # we need to wrap the collection into a dummy array with a heading comma
  # operator.
  # src.: https://stackoverflow.com/a/1918455/3514658
  return ,$table
}

function GetLibOVersionsIntervalOnly($fromVersion, $toVersion) {
  
  $versions = GetLibOVersions $from $to

  # Discard the first version since it is the current one that has already
  # been pushed to Chocolatey.
  if ($versions.Rows.Count -gt 0) {
    $versions.Rows[0].Delete()
  }

  # Casting needed for the same reason as above
  return ,$versions
}

function GetLibOExactVersion($version) {
    $versions = GetLibOVersions $version $version
    return ,$versions
}

function AddLibOVersionsToStreams($streams, $branch, $from, $to) {

  $versions = GetLibOVersionsIntervalOnly $from $to

  foreach ($row in $versions) {

    # The package variable needs to be a hashtable. Therefore, we cannot use
    # an OrderedDictionary. Tradeoff: The dictionary keys will unfortunately
    # appear in random order.
    # $row is a DataRow, we have to convert manually to a hashtable.
    $package = @{}
    $package.Version = $row.Version
    $package.URL64 = $row.URL64
    $package.Checksum64 = $row.Checksum64
    $package.URL32 = $row.URL32
    $package.Checksum32 = $row.Checksum32
    $package.FileType = $package.URL32 -Replace ".*",""
    if ($branch -eq "still") {
      $package.PackageName = "libreoffice-still"
      $package.Title = "LibreOffice Still"
    } else {
      $package.PackageName = "libreoffice-fresh"
      $package.Title = "LibreOffice Fresh"
    }
    
    # Add package to streams. By adding the branch name to the hashtable
    # key name, we are hacking the way AU streams are working here
    # (bypassing hashtables key unicity) in order to avoid gaps when
    # updating LibreOffice versions.
    $streams.Add("$($package.Version).$branch", $package)
  }

  return $streams
}