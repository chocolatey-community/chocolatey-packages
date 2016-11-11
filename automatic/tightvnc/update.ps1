import-module au

$download_page_url = 'http://www.tightvnc.com/download.php'

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]url32\s*=\s*)('.*')"      = "`$1'$($Latest.URL32)'"
            "(^[$]url64\s*=\s*)('.*')"      = "`$1'$($Latest.URL64)'"
            "(^[$]checksum32\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksum64\s*=\s*)('.*')" = "`$1'$($Latest.Checksum64)'"
        }
    }
}

function global:au_GetLatest {
    $page = Invoke-WebRequest $download_page_url
	$html = $page.parsedHTML

    $download_link = $html.body.getElementsByTagName("a") | where {$_.href -like "http://www.tightvnc.com/download/*.msi"}

    $version = $download_link[0].href.Replace("http://www.tightvnc.com/download/","").Split("/")[0]

    $url64 = $download_link | where {$_.href -like "http://www.tightvnc.com/download/$version*64bit.msi"} 
    $url32 = $download_link | where {$_.href -like "http://www.tightvnc.com/download/$version*32bit.msi"} 
    
    return @{ URL64 = $url64.href; URL32 = $url32.href; Version = $version }
}

update