import-module au
import-module "$PSScriptRoot/../../extensions/chocolatey-core.extension/extensions/chocolatey-core.psm1"

$releases = 'https://vscode-update.azurewebsites.net/api/update/win32/stable/VERSION'

function global:au_SearchReplace {
    @{
        'tools\chocolateyInstall.ps1' = @{
            "(^[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
     }
}

function global:au_GetLatest {
    $json = Invoke-WebRequest -UseBasicParsing -Uri $releases | ConvertFrom-Json

    @{
        Version   = $json.productVersion
        URL32     = $json.Url
        URL64     = $json.Url
    }
}

update