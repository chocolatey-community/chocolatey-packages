$scriptDir = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$matchLanguagePath = Join-Path $scriptDir 'matchLanguage.ps1'
$loHelpIsAlreadyInstalled = Join-Path $scriptDir 'loHelpIsAlreadyInstalled.ps1'

Import-Module $matchLanguagePath
Import-Module $loHelpIsAlreadyInstalled

$packageName = 'libreoffice-help'
$fileType = 'msi'
$version = '{{PackageVersion}}'
$silentArgs = '/passive /norestart'

function getInstallLanguageOverride($installArguments) {
  $argumentMap = ConvertFrom-StringData $installArguments
  $langFromInstallArgs = $argumentMap.Item('l')
  return $langFromInstallArgs
}

function getLangOfExistentInstall() {
  $majorVersion = $version -replace '(^\d).+', '$1'
  $helpInstallPath32 = "$env:ProgramFiles\LibreOffice $majorVersion\help"
  $helpInstallPath64 = "${env:ProgramFiles(x86)}\LibreOffice $majorVersion\help"

  if (Test-Path $helpInstallPath32) {
    return (Get-ChildItem $helpInstallPath32 | ?{ $_.PSIsContainer }).Name
  }

  if (Test-Path $helpInstallPath64) {
    return (Get-ChildItem $helpInstallPath64 | ?{ $_.PSIsContainer }).Name
  }

  return $null
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
$ofExistentInstall = getLangOfExistentInstall
$fallback = 'en-US'

$language = matchLanguage $availableLangs $installOverride $ofExistentInstall $fallback

# if multiple language packs in different are already install,
# update all of them, otherwise update/install only the matched language
if (($ofExistentInstall -is [System.Array]) -and ($installOverride -eq $null)) {
  foreach ($existentLang in $ofExistentInstall) {
    $url = "http://download.documentfoundation.org/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86_helppack_${existentLang}.msi"

    # If LibreOffice Help Pack with the same version as the package version is not already installed,
    # download and install the Help Pack of the existent language
    if (-not(loHelpIsAlreadyInstalled 'LibreOffice' $version $existentLang)) {
      Install-ChocolateyPackage "$packageName $existentLang" $fileType $silentArgs $url
    } else {
      Write-Output "LibreOffice Help Pack $version ($existentLang) is already installed."
    }
  }
} else {
  # Download of libreoffice-help with the right version and language
  $url = "http://download.documentfoundation.org/libreoffice/stable/${version}/win/x86/LibreOffice_${version}_Win_x86_helppack_${language}.msi"

  # If LibreOffice Help Pack with the same version as the package version is not already installed,
  # download and install the Help Pack of the matched
  if (-not(loHelpIsAlreadyInstalled 'LibreOffice' $version $language)) {
    Install-ChocolateyPackage $packageName $fileType $silentArgs $url
  } else {
    Write-Output "LibreOffice Help Pack $version ($language) is already installed."
  }
}
