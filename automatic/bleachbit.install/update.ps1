import-module au

$releases = 'https://www.bleachbit.org/download/windows'
$betas = 'https://download.bleachbit.org/beta/'

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $filename = ($download_page.links | ? href -match '.exe$' | select -First 1 -expand href).Replace('/download/file/t?file=','')
    $version = $filename -split '-' | select -First 1 -Skip 1

    $page_betas    = Invoke-WebRequest -Uri $betas -UseBasicParsing
    $path_beta     = $betas + ($page_betas.links | select -Last 1 -expand href)
    $page_beta     = Invoke-WebRequest -Uri $path_beta -UseBasicParsing
    $filename_beta = $page_beta.links | ? href -match 'setup.exe$' | select -First 1 -expand href
    $version_beta  = $filename_beta -split '-' | select -First 1 -Skip 1

    if ([version]$version_beta -gt [version]$version) {
        @{
            Version = $version_beta + '-beta'
            URL32   = $path_beta + $filename_beta
        }
    } else {
        @{
            Version = $version
            URL32   = 'https://download.bleachbit.org/' + $filename
        }
    }
}

function global:au_BeforeUpdate { Get-RemoteFiles -Purge -NoSuffix }

function global:au_SearchReplace {
   @{
    ".\tools\chocolateyInstall.ps1" = @{
        "(?i)(^\s*file\s*=\s*`"[$]toolsDir\\).*" = "`${1}$($Latest.FileName32)`""
        }
    ".\legal\VERIFICATION.txt" = @{
        "(?i)(x86:).*"        = "`${1} $($Latest.URL32)"
        "(?i)(checksum32:).*" = "`${1} $($Latest.Checksum32)"
        "(?i)(type:).*"       = "`${1} $($Latest.ChecksumType32)"
        }
    }
}

update -ChecksumFor none
