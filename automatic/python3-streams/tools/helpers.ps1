function Get-InstallLocation {
  param(
    [string]$twoPartVersion,
    [switch]$is32Bit
  )

  $regKey = "HKLM:\SOFTWARE\Python\PythonCore\$twoPartVersion\InstallPath"
  if (Get-OSArchitectureWidth -compare 32) {
    $regKey = "HKLM:\SOFTWARE\Python\PythonCore\$twoPartVersion-32\InstallPath"
  }
  elseif ($is32Bit -or ($env:ChocolateyForceX86 -eq $true)) {
    $regKey = "HKLM:\SOFTWARE\WOW6432Node\Python\PythonCore\$twoPartVersion-32\InstallPath"
  }

  return Get-RegistryKeyValue -key $regKey -subKey "(default)" | ForEach-Object { $_.TrimEnd('/', '\') }
}

function Get-RegistryKeyValue {
  param(
    [string]$key,
    [string]$subKey
  )

  Get-ItemProperty -Path $key | ForEach-Object { $_."$subKey" }
}

function Install-Python {
  param(
    [string]$toolsPath,
    [string]$installdir,
    [switch]$only32Bit
  )

  $prependPath = '1'
  if ($only32Bit) {
    $prependPath = '0'
  }

  $packageArgs = @{
    packageName    = 'python311'
    fileType       = 'exe'
    file           = "$toolsPath\python-3.11.4.exe"
    silentArgs     = '/quiet InstallAllUsers=1 PrependPath={0} TargetDir="{1}"' -f $prependPath, $installDir
    validExitCodes = @(0)
  }

  $minor_version = $packageArgs['packageName'].Substring('python3'.Length)
  $packageArgs['softwareName'] = "Python 3.$minor_version.*"

  if (!$only32Bit) {
    $packageArgs['file64'] = "$toolsPath\python-3.11.4-amd64.exe"
  }
  else {
    $packageArgs['packageName'] = "32-bit $($packageArgs['packageName'])"
  }

  Install-ChocolateyInstallPackage @packageArgs
  # create python3.x shim
  Install-BinFile "python3.$minor_version" "$installDir\python.exe"
}

function Get-LocalizedWellKnownPrincipalName {
  param (
    [Parameter(Mandatory = $true)]
    [Security.Principal.WellKnownSidType] $WellKnownSidType
  )
  $sid = New-Object -TypeName 'System.Security.Principal.SecurityIdentifier' -ArgumentList @($WellKnownSidType, $null)
  $account = $sid.Translate([Security.Principal.NTAccount])

  return $account.Value
}

function Protect-InstallFolder {
  param(
    [string]$packageName,
    [string]$defaultInstallPath,
    [string]$folder
  )
  Write-Debug "Ensure-Permissions"

  if ($folder.ToLower() -ne $defaultInstallPath.ToLower()) {
    Write-Warning "Installation folder is not the default. Not changing permissions. Please ensure your installation is secure."
    return
  }

  # Everything from here on out applies to the default installation folder

  if (!(Test-ProcessAdminRights)) {
    throw "Installation of $packageName to default folder requires Administrative permissions. Please run from elevated prompt."
  }

  $currentEA = $ErrorActionPreference
  $ErrorActionPreference = 'Stop'
  try {
    # get current acl
    $acl = (Get-Item $folder).GetAccessControl('Access,Owner')

    Write-Debug "Removing existing permissions."
    $acl.Access | ForEach-Object { $acl.RemoveAccessRuleAll($_) }

    $inheritanceFlags = ([Security.AccessControl.InheritanceFlags]::ContainerInherit -bor [Security.AccessControl.InheritanceFlags]::ObjectInherit)
    $propagationFlags = [Security.AccessControl.PropagationFlags]::None

    $rightsFullControl = [Security.AccessControl.FileSystemRights]::FullControl
    $rightsModify = [Security.AccessControl.FileSystemRights]::Modify
    $rightsReadExecute = [Security.AccessControl.FileSystemRights]::ReadAndExecute

    Write-Output "Restricting write permissions to Administrators"
    $builtinAdmins = Get-LocalizedWellKnownPrincipalName -WellKnownSidType ([Security.Principal.WellKnownSidType]::BuiltinAdministratorsSid)
    $adminsAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($builtinAdmins, $rightsFullControl, $inheritanceFlags, $propagationFlags, "Allow")
    $acl.SetAccessRule($adminsAccessRule)
    $localSystem = Get-LocalizedWellKnownPrincipalName -WellKnownSidType ([Security.Principal.WellKnownSidType]::LocalSystemSid)
    $localSystemAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($localSystem, $rightsFullControl, $inheritanceFlags, $propagationFlags, "Allow")
    $acl.SetAccessRule($localSystemAccessRule)
    $builtinUsers = Get-LocalizedWellKnownPrincipalName -WellKnownSidType ([Security.Principal.WellKnownSidType]::BuiltinUsersSid)
    $usersAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($builtinUsers, $rightsReadExecute, $inheritanceFlags, $propagationFlags, "Allow")
    $acl.SetAccessRule($usersAccessRule)

    $allowCurrentUser = $env:ChocolateyInstallAllowCurrentUser -eq 'true'
    if ($allowCurrentUser) {
      # get current user
      $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()

      if ($currentUser.Name -ne $localSystem) {
        $userAccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($currentUser.Name, $rightsModify, $inheritanceFlags, $propagationFlags, "Allow")
        Write-Warning 'Adding Modify permission for current user due to $env:ChocolateyInstallAllowCurrentUser. This could lead to escalation of privilege attacks. Consider not allowing this.'
        $acl.SetAccessRule($userAccessRule)
      }
    }
    else {
      Write-Debug 'Current user no longer set due to possible escalation of privileges - set $env:ChocolateyInstallAllowCurrentUser="true" if you require this.'
    }

    Write-Debug "Set Owner to Administrators"
    $builtinAdminsSid = New-Object System.Security.Principal.SecurityIdentifier([Security.Principal.WellKnownSidType]::BuiltinAdministratorsSid, $null)
    $acl.SetOwner($builtinAdminsSid)

    Write-Debug "Default Installation folder - removing inheritance with no copy"
    $acl.SetAccessRuleProtection($true, $false)

    # enact the changes against the actual
    (Get-Item $folder).SetAccessControl($acl)
  }
  catch {
    Write-Warning "Not able to set permissions for $folder."
    Write-Warning $_
  }
  $ErrorActionPreference = $currentEA
}
