$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
Rename-Item -Path $scriptPath\test-before.txt -NewName test-after.txt