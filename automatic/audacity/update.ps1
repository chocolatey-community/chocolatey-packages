import-module au

$releases = 'http://filehippo.com/download_audacity'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
        }

        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL32)"
        }

    }
}

function global:au_BeforeUpdate {
    function Convert-ToEmbeded( [switch] $Purge, [string]$FileNameBase, [int]$FileNameSkip=0 ) {

        if (!$FileNameBase) {
            $url = $Latest.URL32; if (!$url) { $url = $Latest.Url64 }
            $FileNameBase = $url -split '/' | select -Last 1 -Skip $FileNameSkip
            if ($FileNameBase -match '\.[a-zA-Z]+$') {
                $ext = $Matches[0]
                $FileNameBase = $FileNameBase.Replace($ext, '')
            }
        }

        $FileType = $Latest.FileType
        if (!$FileType) { $FileType = $ext }
        if (!$FileType) { throw 'Unknown file type' }

        if ($Purge) {
            Write-Host 'Purging' $FileType
            rm -Force "$PSScriptRoot\tools\*$FileType"
        }

        try {
            $client = New-Object System.Net.WebClient

            if ($Latest.Url32) {
                $file_name = "{0}_x32.{1}" -f $FileNameBase, $FileType
                $file_path = "$PSScriptRoot\tools\$file_name"

                Write-Host "Downloading to $file_name -" $Latest.Url32
                $client.DownloadFile($Latest.URL32, $file_path)
                $Latest.Checksum32 = Get-FileHash $file_path | % Hash
            }

            if ($Latest.Url64) {
                $file_name = "{0}_x64.{1}" -f $FileNameBase, $FileType
                $file_path = "$PSScriptRoot\tools\$file_name"

                Write-Host "Downloading to $file_name -" $Latest.Url64
                $client.DownloadFile($Latest.URL32, $file_path)
                $Latest.Checksum64 = Get-FileHash $file_path | % Hash
            }
        } finally { $client.Dispose() }
    }

    Convert-ToEmbeded -Purge -FileNameBase $Latest.PackageName
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases
    $url     = $download_page.links | ? href -match 'download_audacity/download' | % href | select -first 1
    $version = $download_page.AllElements | ? class -eq 'title-text' | % title

    $download_page = Invoke-WebRequest $url
    $url = $download_page.links | ? id -eq 'download-link' | % href
    @{
        URL32    = 'http://filehippo.com' + $url
        Version  = $version -split ' ' | select -Last 1
        FileType = 'exe'
    }
}
update -ChecksumFor none
