$ErrorActionPreference = 'Stop'
import-module au

$download_page_url = 'https://www.sourcetreeapp.com/download-archives'
$url_part1 = 'https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_'
$url_part2 = '.msi'
$release_notes_part1 = 'https://product-downloads.atlassian.com/software/sourcetree/windows/ga/ReleaseNotes_'
$release_notes_part2 = '.html'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
            "(^[$]url\s*=\s*)('.*')"   = "`$1'$($Latest.Url)'"
        }
		'sourcetree.nuspec' = @{
            "(\<releaseNotes\>).*?(\</releaseNotes\>)" = "`${1}$($Latest.ReleaseNotes)`$2"
        }
     }
}

function global:au_GetLatest {
    $homepage_content = Invoke-WebRequest -UseBasicParsing -Uri $download_page_url

     # Get Version
    $homepage_content -match 'https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_\d+\.\d+\.\d+'| Out-Null
	$version = $matches[0] -replace "https://product-downloads.atlassian.com/software/sourcetree/windows/ga/SourcetreeEnterpriseSetup_", ""
    $url = $url_part1 + $version + $url_part2
	$release_notes = $release_notes_part1 + $version + $release_notes_part2
    

    $Latest = @{ URL = $url; Version = $version; ReleaseNotes = $release_notes }
    return $Latest
}

update
