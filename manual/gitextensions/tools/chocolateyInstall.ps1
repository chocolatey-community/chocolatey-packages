$url = 'https://github.com/gitextensions/gitextensions/releases/download/v2.51.01/GitExtensions-2.51.01-Setup.msi'
$checksum = '508b695d6bc1778b6048132622a71f83b6de35fb24bb44a13f1fc791e6537919'

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  fileType      = 'msi'
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'
  silentArgs    = '/quiet /norestart ADDDEFAULT=ALL REMOVE=AddToPath,Icons'
  validExitCodes= @(0, 3010, 1641)
}

# the REMOVE parameter that is defined in silentArgs was obtained with the
# following PowerShell snippet.
# NB we do not let the installer add the GitExtensions directory to the PATH
#    because it leaves too many executables and dlls available on the search
#    PATH. instead we create a single shim to gitex.cmd.
<#
  (
    (
      @(
        lessmsi l -t Feature gitextensionsInstall.msi `
          | ConvertFrom-Csv `
          | Where-Object {$_.Level -gt 1} `
          | ForEach-Object {$_.Feature} `
      ) + 'AddToPath'
    ) | Sort-Object -Unique
  ) -join ','
#>

Install-ChocolateyPackage @packageArgs

#------- ADDITIONAL SETUP -------#

$osBitness = Get-ProcessorBits
$is64bit = $osBitness -eq 64

$progFiles = [System.Environment]::GetFolderPath('ProgramFiles')
if ($is64bit -and $progFiles -notmatch 'x86') {$progFiles = "$progFiles (x86)"}

Install-BinFile gitex "$progFiles\GitExtensions\gitex.cmd"
