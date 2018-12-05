

function Get-PackageName() {
param(
    [string]$a
)

$PreURL = 'https://usa.kaspersky.com/downloads/thank-you'
switch -w ( $a ) {

	'wps-office-free' {
		$PackageUrl = "https://www.wps.com/en-US/office/windows/"
	}
	
}

return $PackageUrl

}

function Get-JavaSiteUpdates {
 param(
	[string]$package,
    [string]$Title,
    [string]$padVersionUnder = '10.2.1'
 )
 
$regex = '([\d]{0,2}[\.][\d]{0,2}[\.][\d]{0,2}[\.][\d]{0,5})'
$rev_regex = '([\d+]{5})';
$url = Get-PackageName $package
if ( $url -match 'free' ) { $wait = 3 } else { $wait = 4 }
$ie = New-Object -comobject InternetExplorer.Application
$ie.Navigate2($url) 
$ie.Visible = $false
while($ie.ReadyState -ne $wait) {
 start-sleep -Seconds 20
} 
    foreach ( $_ in $ie.Document.getElementsByTagName("a") ) {
     $url = $_.href;
         if ( $url -match $regex) {
            $yes = $url | select -last 1
            $version = $Matches[0]
            $the_match = $yes -match( $rev_regex );
            $revision = $Matches[0];
            break;
        }
    }
$ie.quit()
if ($package -match 'wps') {
$version = $version
} else {
$version = $version + $revision
}


	@{    
		PackageName = $package
		Title       = $Title
		fileType    = 'exe'
		Version		= Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder
		URL32		= $yes
    }

}
