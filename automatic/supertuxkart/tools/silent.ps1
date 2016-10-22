# This script closes the appearing windows of the
# VC++ and the OpenAL installer during the installation
# of this package, thus making the installation silent.
#
# Every 0.5 seconds it checks if the process exists
# and closes it if applicable.

function Close-ProcessByName ($processName) {
  $process = $false
  while (!$process) {
    Start-Sleep -Milliseconds 500
    $process = Get-Process | Where-Object {
      $_.ProcessName -eq $processName
    }

    if ($process) {
      Stop-Process -ProcessName $processName
    }
  }
}

Close-ProcessByName 'vcredist_x86'
Close-ProcessByName 'oalinst'
