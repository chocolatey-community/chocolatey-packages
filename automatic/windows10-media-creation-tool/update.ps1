
import-module au

function global:au_SearchReplace {
  @{
    ".\tools\chocolateyInstall.ps1" = @{
      "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
      "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
      "(^[$]checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType32)'"
    }
  }
}

function global:au_BeforeUpdate {
	Remove-Item ".\tools\*.exe" -Force # Removal of downloaded files
}

function Get-FileVersion {
param(
    [string]$url,
    [string]$file
)
    $packageName = $($Latest.PackageName)
    if (!(Test-Path "${env:temp}\chocolatey\$packageName" -PathType Container)) {
    New-Item -ItemType Directory "${env:temp}\chocolatey\$packageName" }
    Invoke-WebRequest -Uri $url -OutFile "${env:temp}\chocolatey\$packageName\$file"
    $filer = Get-Item "${env:temp}\chocolatey\$packageName\*.exe" | select -First 1
	$version = $filer.VersionInfo.FileVersion -replace '((\d+.\d+.\d+.\d+))*','$1'
    if (( $version -match " " )) { $like=$true;$version = $version -split(" ") }
    $version = @{$true=$version;$false=$version[0]}[ $version -isnot [system.array] ]
    return $version
}

function global:au_GetLatest {

$url = 'http://go.microsoft.com/fwlink/?LinkId=691209'
$fileName = "MediaCreationTool.exe"


	@{
		fileType	= 'exe'
		URL32		= $url
		Version		= (Get-FileVersion -url $url -file $fileName)
    }
}
update
