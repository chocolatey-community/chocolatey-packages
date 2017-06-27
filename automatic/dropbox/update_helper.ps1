
function drpbx-compare {
	param(
		[string]$nonstable_version
	)
    $releases = 'https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016'
    $HTML = Invoke-WebRequest -UseBasicParsing -Uri $releases
    $stable_builds = @()
    $HTML.Links | foreach {
  	  if ($_.href -match "stable" ) { $stable_builds += $_.href }
    }
    $re_dash = '-'; $re_dashndigits = "\-\D+"; $re_t5 = 't5'; $re_abc = '[a-z]\w+'; $re_num_M = '\d+\#[M]\d+';
    $re_dot = '.'; $re_non = ''; $re_stable = 'Stable-'; $re_build = 'Build-';
    $stable_version = ( drpbx-builds -hrefs $stable_builds -nonstable_version $nonstable_version )
    return $stable_version
}

function drpbx-builds {
	param(
		[string]$hrefs,
		[string]$nonstable_version,
		[bool]$nonstable_build
	)
    $links = $hrefs
    $links = $links -split ( '\/' ); $build = @()
    $build_version = ($re_stable + $re_build)
    foreach( $_ in $links ) {
     $_ = $_ -replace ( ($build_version), $re_non ) -replace ( $re_dashndigits , $re_non ) -replace ($re_dash , $re_dot ) -replace ( $re_t5 , $re_non ) -replace ($re_abc  , $re_non ) -replace ( $re_num_M , $re_non )
      $_ = $_  -replace ('m', $re_non )
			if (( $_ -ge '27.3.21' ) -and ( $_ -le $nonstable_version )) {
			$build = $_
			break;
			}
    }
	return $build
}
