import-module au

$url = 'http://www.cutepdf.com/download/CuteWriter.exe'

function global:au_SearchReplace {
    @{
        'tools\ChocolateyInstall.ps1' = @{
            "(^[$]checksum\s*=\s*)('.*')"   = "`$1'$($Latest.Checksum32)'"
        }
     }
}

function global:au_GetLatest {
    Write-Host $url

    $temp_file = $env:TEMP + '\CuteWriter.exe'
    Invoke-WebRequest $url -OutFile $temp_file

    $version = (Get-Command $temp_file).Version

    return @{ URL = $url; Version = $version }
}

update -NoCheckUrl -ChecksumFor 32