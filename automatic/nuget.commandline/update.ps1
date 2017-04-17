import-module au
. $PSScriptRoot\..\..\scripts\Set-DescriptionFromReadme.ps1

$packageName = 'NuGet.CommandLine'

function global:au_SearchReplace {
   @{
        # Those might be useful for some other nuget packages

        # ".\tools\chocolateyInstall.ps1" = @{
        #     "(?i)(^\s*[$]packageName\s*=\s*)('.*')"= "`$1'$packageName'"
        # }
        # ".\tools\chocolateyUninstall.ps1" = @{
        #     "(?i)(^\s*[$]packageName\s*=\s*)('.*')"= "`$1'$packageName'"
        # }
   }
}

function global:au_BeforeUpdate { 
    Get-RemoteFiles -Purge -NoSuffix

    set-alias 7z $Env:chocolateyInstall\tools\7z.exe
    rm tools\*.exe
    7z e tools\*.nupkg NuGet.exe -r -otools
    rm tools\*.nupkg
}

function global:au_AfterUpdate  { Set-DescriptionFromReadme -SkipFirst 2 }

function global:au_GetLatest {
    $releases = "https://www.nuget.org/packages/$packageName"
    $download_page = Invoke-WebRequest -Uri $releases

    $url     = $download_page.links | ? title -like '*this version*' | % href
    $version = $url -split '/' | select -last 1
    @{
        Version = $version 
        Url32   = "https://api.nuget.org/packages/$($packageName.ToLower()).${version}.nupkg"
    }
}

update -ChecksumFor none
