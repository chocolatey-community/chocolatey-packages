function Get-InstallTasks([HashTable]$pp) {
  $parameters = @{
    "DesktopIcon"      = @{ Task = "!desktopicon"; Output = "Enabling Desktop Icon" }
    "QuickLaunchIcon"  = @{ Task = "!quicklaunchicon"; Output = "Enabling Quick Launch Icon" }
  }

  $tasks = @()

  foreach ($param in $parameters.Keys) {
    if ($pp[$param]) {
      if ($parameters[$param].Task.StartsWith('!')) {
        $parameters[$param].Task = $parameters[$param].Task.TrimStart('!')
      } else {
        $parameters[$param].Task = '!' + $parameters[$param].Task
      }
      Write-Host $parameters[$param].Output
    }

    $tasks += @($parameters[$param].Task)
  }

  ' /TASKS="{0}"' -f ($tasks -join ',')
}
