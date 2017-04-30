$ErrorActionPreference = 'Stop'

$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
. $toolsPath\helpers.ps1

Set-UpdateChannel("default")