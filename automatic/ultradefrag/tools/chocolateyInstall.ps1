$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'
$installerType = 'EXE'
$silentArgs = '/S /FULL=1'
$url = "http://sourceforge.net/projects/ultradefrag/files/stable-release/${version}/ultradefrag-${version}.bin.i386.exe/download"
$url64 = "http://sourceforge.net/projects/ultradefrag/files/stable-release/${version}/ultradefrag-${version}.bin.amd64.exe/download"


# Manually uncomment this if you want to run with the beta/prerelease/releasecandidate versions.
# Take care, they keep using different names, this will probably only survive a couple of times.
#
#$version = '{{PackageVersion}}' # e.g. 7.0.0%20beta1
#$version2 = $version -replace "%20", '-'
#$url = "http://sourceforge.net/projects/ultradefrag/files/latest-release-candidates/${version}/ultradefrag-${version2}.bin.i386.exe/download"
#$url64 = "http://sourceforge.net/projects/ultradefrag/files/latest-release-candidates/${version}/ultradefrag-${version2}.bin.amd64.exe/download"

$arguments = @{};
# /NoShellExtension /DisableUsageTracking /NoBootInterface
$packageParameters = $env:chocolateyPackageParameters;

# Default the values
$noShellExtension = $false
$disableUsageTracking = $false
$noBootInterface = $false

# Now parse the packageParameters using good old regular expression
if ($packageParameters) {
    $match_pattern = "\/(?<option>([a-zA-Z]+)):(?<value>([`"'])?([a-zA-Z0-9- _\\:\.]+)([`"'])?)|\/(?<option>([a-zA-Z]+))"
    #"
    $option_name = 'option'
    $value_name = 'value'

    if ($packageParameters -match $match_pattern ){
        $results = $packageParameters | Select-String $match_pattern -AllMatches
        $results.matches | % {
          $arguments.Add(
              $_.Groups[$option_name].Value.Trim(),
              $_.Groups[$value_name].Value.Trim())
      }
    }
    else
    {
      throw "Package Parameters were found but were invalid (REGEX Failure)"
    }

    if ($arguments.ContainsKey("NoShellExtension")) {
        $noShellExtension = $true
    }

    if ($arguments.ContainsKey("DisableUsageTracking")) {
        $disableUsageTracking = $true
    }

    if ($arguments.ContainsKey("NoBootInterface")) {
        $noBootInterface = $true
    }
} else {
    Write-Debug "No Package Parameters Passed in";
}

if ($noShellExtension) { $silentArgs += " /SHELLEXTENSION=0" }
if ($disableUsageTracking) { $silentArgs += " /DISABLE_USAGE_TRACKING=1" }
if ($noBootInterface) { $silentArgs += " /BOOT=0" }

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"

#TODO: Rename the ugly default context-menuitem "------UltraDefrag---------" to "Ultra Defragmenter"
