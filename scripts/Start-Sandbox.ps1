# Parse arguments

Param(
  [Parameter(Position=0)]
  [ScriptBlock] $Script,
  [String] $MapFolder = $pwd
)

$ErrorActionPreference = "Stop"

$mapFolder = [System.IO.Path]::GetFullPath($MapFolder)

if (-Not (Test-Path -Path $mapFolder -PathType Container)) {
  Write-Error -Category InvalidArgument -Message 'The provided MapFolder is not a folder.'
}

# Check if Windows Sandbox is enabled

if (-Not (Get-Command 'WindowsSandbox' -ErrorAction SilentlyContinue)) {
  Write-Error -Category NotInstalled -Message @'
Windows Sandbox does not seem to be available. Check the following URL for prerequisites and further details:
https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-overview

You can run the following command in an elevated PowerShell for enabling Windows Sandbox:
$ Enable-WindowsOptionalFeature -Online -FeatureName 'Containers-DisposableClientVM'
'@
}

# Close Windows Sandbox

$sandbox = Get-Process 'WindowsSandboxClient' -ErrorAction SilentlyContinue
if ($sandbox) {
  Write-Host '--> Closing Windows Sandbox'
  $sandbox | Stop-Process
  Start-Sleep -Seconds 5
}
Remove-Variable sandbox

# Initialize Temp Folder

$tempFolderName = 'Start-Sandbox'
$tempFolder = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath $tempFolderName

if (Test-Path -Path $tempFolder) {
  Remove-Item -Path $tempFolder -Recurse -Force
}

New-Item $tempFolder -ItemType Directory | Out-Null

# Create Bootstrap script

$bootstrapPs1Content = @"
Write-Host @'
--> Installing Chocolatey

'@
Invoke-WebRequest -useb 'https://chocolatey.org/install.ps1' | Invoke-Expression
Write-Host @'

--> Enabling automatic confirmation for Chocolatey

'@
choco feature enable -n=allowGlobalConfirmation
Write-Host
"@

if (-Not [String]::IsNullOrWhiteSpace($Script)) {
  $bootstrapPs1Content += @"

Write-Host @'
--> Running the following script:

{
$Script
}

'@

$Script
"@
}

$bootstrapPs1FileName = 'Bootstrap.ps1'
$bootstrapPs1Content | Out-File (Join-Path -Path $tempFolder -ChildPath $bootstrapPs1FileName)

# Create Wsb file

$desktopInSandbox = 'C:\Users\WDAGUtilityAccount\Desktop'
$bootstrapPs1InSandbox = Join-Path -Path $desktopInSandbox -ChildPath (Join-Path -Path $tempFolderName -ChildPath $bootstrapPs1FileName)


$mapFolderInSandbox = Join-Path -Path $desktopInSandbox -ChildPath (Split-Path -Path $mapFolder -Leaf)

$sandboxTestWsbContent = @"
<Configuration>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>$tempFolder</HostFolder>
      <ReadOnly>true</ReadOnly>
    </MappedFolder>
    <MappedFolder>
      <HostFolder>$mapFolder</HostFolder>
    </MappedFolder>
  </MappedFolders>
  <LogonCommand>
  <Command>PowerShell Start-Process PowerShell -WindowStyle Maximized -WorkingDirectory '$mapFolderInSandbox' -ArgumentList '-ExecutionPolicy Bypass -NoExit -NoLogo -File $bootstrapPs1InSandbox'</Command>
  </LogonCommand>
</Configuration>
"@

$sandboxTestWsbFileName = 'SandboxTest.wsb'
$sandboxTestWsbFile = Join-Path -Path $tempFolder -ChildPath $sandboxTestWsbFileName
$sandboxTestWsbContent | Out-File $sandboxTestWsbFile

Write-Host @"
--> Starting Windows Sandbox, and:
    - Mounting the following directories:
      - $tempFolder
      - $mapFolder
    - Installing Chocolatey
"@
if (-Not [String]::IsNullOrWhiteSpace($Script)) {
  Write-Host @"
    - Running the following script:

{
$Script
}

"@
}

WindowsSandbox $SandboxTestWsbFile
