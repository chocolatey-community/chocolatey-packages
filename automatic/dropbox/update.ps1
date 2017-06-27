Import-Module au
import-module "$PSScriptRoot\..\..\scripts\au_extensions.psm1"

function global:au_AfterUpdate { Set-DescriptionFromReadme -SkipFirst 1 }

function global:au_SearchReplace {
    return @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.Url32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
    $releases = 'https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016'
    $HTML = Invoke-WebRequest -UseBasicParsing -Uri $releases
    $stable_builds = @()
    $nonstable_builds = @()
    $HTML.Links | foreach {
  	  if ($_.href -match "stable" ) { $stable_builds += $_.href }
  	  if ($_.href -match "beta" ) { $nonstable_builds += $_.href }
    }
    $re_dash = '-'; $re_dashndigits = "\-\D+"; $re_t5 = 't5'; $re_abc = '[a-z]\w+'; $re_num_M = '\d+\#[M]\d+';
    $re_dot = '.'; $re_non = ''; $re_stable = 'Stable-'; $re_nonstable = 'Beta-'; $re_build = 'Build-';
	   $nonstable_version =  ( drpbx-builds -hrefs $nonstable_builds -nonstable_build $true )
	   $stable_version = ( drpbx-builds -hrefs $stable_builds -nonstable_version $nonstable_version )
    $downloadUrl = "https://dl-web.dropbox.com/u/17/Dropbox%20${stable_version}.exe"

    return @{
    URL32 = $downloadUrl;
    Version = $stable_version;
    }
}

function drpbx-builds {
	param(
		[string]$hrefs,
		[string]$nonstable_version,
		[bool]$nonstable_build
	)
    $links = $hrefs
    $links = $links -split ( '\/' ); $build = @()
	   $build_version = @{$true=($re_nonstable + $re_build);$false=($re_stable + $re_build)}[( ($nonstable_build) )]
    foreach( $_ in $links ) {
     $_ = $_ -replace ( ($build_version), $re_non ) -replace ( $re_dashndigits , $re_non ) -replace ($re_dash , $re_dot ) -replace ( $re_t5 , $re_non ) -replace ($re_abc  , $re_non ) -replace ( $re_num_M , $re_non )
      if (( $nonstable_build )) {
        if ( $_ -ge '27.3.21' ) {
        if ( $_ -match '(\d+\.)?(\d+\.)?(\*|\d+)') {
        $build = $_
        break;
        }
      }
		} else {
      $_ = $_  -replace ('m', $re_non )
			if (( $_ -ge '27.3.21' ) -and ( $_ -le $nonstable_version )) {
			$build = $_
			break;
			}
		}
    }
	return $build
}

update -ChecksumFor 32

