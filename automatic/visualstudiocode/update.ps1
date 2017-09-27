import-module au
import-module "$PSScriptRoot\..\..\extensions\chocolatey-core.extension\extensions\chocolatey-core.psm1"

$releases32 = 'https://vscode-update.azurewebsites.net/api/update/win32/stable/VERSION'
$releases64 = 'https://vscode-update.azurewebsites.net/api/update/win32-x64/stable/VERSION'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')" = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*url\s*=\s*)('.*')"         = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*url64bit\s*=\s*)('.*')"    = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"    = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*checksum64\s*=\s*)('.*')"  = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
    $json32 = Invoke-WebRequest -UseBasicParsing -Uri $releases32 | ConvertFrom-Json
    $json64 = Invoke-WebRequest -UseBasicParsing -Uri $releases64 | ConvertFrom-Json

    if ($json32.productVersion -ne $json64.productVersion) {
        throw "Different versions for 32-Bit and 64-Bit detected."
    }

    @{
        Version   = $json32.productVersion
        URL32     = $json32.Url
        URL64     = $json64.Url
    }
}

update
