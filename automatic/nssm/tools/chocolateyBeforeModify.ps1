
# If some nssm service is up and running, kill it so that exe can be updated
Get-Process nssm.exe -ea 0 | Stop-Process -Force