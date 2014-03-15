$packageName = 'libreoffice-help'
$fileType = 'msi'
$version = '{{PackageVersion}}'
$silentArgs = '/passive'
$language = (Get-Culture).Name # Get language and country code separated by hyphen
#$language = 'xx-XX' # Language override for testing purposes

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

        Write-Output 'The version of the Help-Pack for LibreOffice specified in the package is no longer available to download. This package will download the latest available version instead.'

        if ([System.Version]$downloadableVersions[0] -gt [System.Version]$downloadableVersions[1]) {
            $version = $downloadableVersions[0]
        } else {
            $version = $downloadableVersions[1]
        }
    }



    $urlFile = "http://download.documentfoundation.org/libreoffice/stable/$version/win/x86/"
    $filePath = "$env:TEMP\chocolatey\$packageName"
    $fileFullPath = "$filePath\downloadLinks.html"



    if (-not (Test-Path $filePath)) {
        New-Item -ItemType directory -Path $filePath
    }

    Get-ChocolateyWebFile $packageName $fileFullPath $urlFile

    # The $out variable contains a value when there is a LibreOffice help pack with the same language as system currently has.
    # Otherwise it will download the en-US help pack.

    $out = Select-String -Path $fileFullPath -Pattern "helppack_${language}.msi"
    if ($out -eq $null) {
        $out = Select-String -Path $fileFullPath -Pattern "helppack_${language}.msi"
    }

    if ($out -eq $null) {
        $language = $language -replace '\-[a-zA-Z]{2}', '' # Remove country code and hyphen
        $out = Select-String -Path $fileFullPath -Pattern "helppack_${language}.msi"
    }

    if ($out -eq $null) {
        $language = 'en-US' # Fallback language if others fail
    }

    $url = "http://download.documentfoundation.org/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86_helppack_${language}.msi"

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url

}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw 
}