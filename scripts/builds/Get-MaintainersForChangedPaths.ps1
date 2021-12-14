param(
  # The current commit or the commit to check the difference to
  [string] $currentCommit = $null,
  # The commit to check the difference from, usually the master branch
  [string] $parentCommit = 'master'
)

function Get-MaintainersForChangedPaths {
  param(
    [string] $currentCommit,
    [Parameter(Mandatory)]
    [string] $parentCommit
  )

  $arguments = @(
    "diff"
    "$parentCommit..$currentCommit"
    "--name-only"
  )

  $re = "(?mi)^(?<pkg_match>\*\/[^\s]+)\s+@(?<maintainers>.+)$"

  $codeOwners = Get-Content "$PSScriptRoot\..\..\.github\CODEOWNERS" -Encoding UTF8 | Where-Object {
    $_ -match "$re"
  } | ForEach-Object {
    @{ 
      Pkg_Match   = $Matches["pkg_match"]
      Maintainers = $Matches["maintainers"] -replace '@' -split ' '
    }
  }

  Write-Host "Calling git diff $arguments"
  $uncoveredPaths = [System.Collections.Generic.List[string]]::new()
  [array]$packageOwners = git @arguments | Where-Object {
    $_ -match "^(automatic|manual|extensions)"
  } | ForEach-Object {
    $path = $_
    $owners = $codeOwners | Where-Object { $path -like $_.Pkg_Match } | Select-Object -First 1

    if ($owners) {
      $owners.Maintainers
    }
    else {
      $null = $uncoveredPaths.Add($path)
    }
  } | Where-Object { $_ } | Select-Object -Unique

  @{
    Maintainers = $packageOwners
    Uncovered   = $uncoveredPaths
  }
}

Get-MaintainersForChangedPaths @PSBoundParameters