import-module au

$releases = 'https://musescore.org/'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"     = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*softwareName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)*'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }

        "$($Latest.PackageName).nuspec" = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $regex = '(?:MuseScore \d+(\.\d+){1,4})'
    foreach ( $_ in $download_page.links) {
    if ( $_.href -match 'download' ) {
    if ( $_.outerhtml -match $regex ) {
    $version = $Matches[0] -replace( 'musescore ', '' )
    } } }
    @{
        URL32        = "http://ftp.osuosl.org/pub/musescore/releases/MuseScore-${version}/MuseScore-${version}.msi"
        Version      = $version
        ReleaseNotes = "http://musescore.org/en/developers-handbook/release-notes/release-notes-musescore-${version}"
    }
}

update -ChecksumFor 32
