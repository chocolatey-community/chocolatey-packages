function Set-UpdateChannel() {
  param(
    [Parameter(Mandatory=$true)]
    [string]$UpdateChannel
  )

  $codeSettingsPath = $(Join-Path $env:APPDATA "Code") 
  if (-not (Test-Path $codeSettingsPath)) {
    Write-Output "Settings path '$codeSettingsPath' does not exist. Creating it now."
    New-Item -ItemType Directory -Path $codeSettingsPath | Out-Null
  } else {
    Write-Output "Settings path '$codeSettingsPath' already exists."
  }

  $storageFilePath = $(Join-Path $codeSettingsPath "storage.json")
  if (-not (Test-Path $storageFilePath)) {
    Write-Output "Settings file '$storageFilePath' does not exist. Creating it now."
    New-Item -ItemType File -Path $storageFilePath | Out-Null

    $storageFileContent = @"
{
  "updateChannel": "$UpdateChannel"
}
"@
  } else {
    Write-Output "Settings file '$storageFilePath' already exists."

    $storageFileContent = Get-Content $storageFilePath -Encoding UTF8

    if ($PSVersionTable.PSVersion.Major -gt 2) {
      $storageFileObject = ConvertFrom-Json "$storageFileContent"
    } else {
      $storageFileObject = ConvertFrom-Json-Posh20 "$storageFileContent"
    }

    try
    {
      $storageFileObject.updateChannel = "$UpdateChannel"
      Write-Output "Updated 'updateChannel' to '$UpdateChannel'."
    }
    catch
    {
      Write-Output "Add new 'updateChannel' node with value '$UpdateChannel'."
      $storageFileObject | Add-Member -Name "updateChannel" -value $UpdateChannel -MemberType NoteProperty
    }

    if ($PSVersionTable.PSVersion.Major -gt 2) {
      $storageFileContent = ConvertTo-Json $storageFileObject -Depth 100
    } else {
      $storageFileContent = ConvertTo-Json-Posh20 $storageFileObject
    }
  }

  $storageFileContent | Set-Content $storageFilePath
}

function ConvertFrom-Json-Posh20() { 
  param(
    [Parameter(Mandatory=$true)]
    [string] $json
  )

  Add-Type -assembly System.Web.Extensions
  $serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer

  #The comma operator is the array construction operator in PowerShell
  return ,$serializer.DeserializeObject($json)
}

function ConvertTo-Json-Posh20() {
  param(
    [Parameter(Mandatory=$true)]
    [object] $item
  )

  Add-Type -assembly System.Web.Extensions
  $serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
  return $serializer.Serialize($item)
}