function Install-Service {
    <#
    .SYNOPSIS
    Installs a service

    .DESCRIPTION
    This will install a service

    .PARAMETER PackageName
    The name of the package for whom the service will be installed.

    .PARAMETER ServiceName
    The name of service which will be used to install and start the service.

    .PARAMETER CreateServiceCommand
    The command which installs the service.

    .PARAMETER AvailablePort (OPTIONAL)
        The port which needs to be available in order to start the service.

        .EXAMPLE
        Install-Service 'PACKAGE_NAME' 'SERVICE_NAME' 'INSTALL_COMMAND' 'PORT'
        Install-Service "dcm4chee" "DCM4CHEE" "nssm install DCM4CHEE `"java`" -jar `"%DCM4CHEE_HOME%/bin/run.jar"`" "8090"
        Install-Service "postgresqlzip" "PostgreSQL" "pg_ctl register -N `"PostgreSQL`" -U `"LocalSystem`" -w" "5432"
        Install-Service "apacheds" "ApacheDS" "nssm install ApacheDS `"java`" -jar `"%APACHEDS_HOME%/lib/apacheds-service-${version}.jar`" `"%APACHEDS_HOME%/instances/default`"" "10389"
        Install-Service "test" "test" "nssm install test `"$testDirectory\testService.bat`""

        .OUTPUTS
        None

        .NOTES
        This helper reduces the number of lines one would have to write to install a service to 1 line.
        This method has error handling built into it.

        .LINK
        UnInstall-Service
        Get-ServiceExistence
#>
        param(
            [string] $packageName,
            [string] $serviceName,
            [string] $createServiceCommand,
            [int] $availablePort
        )
        Write-debug "Running 'Install-Service' for $packageName with serviceName:`'$serviceName`', createServiceCommand: `'$createServiceCommand`', availablePort: `'$availablePort`' ";

    if (!$packageName) {
        Write-ChocolateyFailure "Install-Service" "Missing PackageName input parameter."
        return
        }

    if (!$serviceName) {
        Write-ChocolateyFailure "Install-Service" "Missing ServiceName input parameter."
        return
        }

    if (!$createServiceCommand) {
        Write-ChocolateyFailure "Install-Service" "Missing CreateServiceCommand input parameter."
        return
        }

        UnInstall-Service -serviceName "$serviceName"

    if ($availablePort -and (Get-StatePort)) {
        Write-ChocolateyFailure "Install-Service" "$availablePort is in LISTENING state and not available."
        return
        }

    try {
        Write-Host "$packageName service will be installed"
        iex $createServiceCommand
    } catch {
    Write-ChocolateyFailure "Install-Service" "The createServiceCommand is incorrect: '$_'."
    return
}

if (Get-ServiceExistence) {
        Write-Host "$packageName service will be started"

        for ($i=0;$i -lt 12; $i++) {
            $serviceStatus = Get-Service -Name $serviceName

                             start-service $serviceName

            if (($serviceStatus.Status -eq "running") -and (Get-StatePort)) {
                Write-Host "$packageName service has been started"
                return
            } else {
                Write-Host "$packageName service cannot be started. Attempt $i to start the service."
            }

            if ($i -eq 11) {
                Write-ChocolateyFailure "Install-Service" "service $serviceName cannot be started."
                return
                }

                Start-Sleep -s 10
            }
    } else {
        Write-ChocolateyFailure "Install-Service" "service $serviceName does not exist."
        return
        }
    }

function Get-ServiceExistence {
    param(
        [string] $serviceName = $serviceName
    )
    Get-WmiObject -Class Win32_Service -Filter "Name='$serviceName'"
}

function Uninstall-Service {
    param(
        [string] $serviceName = $serviceName
    )
    $service = Get-ServiceExistence -serviceName $serviceName

    if ($service) {
        Write-Host "$serviceName service already exists and will be removed"
        stop-service $serviceName
        $service.delete()
    }
}

function Get-StatePort {
    return Get-NetTCPConnection -State Listen | Where-Object {$_.LocalAddress -match "::|(127|0).0.0.(0|1)" -and $_.LocalPort -eq "$availablePort"}
}