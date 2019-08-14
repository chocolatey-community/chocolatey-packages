Import-Module AU
Import-Module Wormies-AU-Helpers
Import-Module "$env:ChocolateyInstall\helpers\chocolateyInstaller.psm1"
Import-Module "$PSScriptRoot\..\..\scripts/au_extensions.psm1"

$x64Release = 'https://aka.ms/vs/15/release/VC_redist.x64.exe'

function global:au_SearchReplace {
  @{
    ".\vcredist2017.nuspec" = @{
      "(\<dependency .+? version=)`"([^`"]+)`"" = "`$1`"$($Latest.Version)`""
    }
  }
}

function global:au_GetLatest {
  Update-OnETagChanged -execUrl $x64Release `
    -OnEtagChanged {
    $dest = "$env:TEMP\vcredist2017.exe"
    Get-WebFile $x64Release $dest | Out-Null
    $version = Get-Version (Get-Item $dest | % { $_.VersionInfo.ProductVersion })
    return @{
      Version = if ($version.Version.Revision -eq 0) { $version.ToString(3) } else { $version.ToString() }
    }
  } -OnUpdated { @{} }
}

update -ChecksumFor none
