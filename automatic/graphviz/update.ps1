import-module au
. "$PSScriptRoot\update_helper.ps1"

$GraphvizURL = "https://www2.graphviz.org/Packages/<branch>/windows/10/<build>/Release/Win32/"

function global:au_BeforeUpdate {
    Set-ReadMeFile -keys "PackageName" -new_info "$($Latest.PackageName)"
    Get-RemoteFiles -Purge -NoSuffix
}

function global:au_SearchReplace {
@{
  "$PSScriptRoot\tools\chocolateyInstall.ps1" = @{
    "(?i)(^\s*packageName\s*=\s*)('.*')"    = "`$1'$($Latest.PackageName)'"
    "(?i)(^[$]file\s*=\s*)('.*')"           = "`$1'$($Latest.FileName32)'"
    "(?i)(^[$]file64\s*=\s*)('.*')"         = "`$1'$($Latest.FileName64)'"
    "(?i)(^\s*softwareName\s*=\s*)('.*')"   = "`$1'$($Latest.Title)'"
    "(?i)(^\s*fileType\s*=\s*)('.*')"       = "`$1'$($Latest.FileType)'"
  }
    "$PSScriptRoot\tools\chocolateyUninstall.ps1" = @{
    "(?i)(^\s*packageName\s*=\s*)('.*')"    = "`$1'$($Latest.PackageName)'"
    "(?i)(^\s*fileType\s*=\s*)('.*')"       = "`$1'$($Latest.FileType)'"
  }
  "$PSScriptRoot\graphviz.nuspec" = @{
    "(?i)(^\s*\<id\>).*(\<\/id\>)"       = "`${1}$($Latest.PackageName)`${2}"
    "(?i)(^\s*\<title\>).*(\<\/title\>)" = "`${1}$($Latest.Title)`${2}"
  }
  "$PSScriptRoot\legal\VERIFICATION.txt" = @{
    "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
    "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
    "(?i)(\s+x64:).*"     = "`${1} $($Latest.URL64)"
    "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
  }
}

function Get-LatestGraphviz {
param(
    [string]$release,
    [ValidateSet('cmake','msbuild')]
    [string]$build,
    [ValidateSet('stable','development')]
    [string]$branch = "stable"
)

$release_url = $release -replace("<build>", $build) -replace("<branch>", $branch )
$packagename = @{$true="graphviz-$build";$false="graphviz"}[ ($build -eq "msbuild") ]
$title = "graphviz $build ($branch)"; $ext = @{$true="exe";$false="zip"}[ ($build -eq "cmake") ]
$page = Invoke-WebRequest -UseBasicParsing $release_url
$url = $release_url + ( $page.links | Select -last 1 -ExpandProperty href)
$version = Get-Version ( $url -replace("\-win32\.$ext","") )
$version = @{$true="$version";$false="$version-$branch"}[ ($branch -eq "stable") ]
$data = @{
    PackageName  = $packagename
    Title        = $title
    URL32        = $url
    Version      = $version
}

if ($ext -eq "exe") {
    $release_url = $release_url -replace("Win32","x64")
    $page = Invoke-WebRequest -UseBasicParsing $release_url
    $url64 = $release_url + ( $page.links | Select -last 1 -ExpandProperty href)
    $data.Add( "URL64", $url64 )
}

return $data
}

function global:au_GetLatest {
$builds = "cmake"; $branches = "stable","development"
$streams = [ordered] @{ }
  foreach( $type in $builds ) {
    foreach( $branch in $branches ) {
    $streams.add( "${type}_${branch}" , ( Get-LatestGraphviz -release $GraphvizURL -build $type -branch $branch ) )
    }
  }
  return @{ Streams = $streams }
}

update -ChecksumFor none
