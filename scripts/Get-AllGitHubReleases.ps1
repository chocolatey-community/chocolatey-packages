function Get-AllGitHubReleases {
  <#
    .SYNOPSIS
      Get all of the releases of the given GitHub repository (may be limited by GitHub themself).

    .EXAMPLE
      Get-AllGitHubReleases etcd-io etcd
  #>
  [CmdletBinding()]
  param(
    # Repository owner
    [Parameter(Mandatory, Position = 0)]
    [string]$Owner,

    # Repository name
    [Parameter(Mandatory, Position = 1)]
    [string]$Name,

    # GitHub token, used to reduce rate-limiting or access private repositories (needs repo scope)
    [string]$Token = "$($env:github_api_key)"
  )
  end {
    $apiUrl = "https://api.github.com/repos/$Owner/$Name/releases"

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
