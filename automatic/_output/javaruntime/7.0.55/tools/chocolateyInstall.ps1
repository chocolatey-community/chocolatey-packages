$name   = 'javaruntime'
# Find download URLs at http://www.java.com/en/download/manual.jsp
$url    = 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=86895'
$url64  = 'http://javadl.sun.com/webapps/download/AutoDL?BundleId=87443'
$version = '7.0.55'
$type   = 'exe'
$silent = "/s REBOOT=Suppress"
$java   = Join-Path $env:ProgramFiles 'Java\jre7'
$bin    = Join-Path $java 'bin'
$uroot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
$uroot6432node = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'

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
    $msid6432node = Find-CID $uroot6432node 'Java \d Update \d{1,2}' $version

    if ($msid) {
        Write-Output "Java Runtime Environment $version is already installed."
    } else {
        Install-ChocolateyPackage $name $type $silent $url
    }

    if ($msid6432node) {
        Write-Output "Java Runtime Environment (32-bit) $version is already installed."
    } else {
        $is64bit = (Get-WmiObject Win32_Processor).AddressWidth -eq 64
        if($is64bit) { 
            Install-ChocolateyPackage $name $type $silent $url64
        }
    }

    if ($msid -or $msid6432node) {
        # No need to add a Java environment variable
    } else {

        Install-ChocolateyPath $bin 'Machine'
        Start-ChocolateyProcessAsAdmin @"
[Environment]::SetEnvironmentVariable('JAVA_HOME', $java, 'Machine')
"@

    }

} catch {
    Write-ChocolateyFailure $name $($_.Exception.Message)
    return
}
