import-module au

$releases = 'https://github.com/aws/aws-cli/releases'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyinstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}


function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    
    $regex = 'zip$'
    $zip_url = $download_page.links | ? href -match $regex | select -First 1 -expand href
        
    $version = $zip_url -split '/|\.zip' | select -Last 1 -Skip 1
    
    $url64 = "https://s3.amazonaws.com/aws-cli/AWSCLI64PY3-$version.msi"
    $url32 = $url64 -replace '64P', '32P'
    
    return @{ URL32 = $url32; URL64 = $url64; Version = $version }
}

update
