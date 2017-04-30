$ErrorActionPreference = 'Stop'

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
. $toolsPath\helpers.ps1

$gitExecutable = Get-GitExecutable
& $gitExecutable config --system --unset credential.helper
