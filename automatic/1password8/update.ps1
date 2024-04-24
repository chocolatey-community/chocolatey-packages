import-module au

$releases    = 'https://app-updates.agilebits.com/product_history/OPW8'
$release_notes_base = 'https://releases.1password.com/windows/'

function global:au_SearchReplace {
    @{
      ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*url\s*=\s*)('.*')"        = "`$1'$($Latest.URL64)'"
        "(?i)(^\s*checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum64)'"
        "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        "(?i)^(\s*silentArgs\s*=\s*)['`"].*['`"]" = "`${1}`"$($Latest.SilentArgs)`""
      }
      ".\1password8.nuspec" = @{
        "\<releaseNotes\>.+" = "<releaseNotes>$($Latest.ReleaseNotes)</releaseNotes>"
      }
    }
}

function global:au_BeforeUpdate { }
function global:au_AfterUpdate  { }

function global:au_GetLatest {
    $download_page = Invoke-RestMethod -Uri $releases

    #(?s) --> This allws the dot "." to capture multiline (\r\n)
    #<article\s[^>]+> --> Look for <article with id and such
    #[^<]*<h3> --> look for <h3>
    #[^\d]*([\d\.]+)(?=[^\-]+<) --> look for version number that does not incude -<number.NIGHTLY (including the positive lookahead where no - all the way to <)... Captures the version number
    #.*?<a href="(https[^"]+) --> lazy dotall until reach link with the download package. Captures the download link
    #.*?</article> --> lazy dotall until end of </article>
    $regex_str='(?s)<article\s[^>]+>[^<]*<h3>[^\d]*([\d\.]+)(?=[^\-]+<).*?<a href="(https[^"]+).*?</article>'

    if ($download_page -match $regex_str)
    {
        #$Matches[0] --> Full article
        #$Matches[1] --> Version
        #$Matches[2] --> URL
        $version_1password8=$Matches[1]
        $exe_url=$Matches[2]
        $msi_url=$exe_url.replace(".exe",".msi")

        $major_version_regex='\d+\.\d+'
        
        #default is base windows release ntoes in case we can't get the major version
        $releaseNotes=$release_notes_base
        if($version_1password8 -match $major_version_regex)
        {
            $major_version=$Matches[0]
            $releaseNotes="$release_notes_base$major_version/"
        }
        

        return @{
            URL64        = $msi_url
            Version      = $version_1password8
            ReleaseNotes = "$releaseNotes"
            SilentArgs   = "/qn"
        }
    }
    else {
        throw "Did not get a match on the REGEX, investigate update"
    }
}

update -ChecksumFor 64 -NoReadme
