# Export functions that start with capital letter, others are private
# Include file names that start with capital letters, ignore others
$ScriptRoot = Split-Path $MyInvocation.MyCommand.Definition

$pre = ls Function:\*
ls "$ScriptRoot\*.ps1" | ? { $_.Name -cmatch '^[A-Z]+' } | % { . $_  }
$post = ls Function:\*
$funcs = compare $pre $post | select -Expand InputObject | select -Expand Name
$funcs | ? { $_ -cmatch '^[A-Z]+'} | % { Export-ModuleMember -Function $_ }

#Export-ModuleMember -Alias *
