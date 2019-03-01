$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

. "$toolsDir\helpers.ps1"

stopProcessIfExist -sleepAfter
