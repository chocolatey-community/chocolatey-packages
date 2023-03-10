$ErrorActionPreference = 'Stop'

# Stop the process if it is running
Remove-Process -PathFilter alldup.exe -WaitFor 10 | Out-Null
