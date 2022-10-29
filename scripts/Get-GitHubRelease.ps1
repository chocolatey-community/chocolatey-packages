function Get-GitHubRelease {
  <#
    .SYNOPSIS
      Gets the latest or a specific release of a given GitHub repository

    .EXAMPLE
      Get-GitHubRelease cloudflare cloudflared
  #>
  [CmdletBinding()]
  param(
    # Repository owner
    [Parameter(Mandatory, Position = 0)]
    [string]$Owner,

    # Repository name
    [Parameter(Mandatory, Position = 1)]
    [string]$Name,

    # The Name of the tag to get the relase for. Will default to the latest release.
    [string]$TagName,

    # GitHub token, used to reduce rate-limiting or access private repositories (needs repo scope)
    [string]$Token = "$($env:github_api_key)"
  )
  end {
    $apiUrl = "https://api.github.com/repos/$Owner/$Name/releases/latest"

    if ($TagName) {
      $apiUrl = "https://api.github.com/repos/$Owner/$Name/releases/tags/$TagName"
    }

    $Request = @{
      Uri = $apiUrl
    }

    if (-not [string]::IsNullOrEmpty($Token)) {
      $Request.Headers = @{
        Accept        = 'application/vnd.github+json'
        Authorization = "Bearer $($Token)"
      }
    }

    Invoke-RestMethod @Request
  }
}
