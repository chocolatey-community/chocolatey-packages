
function drpbx-compare {
  param(
    [Parameter(Position = 0)]
    [string]
    $_version,
    [string]$build
  )

  if ([string]::IsNullOrEmpty($build)) {
    $build = 'stable'
  }

  $releases = 'https://www.dropboxforum.com/t5/Desktop-client-builds/bd-p/101003016'
  $HTML = Invoke-WebRequest -UseBasicParsing -Uri $releases | % Links | where { $_ -match $build } | select -First 6 | Out-String
  $re_dash = '-'
  $re_dot = '.'
  $re_non = ''
  $re_build = $build + "build"
  $version = drpbx-builds -hrefs $HTML -testVersion $_version

  return $version
}

function drpbx-builds {
  param(
    [string]$default = '27.3.21',
    [string]$hrefs,
    [string]$testVersion
  )

  $links = $hrefs -split ( '\/' )
  $build = @()
  $regex = ($re_build)
  $Maj = ($vers.Major.ToString()).length
  $Min = ($vers.Minor.ToString()).length
  $Bui = ($vers.build.ToString()).length
  foreach ($_ in $links) {
    foreach ($G in $_) {
      if ($G -match "([\d]{$Maj}[\-]{1}[\d]{$Min}[\-]{1}[\d]{$Bui})") {
        $G = $G -replace ($regex, $re_non) -replace ($re_dash, $re_dot) -replace ('New.', $re_non)
        if (($G -ge $default) -and ($G -ge $testVersion)) {
          $build += $G + ";"
        }
      }
      if (($build | measure).Count -ge '6') {
        $build = ($build | measure -Maximum).Maximum
        break
      }
    }
  }
  return ($build | select -First 1)
}
