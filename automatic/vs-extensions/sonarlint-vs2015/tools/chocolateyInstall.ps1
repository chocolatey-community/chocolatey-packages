$ErrorActionPreference = 'Stop';

$parameters = @{
    PackageName = "sonarlint-vs2015"
    VsixUrl = "https://sonarsource.gallerycdn.vsassets.io/extensions/sonarsource/sonarlintforvisualstudio/2.9.0.355/1484298304458/169863/22/SonarLint.VSIX-2.9.0.355-2015.vsix"
    VsVersion = 14 
    Checksum = "0c2b917139d2c379cc1403a83ae271ef0275dc71822ef4a99a39d362e903285e"
    ChecksumType = "sha256"
}

Install-ChocolateyVsixPackage @parameters
