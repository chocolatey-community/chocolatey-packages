# Export all the cmdlets that are meant to be used
# within a Chocolatey AU update script here.

# We just specify the functions we want to export
# but the file containing the functions is expected
# to be named using the same name.
$funcs = @(
  'Add-Dependency'
  'Clear-DependenciesList'
  'Get-AllGitHubReleases'
  'Get-GitHubRelease'
  'Get-GitHubRepositoryFileContent'
  'Set-DescriptionFromReadme'
  'Update-ChangelogVersion'
  'Update-OnETagChanged'
)

$funcs | % {
  if (Test-Path "$PSScriptRoot\$_.ps1") {
    . "$PSScriptRoot\$_.ps1"
    if (Get-Command $_ -ea 0) {
      Export-ModuleMember -Function $_
    }
  }
}
