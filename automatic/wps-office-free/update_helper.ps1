

function Get-PackageName() {
param(
    [string]$a
)

switch -w ( $a ) {

	'wps-office-free' {
		$PackageUrl = "https://pc.wps.com/"
	}
	
}

return $PackageUrl

}

function Get-JavaSiteUpdates {
# $wait number can be adjusted per the package needs
 param(
	[string]$package,
  [string]$Title,
  [string]$padVersionUnder = '10.2.1',
  [string]$wait = 4
 )
 
$OS_caption = ( Get-CimInstance win32_operatingsystem -Property Caption )
$check = @{$true=$true;$false=$false}[ ( $OS_caption -match 'Server' ) ]
$regex = '([\d]{0,2}[\.][\d]{0,2}[\.][\d]{0,2}[\.][\d]{0,5})'
$url = Get-PackageName $package
$ie = New-Object -comobject InternetExplorer.Application
$ie.Navigate2($url) 
$ie.Visible = $false
while($ie.ReadyState -ne $wait) {
 start-sleep -Seconds 20
}
	if ( $check ) {
		$url32 = $ie.Document.IHTMLDocument3_getElementsByTagName("a") | % { $_.href } | where { $_ -match $regex } | select -First 1
	} else {
		$url32 = $ie.Document.getElementsByTagName("a") | % { $_.href } | where { $_ -match $regex } | select -First 1
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
