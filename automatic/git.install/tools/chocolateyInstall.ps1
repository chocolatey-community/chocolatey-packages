$registryKeyName = 'Git_is1'
$packageId = '{{PackageName}}'
$fileType = 'exe'
$fileArgs = $(
  '/VERYSILENT /NORESTART /NOCANCEL /SP- ' +
  '/COMPONENTS="icons,icons\quicklaunch,ext,ext\shellhere,ext\guihere,assoc,assoc_sh" /LOG'
)
$url = '{{DownloadUrl}}'
$url64 = '{{DownloadUrlx64}}'

$arguments = @{};
# /GitOnlyOnPath /GitAndUnixToolsOnPath /NoAutoCrlf
$packageParameters = $env:chocolateyPackageParameters;

# Default the values
$useWindowsTerminal = $false
$gitCmdOnly = $false
$unixTools = $false
$noAutoCrlf = $false # this does nothing unless true

# Now parse the packageParameters using good old regular expression
if ($packageParameters) {
    $match_pattern = "\/(?<option>([a-zA-Z]+)):(?<value>([`"'])?([a-zA-Z0-9- _\\:\.]+)([`"'])?)|\/(?<option>([a-zA-Z]+))"
    #"
    $option_name = 'option'
    $value_name = 'value'

    if ($packageParameters -match $match_pattern ){
        $results = $packageParameters | Select-String $match_pattern -AllMatches
        $results.matches | % {
          $arguments.Add(
              $_.Groups[$option_name].Value.Trim(),
              $_.Groups[$value_name].Value.Trim())
      }
    }
    else
    {
      throw "Package Parameters were found but were invalid (REGEX Failure)"
    }

    if ($arguments.ContainsKey("GitOnlyOnPath")) {
        Write-Host "You want Git on the command line"
        $gitCmdOnly = $true
    }

    if ($arguments.ContainsKey("WindowsTerminal")) {
        Write-Host "You do not want to use MinTTY terminal"
        $useWindowsTerminal = $true
    }

    if ($arguments.ContainsKey("GitAndUnixToolsOnPath")) {
        Write-Host "You want Git and Unix Tools on the command line"
        $unixTools = $true
    }

    if ($arguments.ContainsKey("NoAutoCrlf")) {
        Write-Host "Ensuring core.autocrlf is false on first time install only"
        Write-Host " This setting will not adjust an already existing .gitconfig setting."
        $noAutoCrlf = $true
    }
} else {
    Write-Debug "No Package Parameters Passed in";
}

$is64bit = (Get-ProcessorBits) -eq 64
$installKey = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
if ($is64bit -eq $true -and $env:chocolateyForceX86 -eq $true) {
  $installKey = "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
}

$userInstallKey = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Uninstall\$registryKeyName"
if (Test-Path $userInstallKey) {
  $installKey = $userInstallKey
}

if ( -not (Test-Path $installKey)) {
  New-Item -Path $installKey | Out-Null
}

if ($gitCmdOnly) {
  # update registry so installer picks it up automatically
  New-ItemProperty $installKey -Name "Inno Setup CodeFile: Path Option" -Value "Cmd" -PropertyType "String" -Force | Out-Null
}

if ($useWindowsTerminal) {
  # update registry so installer picks it up automatically
  New-ItemProperty $installKey -Name "Inno Setup CodeFile: Bash Terminal Option" -Value "ConHost" -PropertyType "String" -Force | Out-Null
}

if ($unixTools) {
  # update registry so installer picks it up automatically
  New-ItemProperty $installKey -Name "Inno Setup CodeFile: Path Option" -Value "CmdTools" -PropertyType "String" -Force | Out-Null
}

if ($noAutoCrlf) {
  # update registry so installer picks it up automatically
  New-ItemProperty $installKey -Name "Inno Setup CodeFile: CRLF Option" -Value "CRLFCommitAsIs" -PropertyType "String" -Force | Out-Null
}

# Make our install work properly when running under SYSTEM account (Chef Cliet Service, Puppet Service, etc)
# Add other items to this if block or use $IsRunningUnderSystemAccount to adjust existing logic that needs changing
$IsRunningUnderSystemAccount = ([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem
If ($IsRunningUnderSystemAccount)
{
  #strip out quicklaunch parameter as it causes a hang under SYSTEM account
  $fileArgs = $fileArgs.replace('icons\quicklaunch,','')
  If ($fileArgs -inotlike "*/SUPPRESSMSGBOXES*")
  {
    $fileArgs = $fileArgs + ' /SUPPRESSMSGBOXES'
  }
}

If ([bool](get-process ssh-agent -ErrorAction SilentlyContinue))
{
  Write-Output "Killing any git ssh-agent instances for install."
  (get-process ssh-agent | where {$_.Path -ilike "*\git\usr\bin\*"}) | stop-process
}

Install-ChocolateyPackage $packageId $fileType $fileArgs $url $url64

if (Test-Path $installKey) {
  $keyNames = Get-ItemProperty -Path $installKey

  if ($gitCmdOnly -eq $false -and $unixTools -eq $false) {
    $installLocation = $keyNames.InstallLocation
    if ($installLocation -ne '') {
      $gitPath = Join-Path $installLocation 'cmd'
      Install-ChocolateyPath $gitPath 'Machine'
    }
  }
}

Write-Warning "Git installed - You may need to close and reopen your shell for PATH changes to take effect."
