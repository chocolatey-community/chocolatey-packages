
function drpbx-compare {
	param( 
[Parameter(Position = 0)][string]$_version, [string]$build = 'stable' )
    $releases = 'https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016'
    $HTML = (Invoke-WebRequest -UseBasicParsing -Uri $releases).Links`
     | where {($_ -match $build)} | Select -First 6 | out-string
    $re_dash = '-'; $re_dot = '.'; $re_non = ''; $re_build = $build + "-Build-";
    $version = (drpbx-builds -hrefs $HTML -testVersion $_version);
    return $version
}

function drpbx-builds {
	param( [string]$default = '27.3.21', [string]$hrefs, [string]$testVersion )
    $links = $hrefs -split ( '\/' ); $build = @(); $regex = ($re_build);
    foreach($_ in $links) {
        foreach($G in $_) {
            if ($G -match '([\d]{2}[\-]{1}[\d]{1,2}[\-]{1}[\d]{2})') {
                $G = $G -replace($regex,$re_non) -replace($re_dash,$re_dot) -replace('New.',$re_non);
					if (($G -ge $default) -and ($G -ge $testVersion)) { $build += $G + ";"; }
					}
			if (($build | measure).Count -ge '6') { $build = ($build | measure -Maximum).Maximum; break; }
            }
        }
	
	return ($build -split(";") | select -First 1)
}
