$ErrorActionPreference = 'Stop';

$toolsPath = Split-Path $MyInvocation.MyCommand.Definition
$filePath = "$toolsPath\SonarLint.VSIX-4.16.0.14364-2019.vsix"

$vsixUrl =  "file://" + $filePath.Replace("\", "/")

$parameters = @{
    PackageName = "sonarlint-vs2019"
    VsixUrl = $vsixUrl
    VsVersion = 16 
}

Install-ChocolateyVsixPackage @parameters
