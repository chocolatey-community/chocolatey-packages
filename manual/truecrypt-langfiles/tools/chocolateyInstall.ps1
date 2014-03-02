try {

  $name = "truecrypt-langfiles"
  $scriptPath = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
  $fileFullPath = "$scriptPath\truecrypt_7.1a_langfiles.zip"
  
  $destination = "$env:ProgramFiles\TrueCrypt"  
  Get-ChocolateyUnzip $fileFullPath $destination

    Write-ChocolateySuccess $name
} catch {
  Write-ChocolateyFailure $name $($_.Exception.Message)
  throw
}