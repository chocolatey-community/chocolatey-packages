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

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url" "$url64"

#TODO: Rename the ugly default context-menuitem "------UltraDefrag---------" to "Ultra Defragmenter"
