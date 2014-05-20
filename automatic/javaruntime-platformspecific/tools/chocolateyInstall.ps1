$name   = '{{PackageName}}'
# Find download URLs at http://www.java.com/en/download/manual.jsp
$url    = '{{DownloadUrl}}'
$url64  = '{{DownloadUrlx64}}'
$version = '{{PackageVersion}}'
$type   = 'exe'
$silent = "/s REBOOT=Suppress"
$java   = Join-Path $env:ProgramFiles 'Java\jre7'
$bin    = Join-Path $java 'bin'
$uroot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'

function Find-CID {
    param([String]$croot, [string]$cdname, [string]$ver)

    if (Test-Path $croot) {
        Get-ChildItem -Force -Path $croot | foreach {
            $CurrentKey = (Get-ItemProperty -Path $_.PsPath)
            if ($CurrentKey -match $cdname -and $CurrentKey -match $ver -and $CurrentKey -match 'jre') {
                return $CurrentKey.PsChildName
            }
        }
    }

    return $null
}

try {

    $msid = Find-CID $uroot 'Java \d Update \d{1,2}' $version

    if ($msid) {
        Write-Output "Java Runtime Environment $version is already installed."
        # No need to add a Java environment variable
    } else {
        Install-ChocolateyPackage $name $type $silent $url $url64
        Install-ChocolateyPath $bin 'Machine'
        Start-ChocolateyProcessAsAdmin @"
[Environment]::SetEnvironmentVariable('JAVA_HOME', '$java', 'Machine')
"@
    }

} catch {
    Write-ChocolateyFailure $name $($_.Exception.Message)
    return
}
