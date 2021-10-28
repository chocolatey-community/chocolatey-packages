

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

function Get-ResultInformation() {
param(
	[string]$url32,
	[string]$file,
	[string]$algorithm = 'sha512',
	[switch]$info
)

  $dest = "$env:TEMP\$file"
  Invoke-WebRequest -UseBasicParsing -Uri $url32 -OutFile $dest
  $version = Get-Item $dest | Foreach { $_.VersionInfo.ProductVersion -replace '^(\d+(\.[\d]+){1,3}).*', '$1' }

  Remove-Item -Force $dest
  if ($info){
    return $version
  } else {
    $result = @{
    URL32          = $url32
    Version        = $version
    Checksum32     = (Get-FileHash $dest -Algorithm $algorithm | Foreach Hash)
    ChecksumType32 = $algorithm
    }
    return $result
  }
}

function Get-JavaSiteUpdates {
# $wait number can be adjusted per the package needs
param(
	[string]$package,
	[string]$Title,
	[string]$padVersionUnder = '10.2.1',
	[string]$wait = 4
 )

$url = Get-PackageName $package
$ie = New-Object -comobject InternetExplorer.Application
$ie.Navigate2($url) 
$ie.Visible = $false
while($ie.ReadyState -ne $wait) {
 start-sleep -Seconds 20
}
# Server detection not needed anymore currently 10/27/2021
$url = $ie.Document.getElementsByTagName("a") | % { $_.href } | select -First 2 | Select -Last 1

# New Version from Get-ResultInformation due to downloading file
$version = ((Get-ResultInformation $url -file "${package}.exe" -info) -replace(",","."))

$ie.quit()

	@{    
		PackageName = $package
		Title       = $Title
		fileType    = 'exe'
		Version		= Get-FixVersion $version -OnlyFixBelowVersion $padVersionUnder
		URL32		= $url
    }

}
