# Chocolatey MSYS2
#
# Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
#
# Licensed under the Apache License, Version 2.0

$ErrorActionPreference = 'Stop';

$packageName = 'msys2'

$msysVersion = '20160719'

$msys32DistName = "msys2-base-i686-$msysVersion"
$msys64DistName = "msys2-base-x86_64-$msysVersion"

$url = "http://repo.msys2.org/distrib/i686/$msys32DistName.tar.xz"
$checksum = '2F222FA6409D2C14B97DC5197757BE387D6D12E3'
$checksumType = 'SHA1'

$url64 = "http://repo.msys2.org/distrib/x86_64/$msys64DistName.tar.xz"
$checksum64 = '4FF1090B143DEAEDED088146E04503B9A3C15FDB'
$checksumType64 = 'SHA1'

$toolsDir = Split-Path -parent $MyInvocation.MyCommand.Definition

$packageDir = Split-Path -parent $toolsDir
Write-Host "Adding '$packageDir' to PATH..."
Install-ChocolateyPath $packageDir

$osBitness = Get-ProcessorBits
if ($osBitness -eq 32) {
    $msysDistName = $msys32DistName
}
else {
    $msysDistName = $msys64DistName
}

$binRoot = Get-ToolsLocation
# MSYS2 zips contain a root dir named msys32 or msys64
$msysName = 'msys' + $osBitness
$msysRoot = Join-Path $binRoot $msysName

if (Test-Path $msysRoot) {
    Write-Host "'$msysRoot' already exists and will only be updated."
}
else {
    Write-Host "Installing to '$msysRoot'"
    Install-ChocolateyZipPackage $packageName $url $binRoot $url64 `
      -checksum $checksum -checksumType $checksumType `
      -checksum64 $checksum64 -checksumType64 $checksumType64

    # check if .tar.xz was only unzipped to tar file
    # (shall work better with newer choco versions)
    $tarFile = Join-Path $binRoot "$msysDistName.tar"
    if (Test-Path $tarFile) {
        Get-ChocolateyUnzip $tarFile $binRoot
        Remove-Item $tarFile
        if (-not (Test-Path $msysRoot)) {
            throw "No '$msysRoot' found after extracting."
        }
    }
    else {
        if (-not (Test-Path $msysRoot)) {
            throw "No '$tarFile' or '$msysRoot' found after unzipping."
        }
    }
}

Write-Host "Adding '$msysRoot' to PATH..."
Install-ChocolateyPath $msysRoot

# Finally initialize and upgrade MSYS2 according to https://msys2.github.io
# and https://sourceforge.net/p/msys2/wiki/MSYS2%20installation/
Write-Host "Initializing MSYS2..."

$msysExe = Join-Path $msysRoot msys2.exe
if (-not (Test-Path $msysExe)) {
    throw @"
No '$msysExe' found.
You probably have an outdated MSYS2 installation in '$msysRoot'.
Please delete '$msysRoot' and reinstall.
"@
}

Write-Host "Starting '$msysExe'..."
Start-Process -Wait $msysExe -ArgumentList '-c', exit

$command = 'pacman --noconfirm -Syuu'
Write-Host "Upgrading core system packages with '$command'..."
Start-Process -Wait $msysExe -ArgumentList '-c', "'$command'"

Write-Host "Upgrading full system with '$command'..."
Start-Process -Wait $msysExe -ArgumentList '-c', "'$command'"
