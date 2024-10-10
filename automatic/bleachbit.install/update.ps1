Import-Module Chocolatey-AU

$releases = 'https://www.bleachbit.org/download/windows'

function global:au_GetLatest {
  $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
  $filename = ($download_page.links | Where-Object href -Match '.exe$' |
    Where-Object href -NotMatch 'fosshub' |
    Select-Object -First 1 -expand href) -Replace '.*file=', ''

  if (!$filename) {
    # Most likely we only got a fosshub url in this case,
    # as such we just do an ignore
    return 'ignore'
  }

  $version = $filename -split '-' | Select-Object -First 1 -Skip 1

  # figure out if this is a beta release or a normal release.
  $BetasPage = Invoke-WebRequest -UseBasicParsing 'https://download.bleachbit.org/beta/'
  $IsBeta = $BetasPage.links | Where-Object { $_.innertext -eq "$version/" }

  if ($IsBeta) {
    $filename = "beta/$version/$filename"
    $version = $version + '-beta'
  }

  @{
    Version = $version
    URL32   = "https://download.bleachbit.org/$filename"
  }
}

function global:au_SearchReplace {
  $replacements = @{
    '.\legal\VERIFICATION.txt' = @{
      '(?i)(x86:).*'        = "`${1} $($Latest.URL32)"
      '(?i)(checksum32:).*' = "`${1} $($Latest.Checksum32)"
      '(?i)(type:).*'       = "`${1} $($Latest.ChecksumType32)"
    }
  }

  if ($MyInvocation.InvocationName -ne '.') {
    $replacements['.\tools\chocolateyInstall.ps1'] = @{
      "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
    }
  }

  $replacements
}

# A few things should only be done if the script is run directly (i.e. not "dot sourced")
#   (It is dot sourced in the meta-package.)
if ($MyInvocation.InvocationName -ne '.') {
  function global:au_BeforeUpdate() {
    Write-Host "Downloading BleachBit $($Latest.Version)"
    Get-RemoteFiles -Purge -NoSuffix
  }

  update -ChecksumFor none
  if ($global:au_old_force -is [bool]) { $global:au_force = $global:au_old_force }
}
