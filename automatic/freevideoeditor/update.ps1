import-module au

$releases = 'http://www.videosoftdev.com/free-video-editor/download'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL32)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum32)'"
            "(?i)(^\s*packageName\s*=\s*)('.*')"  = "`$1'$($Latest.PackageName)'"
            "(?i)(^\s*fileType\s*=\s*)('.*')"     = "`$1'$($Latest.FileType)'"
        }
    }
}

function global:au_GetLatest {
    $download_page = Invoke-WebRequest -Uri $releases -UseBasicParsing
    $version = $download_page.Content -split '\n' | sls 'Current version:' -Context 0,5 | out-string
    @{
        Version = $version -split '<|>' | ? { [version]::TryParse($_, [ref]($__)) } | select -First 1
        URL32   = 'http://downloads.videosoftdev.com/video_tools/video_editor.exe'
    }
}

update
