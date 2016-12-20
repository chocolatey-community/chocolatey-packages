$language = (Get-Culture).Parent.Name

$packageArgs = @{
  packageName = 'becyicongrabber'
  checksumType= 'sha256'
  unzipLocation = (Split-Path -parent $MyInvocation.MyCommand.Definition)
}
if ($language -eq 'de') {
  $packageArgs.url = 'http://www.becyhome.de/download/BeCyIGrab230Ger.zip' #urlDE
  $packageArgs.checksum = '8D17C66B918F3A9F58A7B28D50095CCD1E87B54E9FB9E2F5A12F4A169D38ED47' #checksumDe
} else {
  $packageArgs.url = 'http://www.becyhome.de/download/BeCyIGrab230Eng.zip' #urlEN
  $packageArgs.checksum = '6604FC8C2E99CA7DCB2F19E91B292A362F1BE1957D73B4210CA29C4AE0105ED2' #checksumEN
}

Install-ChocolateyZipPackage @packageArgs
