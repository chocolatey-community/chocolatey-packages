
import-module au

 $releases = "http://get.adobe.com/en/flashplayer/" # URL to for GetLatest

function global:au_SearchReplace {
   @{
        ".\tools\chocolateyInstall.ps1" = @{
            "(^[$]version\s*=\s*)('.*')"= "`$1'$($Latest.Version)'"
            "(^[$]majorVersion\s*=\s*)('.*')"= "`$1'$($Latest.majorVersion)'"
            "(^[$]packageName\s*=\s*)('.*')"= "`$1'$($Latest.PackageName)'"
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
            "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
        }
    }
}

function global:au_GetLatest {
		
	$HTML = Invoke-WebRequest -Uri $releases
	$try = ($HTML.ParsedHtml.getElementsByTagName('p') | Where{ $_.className -eq 'NoBottomMargin' } ).innerText
	$try = $try  -split "\r?\n"
	$try = $try[0] -replace ' ', ' = '
	$try =  ConvertFrom-StringData -StringData $try
	$CurrentVersion = ( $try.Version )	
	$majorVersion = ([version] $CurrentVersion).Major

    $url32 = 'https://download.macromedia.com/get/flashplayer/current/licensing/win/install_flash_player_<majorVersion>_active_x.msi'
	
    $url32 = $url32 -replace '<majorVersion>', $majorVersion

	return @{ URL32 = $url32; Version = $CurrentVersion; majorVersion = $majorVersion; }
}

update
