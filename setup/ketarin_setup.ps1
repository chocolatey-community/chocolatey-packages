# If you change this value, also change it in the global settings
# The name will also be saveDir
$saveDir = "c:\chocolatey-auto-save"

Write-Host "Ensuring that the Ketarin auto save folder is set appropriately."
if (!(Test-Path($saveDir))) {
  mkdir $saveDir
}

choco upgrade chocolateypackageupdater -y
choco upgrade ketarin -y
