# Check if Windows Sandbox is enabled

if (-Not (Test-Path "$env:windir\System32\WindowsSandbox.exe")) {
  Write-Error -Category NotInstalled -Message @'
Windows Sandbox does not seem to be available. Check the following URL for prerequisites and further details:
https://docs.microsoft.com/en-us/windows/security/threat-protection/windows-sandbox/windows-sandbox-overview

You can run the following command in an elevated PowerShell for enabling Windows Sandbox:
Enable-WindowsOptionalFeature -Online -FeatureName 'Containers-DisposableClientVM'
'@ -ErrorAction Stop
}

# Closing Windows Sandbox

$sandbox = Get-Process WindowsSandboxClient -ErrorAction SilentlyContinue
if ($sandbox) {
  Write-Host '--> Closing Windows Sandbox'
  $sandbox | Stop-Process
  Start-Sleep -Seconds 5
}
Remove-Variable sandbox

# Initialize Temp Folder

$repositoryFolder = Get-Item $(git rev-parse --show-toplevel)

$tempFolder = Join-Path -Path ([System.IO.Path]::GetTempPath()) -ChildPath 'Start-Sandbox'

if (Test-Path -Path $tempFolder) {
  Remove-Item -Path $tempFolder -Recurse -Force 
}

New-Item $tempFolder -ItemType Directory | Out-Null

# Create Wsb file

$repositoryFolderInSandbox = Join-Path -Path 'C:\Users\WDAGUtilityAccount\Desktop' -ChildPath (Split-Path -Path $repositoryFolder -Leaf)
$bootstrapPs1InSandbox = 'scripts\Bootstrap-Sandbox.ps1'

$sandboxTestWsbContent = @"
<Configuration>
  <MappedFolders>
    <MappedFolder>
      <HostFolder>$repositoryFolder</HostFolder>
    </MappedFolder>
  </MappedFolders>
  <LogonCommand>
  <Command>PowerShell Start-Process PowerShell -WindowStyle Maximized -WorkingDirectory '$repositoryFolderInSandbox' -ArgumentList '-ExecutionPolicy Bypass -NoExit -File $bootstrapPs1InSandbox $args'</Command>
  </LogonCommand>
</Configuration>
"@

$sandboxTestWsbFileName = 'SandboxTest.wsb'
$sandboxTestWsbFile = Join-Path -Path $tempFolder -ChildPath $sandboxTestWsbFileName
$sandboxTestWsbContent | Out-File $sandboxTestWsbFile

Write-Host '--> Starting Windows Sandbox, and:'
Write-Host '    - Mounting the following directory:'
Write-Host "      $repositoryFolder"
Write-Host '    - Installing Chocolatey'
if (-Not [string]::IsNullOrWhiteSpace($args)) {
  Write-Host '    - Running the following command:'
  Write-Host "      $ $args"
}

WindowsSandbox $SandboxTestWsbFile
