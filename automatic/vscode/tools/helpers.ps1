function Get-MergeTasks {
    $t  = "!runCode"
    $t += ', ' + '!'*$pp.NoDesktopIcon        + 'desktopicon'
    $t += ', ' + '!'*$pp.NoQuicklaunchIcon    + 'quicklaunchicon'
    $t += ', ' + '!'*$pp.NoContextMenuFiles   + 'addcontextmenufiles'
    $t += ', ' + '!'*$pp.NoContextMenuFolders + 'addcontextmenufolders'
    $t += ', ' + '!'*$pp.DontAddToPath        + 'addtopath'

    Write-Host "Merge Tasks: $t"
    $t
}

function Close-VSCode {
    Get-Process code -ea 0 | ForEach-Object { $_.CloseMainWindow() | Out-Null }
    Start-Sleep 1
    Get-Process code -ea 0 | Stop-Process  #in case gracefull shutdown did not succeed, try hard kill
}

function Set-UpdateChannel( [string] $UpdateChannel = "none" )
{
    function ConvertFrom-Json-Posh20([string] $json) { 
        Add-Type -Assembly System.Web.Extensions
        $serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer

        #The comma operator is the array construction operator in PowerShell
        return ,$serializer.DeserializeObject($json)
    }
        
    function ConvertTo-Json-Posh20([object] $item) {
        Add-Type -Assembly System.Web.Extensions
        $serializer = New-Object System.Web.Script.Serialization.JavaScriptSerializer
        return $serializer.Serialize($item)
    }

    $vsCodeSettingsPath = $(Join-Path $env:APPDATA "Code" | Join-Path -ChildPath "User")

    if (!(Test-Path $vsCodeSettingsPath)) {
        Write-Output "Settings path '$vsCodeSettingsPath' does not exist. Creating it now."
        New-Item -ItemType Directory -Path $vsCodeSettingsPath | Out-Null
    } else {
        Write-Output "Settings path '$vsCodeSettingsPath' already exists."
    }
  
    $storageFilePath = $(Join-Path $vsCodeSettingsPath "settings.json")
    if (!(Test-Path $storageFilePath)) {
        Write-Output "Settings file '$storageFilePath' does not exist. Creating it now."
        New-Item -ItemType File -Path $storageFilePath | Out-Null
    }

    $storageFileContent = Get-Content $storageFilePath -Encoding UTF8

    if ($PSVersionTable.PSVersion.Major -gt 2) {
             $storageFileObject = ConvertFrom-Json        "$storageFileContent"
    } else { $storageFileObject = ConvertFrom-Json-Posh20 "$storageFileContent" }

    try
    {
        $storageFileObject."update.channel" = "$UpdateChannel"
        Write-Output "Updated 'update.channel' to '$UpdateChannel'."
    }
    catch
    {
        Write-Output "Add new 'update.channel' node with value '$UpdateChannel'."
        $storageFileObject | Add-Member -Name "update.channel" -value $UpdateChannel -MemberType NoteProperty
    }

    if ($PSVersionTable.PSVersion.Major -gt 2) {
             $storageFileContent = ConvertTo-Json        $storageFileObject -Depth 100
    } else { $storageFileContent = ConvertTo-Json-Posh20 $storageFileObject }
  
    $storageFileContent | Set-Content $storageFilePath
}
