function Find-CID {
    param([String]$croot, [string]$cdname, [string]$ver)

    if (Test-Path $croot) {
        Get-ChildItem -Force -Path $croot | foreach {
            $CurrentKey = (Get-ItemProperty -Path $_.PsPath)
            if ($CurrentKey -match $cdname -and $CurrentKey -like "*${ver}*") {
                return $CurrentKey.PsChildName
            }
        }
    }
    return $null
}

$packageName = '{{PackageName}}'
$version = '{{PackageVersion}}'


#try {
# Example: $clsid='{F1EE568A-171F-4C06-9BE6-2395BED067A3}'


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


    $uroot = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall'
    $uroot64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall'
    $msid = Find-CID $uroot "LibreOffice" "$version"
    if ($msid -eq $null) {
        # try 64bit registry
        $msid = Find-CID $uroot64 'LibreOffice' $version
    }
    if ($msid -ne $null) {
        Write-Host "LibreOffice $version is already installed!"
    } else {
        # installer, will assert administrative rights
        Install-ChocolateyPackage $packageName 'MSI' '/passive' $downUrl -validExitCodes @(0)
        # the following is all part of error handling
    }
#} catch {
#  Write-ChocolateyFailure $packageName $($_.Exception.Message)
#  throw
#}
