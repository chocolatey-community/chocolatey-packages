import-module au

$releases = 'http://filehippo.com/download_audacity'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^\s*packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
        }

        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.BaseURL)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
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
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $url = $download_page.Content -split "`n" | sls 'href=".+download_audacity/download/[^"]+'
    $url = $url -split '"' | select -Index 1
    $version = $download_page.Content -split "`n" | sls 'class="title-text"'
    $version = $version -split '"' | select -Last 1 -Skip 1

    $download_page = Invoke-WebRequest $url -UseBasicParsing
    $url32 = $download_page.Content -split "`n" | sls 'id="download-link"'
    $url32 = $url32 -split '"' | select -Index 1
    @{
        URL32    = 'http://filehippo.com' + $url32
        BaseUrl  = $url
        Version  = $version -split ' ' | select -Last 1
        FileType = 'exe'
    }
}
update -ChecksumFor none
