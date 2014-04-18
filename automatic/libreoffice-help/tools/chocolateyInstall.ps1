$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$matchLanguagePath = Join-Path $scriptDir 'matchLanguage.ps1'

Import-Module $matchLanguagePath

function getInstallLanguageOverride($installArguments) {
    $argumentMap = ConvertFrom-StringData $installArguments
    $langFromInstallArgs = $argumentMap.Item('l')
    return $langFromInstallArgs
}

function getLangOfExistentInstall() {
    
}

$packageName = 'libreoffice-help'
$fileType = 'msi'
$version = '{{PackageVersion}}'
$silentArgs = '/passive'

try {


    # Version selection (downloads the next version if the current package version is outdated)
    # This prevents 404 errors, because older LibreOffice versions are no longer available to download

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


    # Language detection

    $urlDownloadLinks = "http://download.documentfoundation.org/libreoffice/stable/$version/win/x86/"
    $htmlDownloadLinks = "$env:TEMP\libreoffice-help-download-links.html"

    Get-ChocolateyWebFile 'libreoffice-help-download-links' $htmlDownloadLinks $urlDownloadLinks

    $htmlLinksContent = Get-Content $htmlDownloadLinks
    Remove-Item $htmlDownloadLinks

    $regex = '(?<=helppack_)[\-a-zA-Z]{2,}(?=\.msi">)'

    $matchObject = [regex]::Matches($htmlLinksContent, $regex)

    # Language matching with matchLanguage function
    $availableLangs = @()

    foreach ($singleMatch in $matchObject) {
        $availableLangs += $singleMatch.Value
    }

    $installOverride = getInstallLanguageOverride $installArguments
    $ofExistentInstall = $null
    $fallback = 'en-US'

    $language = matchLanguage $availableLangs $installOverride $ofExistentInstall $fallback

    Write-Host '---'
    Write-Host $language
    Write-Host '---'



    # Download of libreoffice-help with the right version and language
    $url = "http://download.documentfoundation.org/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86_helppack_${language}.msi"

    Install-ChocolateyPackage $packageName $fileType $silentArgs $url

}   catch {
    Write-ChocolateyFailure $packageName $($_.Exception.Message)
    throw 
}