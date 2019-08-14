$ErrorActionPreference = 'Stop'
$exeName = "MediaCreationTool.exe"

$toolsDir = Split-Path -Parent $MyInvocation.MyCommand.Definition

$packageArgs = @{
  PackageName  = $env:chocolateyinstall
  FileFullPath = "$toolsDir\$exeName"
  Url          = 'https://software-download.microsoft.com/download/pr/MediaCreationTool1903.exe'
  Checksum     = 'C61F006C4FD4A6FFA8A140FADA778B1CD0521811851CACC8822ECA1525141788DD58B792B64787937306954A57FE8890122AB7F6E96FE73B22F91909B16842A8'
  ChecksumType = 'sha512'
}
Get-ChocolateyWebFile @packageArgs

Register-Application "$toolsDir\$exeName"
