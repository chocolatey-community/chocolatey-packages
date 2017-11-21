import-module au

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
        ".\legal\VERIFICATION.txt" = @{
          "(?i)(\s*download the.*)<.*>" = "`$1<$($Latest.URL32)>"
          "(?i)(^\s*checksum\s*type\:).*" = "`${1} $($Latest.ChecksumType32)"
          "(?i)(^\s*checksum(32)?\:).*" = "`${1} $($Latest.Checksum32)"
        }
   }
}

function global:au_BeforeUpdate {
    Get-RemoteFiles -Purge -NoSuffix

    set-alias 7z $Env:chocolateyInstall\tools\7z.exe
    rm tools\*.exe
    7z e tools\*.nupkg NuGet.exe -r -otools
    rm tools\*.nupkg
}

function global:au_GetLatest {
    $package = Find-Package $packageName -provider "nuget" -Source http://www.nuget.org/api/v2/ -AllowPrereleaseVersions -Force
    $version = $package.Version
    @{
        Version = $version
        Url32   = "https://api.nuget.org/packages/$($packageName.ToLower()).${version}.nupkg"
    }
}

update -ChecksumFor none
