Function Get-ExplorerProcessCount
{
  $process = Get-Process explorer -ErrorAction SilentlyContinue
  $processCount = ($process | Measure-Object).Count
  return $processCount
}
