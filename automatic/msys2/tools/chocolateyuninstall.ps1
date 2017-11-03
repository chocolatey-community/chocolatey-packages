# Chocolatey MSYS2
#
# Copyright (C) 2015 Stefan Zimmermann <zimmermann.code@gmail.com>
#
# Licensed under the Apache License, Version 2.0

$ErrorActionPreference = 'Stop';

$packageName = 'msys2'

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageDir = Split-Path -Parent $toolsDir
if (Get-Command Uninstall-ChocolateyPath -ErrorAction SilentlyContinue) {
    Write-Host "Removing '$packageDir' from PATH..."
    Uninstall-ChocolateyPath "$packageDir"
} else {
    Write-Host "Please remove '$packageDir' manually from PATH.",
      "This should work automatically with future 'choco' versions."
}

$osBitness = Get-ProcessorBits

$binRoot = Get-ToolsLocation
# MSYS2 root dir is named msys32 or msys64
$msysName = "msys$osBitness"
$msysRoot = Join-Path $binRoot $msysName

Write-Host "Not removing '$msysRoot'.",
  "Please remove it manually (and also from PATH)",
  "when you don't need it anymore."
