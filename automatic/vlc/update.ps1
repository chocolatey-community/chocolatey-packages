import-module au
$releases = 'https://www.videolan.org/vlc/download-windows.html'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
        }

        ".\tools\VERIFICATION.txt" = @{
          "(?i)(\s+x32:).*"            = "`${1} $($Latest.URL32)"
          "(?i)(\s+x64:).*"            = "`${1} $($Latest.URL64)"
          "(?i)(checksum32:).*"        = "`${1} $($Latest.Checksum32)"
          "(?i)(checksum64:).*"        = "`${1} $($Latest.Checksum64)"
          "(?i)(Get-RemoteChecksum).*" = "`${1} $($Latest.URL64)"
        }
    }
}

function global:au_BeforeUpdate {
    function Convert-ToEmbeded( [switch] $Purge, [string]$FileNameBase, [int]$FileNameSkip=0 ) {

        function name4url($url) {
            if ($FileNameBase) { return $FileNameBase }
            $res = $url -split '/' | select -Last 1 -Skip $FileNameSkip
            $res -replace '\.[a-zA-Z]+$'
        }

        function ext() {
            if ($Latest.FileType) { return $Latest.FileType }
            $url = $Latest.Url32; if (!$url) { $url = $Latest.Url64 }
            if ($url -match '(?<=\.)[^.]+$') { return $Matches[0] }

        }

        $ext = ext
        if (!$ext) { throw 'Unknown file type' }

        if ($Purge) {
            Write-Host 'Purging' $ext
            rm -Force "$PSScriptRoot\tools\*.$ext"
        }

        try {
            $client = New-Object System.Net.WebClient

            if ($Latest.Url32) {
                $base_name = name4url $Latest.Url32
                $file_name = "{0}_x32.{1}" -f $base_name, $ext
                $file_path = "$PSScriptRoot\tools\$file_name"

                Write-Host "Downloading to $file_name -" $Latest.Url32
                $client.DownloadFile($Latest.URL32, $file_path)
                $Latest.Checksum32 = Get-FileHash $file_path | % Hash
            }

            if ($Latest.Url64) {
                $base_name = name4url $Latest.Url64
                $file_name = "{0}_x64.{1}" -f $base_name, $ext
                $file_path = "$PSScriptRoot\tools\$file_name"

                Write-Host "Downloading to $file_name -" $Latest.Url64
                $client.DownloadFile($Latest.URL64, $file_path)
                $Latest.Checksum64 = Get-FileHash $file_path | % Hash
            }
        } finally { $client.Dispose() }
    }

    Convert-ToEmbeded -Purge
}

function global:au_GetLatest {
    [System.Net.ServicePointManager]::SecurityProtocol = 'Ssl3,Tls,Tls11,Tls12' #https://github.com/chocolatey/chocolatey-coreteampackages/issues/366
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing

    $re    = '\.exe$'
    $url   = $download_page.links | ? href -match $re | % href
    $version  = $url[0] -split '-' | select -Last 1 -Skip 1
    @{
        Version      = $version
        URL32        = 'http:' + ( $url -match 'win32' | select -first 1 )
        URL64        = 'http:' + ( $url -match 'win64' | select -first 1 )
    }
}

update -ChecksumFor none
