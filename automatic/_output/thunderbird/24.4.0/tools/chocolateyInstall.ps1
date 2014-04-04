# ---------------- Function definitions ------------------


function GetUninstallPath () {
    $regUninstallDir = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\'
    $regUninstallDirWow64 = 'HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\'

    $uninstallPaths = $(Get-ChildItem $regUninstallDir).Name

    if (Test-Path $regUninstallDirWow64) {
        $uninstallPaths += $(Get-ChildItem $regUninstallDirWow64).Name
    }
    
    $uninstallPath = $uninstallPaths -match "Mozilla Thunderbird [\d\.]+ \([^\s]+ [a-zA-Z\-]+\)" | Select -First 1
    return $uninstallPath
}

function GetLocale($installArguments) {

    $availableLocales = Get-Content "$env:TEMP\chocolatey\Thunderbird\availableLocales.html"

    # --- Get locale from installArgs if specified

    $argumentMap = ConvertFrom-StringData $installArguments
    $localeFromInstallArgs = $argumentMap.Item('l')

    # ---

    # --- Get already installed locale if available

    $uninstallPath = GetUninstallPath($null)

    $alreadyInstalledLocale = $uninstallPath -replace ".+\s([a-zA-Z\-]+)\)", '$1'


    # ---

    # --- Other locales

    $systemLocaleAndCountry = (Get-Culture).Name
    $systemLocaleTwoLetter = (Get-Culture).TwoLetterISOLanguageName
    $fallbackLocale = 'en-US'

    # ---

    $locales = $localeFromInstallArgs, $alreadyInstalledLocale, $systemLocaleAndCountry, $systemLocaleTwoLetter, $fallbackLocale

    foreach ($locale in $locales) {
        $localeMatch = $availableLocales -match "os=win&amp;lang=$locale`"" | Select -First 1
        if ($localeMatch -and $locale -ne $null) {
            break
        }
    }

    return $locale
}

function AlreadyInstalled($version) {
    $uninstallEntry = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla Thunderbird ${version}*"
    $uninstallEntryWow64 = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Mozilla Thunderbird ${version}*"

    if ((Test-Path $uninstallEntry) -or (Test-Path $uninstallEntryWow64)) {
        return $true
    } else {
        return $false
    }
}

# ----------------------------------




$packageName = 'thunderbird'
$fileType = 'exe'
$version = '24.4.0'

$urlFile = 'https://www.mozilla.org/en-US/thunderbird/all.html'
$filePath = "$env:TEMP\chocolatey\$packageName"

try {
        $alreadyInstalled = AlreadyInstalled($version)

    if ($alreadyInstalled) {
        Write-Host "Thunderbird $version is already installed."
    } else {


        if (-not (Test-Path $filePath)) {
            New-Item -ItemType directory -Path $filePath
        }

        Get-ChocolateyWebFile 'locales list for Thunderbird' "$env:TEMP\chocolatey\$packageName\availableLocales.html" $urlFile

        $locale = GetLocale($installArguments)

        $url = "http://download.mozilla.org/?product=thunderbird-$version&os=win&lang=$locale"

        Install-ChocolateyPackage $packageName $fileType '-ms' $url
    }

} catch {
  Write-ChocolateyFailure $packageName $($_.Exception.Message)
  throw 
}
