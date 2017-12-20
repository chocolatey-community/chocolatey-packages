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

function global:au_GetLatest {

	$fileName = "MediaCreationTool.exe"
	$url = 'http://go.microsoft.com/fwlink/?LinkId=691209'
	Invoke-WebRequest -Uri $url -OutFile ".\tools\$fileName"
	$regex = "((\d+.\d+.\d+.\d+))"
	$filer = Get-Item ".\tools\*.exe"
	$version = $filer.VersionInfo.FileVersion -replace '$regex*','$1'
	$version = $version -match $regex;
	$version = $Matches[0]

	@{
		fileType	= 'exe'
		URL32		= $url
		Version		= $version
    }
}
update -ChecksumFor 32
