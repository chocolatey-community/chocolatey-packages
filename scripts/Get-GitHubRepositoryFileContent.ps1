function Get-GitHubRepositoryFileContent {
  <#
    .Synopsis
      Returns the content of a given file in a repository via the REST API

    .Link
      https://docs.github.com/en/rest/repos/contents?apiVersion=2022-11-28

    .Example
      Get-GitHubRepositoryFileContent Kubernetes Kubernetes CHANGELOG/README.md

    .Notes
      Seems to be a lot faster than IWRing raw files.
  #>
  [CmdletBinding()]
  param(
    # The owner of the repository
    [Parameter(Mandatory)]
    [string]$Owner,

    # The repository containing the file
    [Parameter(Mandatory)]
    [string]$Repository,

    # The path to the file within the repository
    [Parameter(ValueFromPipeline)]
    [string]$Path,

    # The branch, tag, or reference to get the content from. Defaults to the repository's default branch.
    [Alias('ref', 'Tag')]
    [string]$Branch,

    # Returns the raw response
    [switch]$Raw
  )
  process {
    $restArgs = @{
      Uri     = "https://api.github.com/repos/$($Owner)/$($Repository)/contents/$($Path.TrimStart('/'))"
      Headers = @{
        'Accept'               = 'application/vnd.github+json'
        'X-GitHub-Api-Version' = '2022-11-28'
      }
    }
    if ($Branch) {
      $restArgs.Body = @{ref = $Branch}
    }
    if ($env:github_api_key) {
      $restArgs.Headers.Authorization = "Bearer $($env:github_api_key)"
    }

    $Result = Invoke-RestMethod @restArgs -UseBasicParsing

    if ($Raw) {
      $Result
    } elseif ($Result.encoding -eq 'base64') {
      # Assumption made about the file being UTF8, here
      [System.Text.Encoding]::UTF8.GetString(
        [System.Convert]::FromBase64String($Result.content)
      )
    } else {
      Write-Warning "$($Path) encoded as '$($Result.encoding)'"
      $Result.content
    }
  }
}
