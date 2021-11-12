# NOTE: No documentation will be written for this script.
# This is only a temporary script until a generic version
# have been added to the wormies-au-helpers powershell package

function Update-OnETagChanged() {
  param(
    [uri]$execUrl,
    [string]$saveFile = ".\info",
    [scriptblock]$OnETagChanged,
    [scriptblock]$OnUpdated,
	  [string]$kind,
	  [switch]$boule
  )

  $request = [System.Net.WebRequest]::CreateDefault($execUrl)

  try {
    $response = $request.GetResponse()
    $etag = $response.Headers.Get("ETag")
  }
  finally {
    $response.Dispose()
    $response = $null
  }

  $saveResult = $false
  if (!(Test-Path $saveFile) -or ($global:au_Force -eq $true)) {
    $result = . $OnETagChanged
    $saveResult = $true
  }
  else {
	  if ($kind) {
		$existingInfo = ( Get-Content $saveFile -Raw | ConvertFrom-Json )
		if ($existingInfo.$kind -ne $etag) {
		  $result = . $OnETagChanged
		  $saveResult = $true
		}
		else {
		  $result = . $OnUpdated
		  $result["ETAG"] = $existingInfo.$kind
		  $saveResult = $false
		}
	  }
	  else {
	    $existingInfo = (Get-Content $saveFile -Encoding UTF8 -TotalCount 1) -split '\|'
		if ($existingInfo[0] -ne $etag) {
		  $result = . $OnETagChanged
		  $saveResult = $true
		}
		else {
		  $result = . $OnUpdated
		  $result["Version"] = $existingInfo[1]
		  $result["ETAG"] = $existingInfo[0]
		  $saveResult = $false
		}
	  }	
  }

  if (($saveResult) -and ($kind)) {
    # etag needs to be modified before updating info
    $etag = $etag -replace('"', "'")
	foreach($line in $existingInfo){
		$existingInfo.$kind = $line.$kind -replace("([W]\/)?('((\d+)?(\w)?(\-)?)+')" , $etag)
	}
    $result = $etag
    $existingInfo | ConvertTo-Json -depth 32 | Set-Content $saveFile
  }
  else {
    $result["ETAG"] = $etag
    "$($result["ETAG"])|$($result["Version"])" | Out-File $saveFile -Encoding utf8 -NoNewline
  }
  if ($boule) {
	return $saveResult
  }
  else {
	return $result
  }
}
