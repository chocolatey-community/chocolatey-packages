Import-Module Chocolatey-AU

$releases = 'https://pypi.org/rss/project/mkdocs-material/releases.xml'

function global:au_SearchReplace {
  @{
    'tools\ChocolateyInstall.ps1' = @{
      "(^[$]version\s*=\s*)('.*')" = "`$1'$($Latest.Version)'"
    }
        ".\mkdocs-material.nuspec" = @{
          "(\<dependency .+?`"mkdocs`" version=)`"([^`"]*)`"" = "`$1`"$($Latest.MkDocsDep)`""
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-RestMethod -UseBasicParsing -Uri $releases -Method Get

    $version = $download_page | Select-Object -First 1 -ExpandProperty title

    $download_page = Invoke-WebRequest -UseBasicParsing -Uri "https://github.com/squidfunk/mkdocs-material/raw/${version}/requirements.txt"
    if ($download_page.content -match "mkdocs>=(\d+\.[\d\.]+)") {
        $dependencyVersion = $matches[1]
    } elseif ($download_page.content -match "mkdocs~=(\d+\.[\d\.]+)") {
        # Case for compatible version syntax.
        $minimumVersion = $matches[1]
        [int]$majorVersion = $minimumVersion -split "\." | Select-Object -First 1
        $minimumVersionParts = ($minimumVersion -split "\.").count
        if ($minimumVersionParts -eq 2) {
            $nextMajorVersion = $majorVersion + 1
            $dependencyVersion = "[$minimumVersion,$nextMajorVersion.0.0)"
        } elseif ($minimumVersionParts -eq 3) {
            [int]$minorVersion = $minimumVersion -split "\." | Select-Object -First 1 -Skip 1
            $nextMinorVersion = $minorVersion + 1
            $dependencyVersion = "[$minimumVersion,$majorVersion.$nextMinorVersion.0)"
        } else {
            throw "Invalid number of minimum version parts '$minimumVersionParts'"
        }
    } else {
        throw "Mkdocs dependency version was not found"
    }

    return @{ Version = $version; MkDocsDep = $dependencyVersion }
}


update -ChecksumFor none
