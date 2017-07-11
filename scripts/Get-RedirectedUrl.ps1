
function Get-RedirectedUrl() {
  param(
    [Parameter(Mandatory = $true)]
    [uri]$url
  )

  $req = [System.Net.WebRequest]::CreateDefault($url)
  $resp = $req.GetResponse()

  if ($resp -and $resp.ResponseUri -ne $url) {
    Write-Host "Found redirected url '$($resp.ResponseUri)"
    $result = $resp.ResponseUri
  } else {
    Write-Warning "No redirected url was found, returning given url."
    $result = $resp.ResponseUri
  }

  $resp.Dispose()
  return $result
}
