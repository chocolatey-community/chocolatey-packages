$packageName = 'jitsi'
$version = '2.4.4997'

$installerType = 'msi'
$url = 'https://download.jitsi.org/jitsi/msi/jitsi-2.4.4997-x86.msi'
$url64 = 'https://download.jitsi.org/jitsi/msi/jitsi-2.4.4997-x64.msi'

$silentArgs = '/passive'
$validExitCodes = @(0)

try {

    $alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {($_.Name -match 'Jitsi') -and ($_.Version -match $version)}

    if ($alreadyInstalled) {
        Write-Output "Jitsi $softwareVersion is already installed on the computer. Skipping download and installation."
    } else {
        Install-ChocolateyPackage $packageName $installerType $silentArgs $url $url64 -validExitCodes $validExitCodes
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}