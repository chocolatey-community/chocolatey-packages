$packageName = 'libreoffice'
$version = '4.2.4'

try {

    $versionsHtmlFile = "$env:TEMP\libreoffice-versions.html"
    $versionsHtmlUrl = 'http://download.documentfoundation.org/libreoffice/stable/'

    Get-ChocolateyWebFile 'libreoffice-versions-html' $versionsHtmlFile $versionsHtmlUrl

    $matchArray = (Get-Content $versionsHtmlFile) -match 'href="([\d\.]+)\/"'

    Remove-Item $versionsHtmlFile

    $downloadableVersions = @()

    for ($i = 0; $i -lt $matchArray.Length; $i += 1) {
        $matchArray[$i] -match '[\d\.]+'
        $downloadableVersions += $Matches[0]
    }

    if (-not($downloadableVersions -match $version)) {

        Write-Output 'The version of LibreOffice specified in the package is no longer available to download. This package will download the latest available version instead.'

        if ([System.Version]$downloadableVersions[0] -gt [System.Version]$downloadableVersions[1]) {
            $version = $downloadableVersions[0]
        } else {
            $version = $downloadableVersions[1]
        }
    }

    $downUrl = "http://download.documentfoundation.org/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86.msi"


    # Check if LibreOffice in the same version is already installed
    $alreadyInstalled = Get-WmiObject -Class Win32_Product | Where-Object {($_.Name -match '^LibreOffice [\d\.]+$') -and ($_.Version -match "^$version")}

    if ($alreadyInstalled) {
        Write-Host "LibreOffice $version is already installed on the computer. Skipping download."
    } else {
        Install-ChocolateyPackage $packageName 'msi' '/passive' $downUrl -validExitCodes @(0)
    }

} catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw
}
