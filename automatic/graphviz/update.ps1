import-module au

$GraphvizURL = "https://www2.graphviz.org/Packages/<branch>/windows/10/<build>/Release/Win32/"

function global:au_SearchReplace {
  if ($($Latest.PackageName) -match "cmake") {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
          "(?i)(\s+x64:).*"     = "`${1} $($Latest.URL64)"
          "(?i)(checksum64:).*" = "`${1} $($Latest.Checksum64)"
        }
			".\graphviz.nuspec" = @{
				"(?i)(^\s*\<id\>).*(\<\/id\>)" = "`${1}$($Latest.PackageName)`${2}"
			}
    }
	} else {
   @{
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"     = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        }
			".\graphviz.nuspec" = @{
				"(?i)(^\s*\<id\>).*(\<\/id\>)" = "`${1}$($Latest.PackageName)`${2}"
			}
    }
	}
}

function global:au_BeforeUpdate {
  if ($($Latest.PackageName) -match "cmake") {
	  cp "$PSScriptRoot\ver64.tmp" "$PSScriptRoot\legal\VERIFICATION.txt" -Force  
  } else {
	  cp "$PSScriptRoot\ver32.tmp" "$PSScriptRoot\legal\VERIFICATION.txt" -Force  
  }
  Get-RemoteFiles -Purge -NoSuffix
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
$packagename = @{$true="graphviz-$build";$false="graphviz"}[ ($build -eq "cmake") ]
$ext = @{$true="exe";$false="zip"}[ ($build -eq "cmake") ]
$page = Invoke-WebRequest -UseBasicParsing $release_url
$url = $release_url + ( $page.links | Select -last 1 -ExpandProperty href)
$version = Get-Version ( $url -replace("\-win32\.$ext","") )
$version = @{$true="$version";$false="$version-$branch"}[ ($branch -eq "stable") ]

$data = @{
    PackageName  = $packagename
    URL          = $url
    Version      = $version
}

if ($build -eq "cmake") {
    $release_url = $release_url -replace("Win32","x64")
    $page = Invoke-WebRequest -UseBasicParsing $release_url
    $url64 = $release_url + ( $page.links | Select -last 1 -ExpandProperty href)
    $data.Add( "URL64", $url64 )
}

return $data
}


function global:au_GetLatest {
$builds = "cmake","msbuild"; $branches = "stable","development"

$streams = [ordered] @{ }
  foreach( $type in $builds ) {
    foreach( $branch in $branches ) {
    $streams.add( "${type}_${branch}" , ( Get-LatestGraphviz -release $GraphvizURL -build $type -branch $branch ) )
    }
  }
  return @{ Streams = $streams }
}

update -ChecksumFor none
