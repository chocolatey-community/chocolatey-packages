<#
.SYNOPSIS
  Get a 'free' drive letter

.DESCRIPTION
  Get a not yet in-use drive letter that can be used for mounting

.EXAMPLE
  Get-AvailableDriveLetter

.EXAMPLE
  Get-AvailableDriveLetter 'X'
  (do not return X, even if it'd be the next choice)

.INPUTS
  specific drive letter 

.OUTPUTS
  System.String (single drive-letter character)

.LINK
  http://stackoverflow.com/questions/12488030/getting-a-free-drive-letter/29373301#29373301
#>
function Get-AvailableDriveLetter {
  param ([char]$ExcludedLetter)

  $Letter = [int][char]'C'
  $i = @()
  
  #getting all the used Drive letters reported by the Operating System
  $(Get-PSDrive -PSProvider filesystem) | %{$i += $_.name}
  
  #Adding the excluded letter
  $i+=$ExcludedLetter
  
  while($i -contains $([char]$Letter)){$Letter++}

  Return $([char]$Letter)
}

