param(
  [Parameter(Mandatory)]
  [string]$submittedUser,
  # The current commit or the commit to check the difference to
  [string] $currentCommit = $null,
  # The commit to check the difference from, usually the master branch
  [string] $parentCommit = 'master',

  [string]$githubToken = $env:GITHUB_TOKEN,
  [string]$pullRequestId = $null
)

<#
.SYNOPSIS
    Formats the specified url using the specified parameters hashtable
.PARAMETER url
    The url format to use when formatting the result url
.PARAMETER parameters
    The parameters to use when replacing tokens in the url.
.OUTPUTS
    The formatted Url
#>
function Format-Url() {
  param(
      [Parameter(Mandatory = $true)]
      [string]$url,
      [hashtable]$parameters = @{ }
  )

  $newUrl = ""

  $insideQuote = $false
  $lastIndex = 0
  $char = ''
  $checkComma = $true
  while ($lastIndex -ge 0) {
      if (!$insideQuote -and ($i = $url.IndexOf('{', $lastIndex)) -gt $lastIndex) {
          $newUrl += $url.Substring($lastIndex, $i - $lastIndex)
          $insideQuote = $true
          $c = $url[$i + 1]
          if ($c -eq '?' -or $c -eq '+' -or $c -eq '/' -or $c -eq '&') {
              $char = $c
              $i++
          }
          else { $char = '' }
          $lastIndex = $i + 1
          $checkComma = $true
      }
      elseif ($insideQuote) {
          $name = ''
          if ($checkComma -and ($i = $url.IndexOf(',', $lastIndex)) -ge $lastIndex) {
              $name = $url.Substring($lastIndex, $i - $lastIndex)
          }
          elseif (($i = $url.IndexOf('}', $lastIndex)) -ge $lastIndex) {
              $name = $url.Substring($lastIndex, $i - $lastIndex)
              $insideQuote = $false
          }

          if ($name -notmatch "^[a-z0-9_]+$") {
              $checkComma = $false
          }
          else {
              if ($parameters.ContainsKey($name)) {
                  $newUrl += $char + $parameters[$name]
                  if ($char -eq '?') { $char = '&' }
              }

              if ($i -eq -1) { break; }
              $lastIndex = $i + 1
          }
      }
      else {
          break
      }
  }

  if ($lastIndex -ge 0) {
      $newUrl += $url.Substring($lastIndex)
  }

  return $newUrl
}

<#
.SYNOPSIS
    Invokes a single call to the github api using the specified url format.
.DESCRIPTION
    Invokes a single call to the github api using the specified url format.
    This function also allows the url to be formatted with the specified parameters.
    This function also makes sure that the content (if specified) is correctly serialized
    to json using Newtonsoft.
.PARAMETER url
    The url format to use when calling github.
.PARAMETER parameters
    The parameters to use when formatting the url.
.PARAMETER method
    The method to use when calling the githb api (Typically, GET, POST, PATCH and DELETE)
    (Defaults to Get)
.PARAMETER content
    The content to submit to the github api (like a comment for instance)
.PARAMETER githubToken
    The token to use for authenticated requests (Recommended to be used)
    (Defaults to $env:GITHUB_TOKEN)
.OUTPUTS
    The result of the request.
#>
function Invoke-Api() {
  [OutputType([hashtable])]
  param(
      [Parameter(Mandatory = $true)]
      [string]$url,
      [hashtable]$parameters = @{},
      [string]$method = "Get",
      [hashtable]$content = $null,
      [string]$githubToken = $null
  )

  $headers = @{}
  if ($githubToken) {
      Write-Verbose "Using Authenticated github reques"
      $headers["Authorization"] = "token " + $githubToken
  }

  $formattedUrl = Format-Url $url $parameters

  $arguments = @{
      Uri             = $formattedUrl
      Method          = $method
      Headers         = $headers
      UseBasicParsing = $true
  }

  if ($content) {
      # Workaround since the API don't like a line to end with a space + colon (json parsing error on github)
      $json = [Newtonsoft.Json.JsonConvert]::SerializeObject($content) -replace "\s+:(\\[rn]|$)", ":`${1}"
      $arguments["Body"] = $json
      $arguments["ContentType"] = "application/json"
  }

  return Invoke-RestMethod @arguments
}

$details = . "$PSScriptRoot\Get-MaintainersForChangedPaths.ps1" `
  -currentCommit $currentCommit `
  -parentCommit $parentCommit

$successMessages = [System.Collections.Generic.List[string]]::new()
$failureMessages = [System.Collections.Generic.List[string]]::new()
$inconclusiveMessages = [System.Collections.Generic.List[string]]::new()

if ($details.Maintainers.Contains($submittedUser)) {
  $successMessages.Add("User is listed as the maintainer of one or more of the changed Package Paths")
}
else {
  $inconclusiveMessages.Add("User is not listed as a maintainer for any changed Package Path")
}

if ($details.Uncovered.Count -eq 0) {
  $successMessages.Add("All changed package paths have a maintainer associated.")
} else {
  $details.Uncovered | % {
    $failureMessages.Add("The path '$_' do not have a maintainer associated with it. Update CODEOWNERS file to include a maintainer for the package path.")
  }
}

$message = "Pull request have been processed and we have acquired the following results!`n`n"

$successMark = if ($githubToken) { ":white_check_mark:"} else { "✅" }
$inconclusiveMark = if ($githubToken) { ":warning:" } else { "⚠️" }
$errorMark = if ($githubToken) { ":x:" } else { "❌" }

$successMessages | % {
  $message = "${message}- $successMark $_`n"
}

$inconclusiveMessages | % {
  $message = "${message}- $inconclusiveMark $_`n"
}

$failureMessages | % {
  $message = "${message}- $errorMark $_`n"
}

if ($githubToken -and $pullRequestId) {

}

$message