function Get-LatestGitHubRelease {
  <#
      .SYNOPSIS
          Gets the latest release of a given GitHub repository

      .EXAMPLE
          Get-LatestGitHubRelease cloudflare cloudflared
  #>
  [CmdletBinding()]
  param(
      # Repository owner
      [Parameter(Mandatory, Position=0)]
      [string]$Owner,

      # Repository name
      [Parameter(Mandatory, Position=1)]
      [string]$Name,

      # GitHub token, used to reduce rate-limiting or access private repositories (needs repo scope)
      [string]$Token = "$($env:github_api_key)"
  )
  end {
      $Request = @{
          Uri = "https://api.github.com/repos/$Owner/$Name/releases/latest"
      }

      if (-not [string]::IsNullOrEmpty($Token)) {
        $Request.Headers = @{
            Authorization = "Bearer $($Token)"
        }
      }

      Invoke-RestMethod @Request
  }
}