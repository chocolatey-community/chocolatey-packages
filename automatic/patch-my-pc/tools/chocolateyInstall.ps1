$name = 'Patch my PC'
$id = 'patch-my-pc'
$url = 'http://patchmypc.net/PatchMyPC.exe'
$pwd = "$(split-path -parent $MyInvocation.MyCommand.Definition)"

# Combatibility - This function has not been merged
if (!(Get-Command Install-ChocolateyPinnedItem -errorAction SilentlyContinue)) {
	Import-Module "$($pwd)\Install-ChocolateyPinnedItem.ps1"
}

$installDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "$id"

# Calculate $binRoot, which should always be set in $env:ChocolateyBinRoot as a full path (not relative)
$binRoot = Get-BinRoot;

Write-Output "Downloading to: $nugetExePath";
$tempFile = Join-Path $nugetExePath "PatchMyPC.exe"

Get-ChocolateyWebFile $id "$tempFile" "$url"

# Copy shortcut to start menu
Install-ChocolateyPinnedItem $tempFile
