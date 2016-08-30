$locale = (Get-Culture).EnglishName
$language = $locale -replace ' \(.+','' # Remove country name
$regDir = 'HKCU:\Software\Quizo\QTTabBar'
if (!(Test-Path $regDir)) {New-Item -Path $regDir -ItemType directory -Force}
$scriptPath = $(Split-Path -parent $MyInvocation.MyCommand.Definition)
$fileFullPath = "$scriptPath\Lng_QTTabBar_$language.xml"
if (Test-Path $fileFullPath) {
  Set-ItemProperty -Name LanguageFile -Path HKCU:\Software\Quizo\QTTabBar -Value $fileFullPath -Force
} else {
  Write-Output 'No language file available for your language.'
}
