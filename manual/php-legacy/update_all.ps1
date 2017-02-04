# Convenience script to update all packages
# They will still need to be manually pushed
# with [PUSH php_5.3.x php_5.4.x php_5.5.x]

param(
  [switch]$CreateCommitMessage
)

$global:au_Force = $true

$folders = Get-ChildItem "$PSScriptRoot" -Directory | ? { Test-Path "$_\update.ps1"}

foreach ($folder in $folders) {
  try {
    pushd $folder.FullName
    . ".\update.ps1"
  } finally {
    popd
  }
}

$global:au_Force = $null

git add "$PSScriptRoot"
if ($CreateCommitMessage) {
  git commit -m "[PUSH $(($folders | % Name) -join ' ')]"
}
