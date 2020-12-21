$ErrorActionPreference = 'Stop'

$toolsDir = Split-Path -Path $MyInvocation.MyCommand.Definition
$contentDir = Join-Path -Path (Split-Path -Path $toolsDir) -ChildPath 'content'

$packageArgs = @{
  packageName   = $Env:ChocolateyPackageName
  file64        = "$toolsDir\BIND9.16.10.x64.zip"
  unzipLocation = $contentDir
}

$keep = @(
  'arpaname.exe',
  'bindevt.dll',
  'delv.exe',
  'dig.exe',
  'host.exe',
  'libbind9.dll',
  'libdns.dll',
  'libeay32.dll',
  'libirs.dll',
  'libisc.dll',
  'libisccc.dll',
  'libisccfg.dll',
  'liblwres.dll',
  'libxml2.dll',
  'nslookup.exe',
  'nsupdate.exe'
)

$keepExtensions = @(
  '.md',
  ''
)

Install-ChocolateyZipPackage @packageArgs
Remove-Item -Force "$toolsPath\*.zip" -ea 0
Get-ChildItem $contentDir `
  | Where-Object {
    if ($keep -contains $_) {
      return $false
    }

    if ($keepExtensions -contains $_.Extension) {
      return $false
    }

    return $true
  } `
  | Remove-Item -Force -Recurse
