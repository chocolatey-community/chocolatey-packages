$packageName   = 'autohotkey.portable'
$checksumType  = 'MD5'
$url           = '{{DownloadUrl}}'
$checksum      = '521c8acba859da18167d1dcca5decad2'
$unzipLocation = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$url64         = '{{DownloadUrlx64}}'
$checksum64    = 'a9435c1353c83f82afacd94454143ffa'

Install-ChocolateyZipPackage `
    -PackageName $packageName `
    -Url $url `
    -UnzipLocation $unzipLocation `
    -Url64bit $url64 `
    -Checksum $checksum `
    -ChecksumType $checksumType `
    -Checksum64 $checksum64 `
    -ChecksumType64 $checksumType
