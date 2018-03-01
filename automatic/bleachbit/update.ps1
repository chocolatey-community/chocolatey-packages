import-module au

$releases = 'https://www.bleachbit.org/download/windows'
$betas = 'https://download.bleachbit.org/beta/'

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $filename = ($download_page.links | ? href -match '.exe$' | select -First 1 -expand href).Replace('/download/file/t?file=', '')
  $version = $filename -split '-' | select -First 1 -Skip 1

  try {
    # try figuring out if this is a beta release or a normal release.
    $test_page = (iwr -UseBasicParsing "https://bleachbit.org/news/bleachbit-$($version -replace '\.','')" -Method Head)
  }
  catch {}

  if (!$test_page) {
    # Until beta links works again we ignore beta releases
    $beta_page = iwr -UseBasicParsing "https://bleachbit.org/news/bleachbit-$($version -replace '\.','')-beta" -Method Head
  }

  if ($beta_page) {
    $filename = "beta/$version/$filename"
    $version = $version + "-beta"
  }

  @{
    Version = $version
    URL32   = 'https://download.bleachbit.org/' + $filename
  }
}

function global:au_SearchReplace {
  @{
    "$($Latest.PackageName).nuspec" = @{
      "(\<dependency .+?`"$($Latest.PackageName).install`" version=)`"([^`"]+)`"" = "`$1`"[$($Latest.Version)]`""
    }
  }
}

if ($MyInvocation.InvocationName -ne '.') {
  update -ChecksumFor none
}
