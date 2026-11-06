$ErrorActionPreference = 'Stop';
$toolsPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Remove-Item -Recurse -Force -Path "$toolsPath"
