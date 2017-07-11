
# If some nssm service is up and running, kill it so that exe can be updated
ps nssm.exe -ea 0 | kill -Force