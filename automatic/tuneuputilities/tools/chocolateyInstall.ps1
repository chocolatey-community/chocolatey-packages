$packageName = '{{PackageName}}'
$installerType = 'EXE'
$LCID = (Get-Culture).LCID
$silentArgs = ''
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

##Spanish
if(($LCID -eq "3082") -or ($LCID -eq "1034")){
$url = 'http://download.tune-up.com/TUU2014/1004719/TuneUpUtilities2014_es-ES.exe'
}

##Spanish Mexican
elseif($LCID -eq "2058"){
$url = 'http://download.tune-up.com/TUU2014/1004720/TuneUpUtilities2014_es-MX.exe'
}

##French
elseif($LCID -eq "1036"){
$url = 'http://download.tuneup.fr/TUU2014/1004721/TuneUpUtilities2014_fr-FR.exe'
}

##German
elseif($LCID -eq "1031"){
$url = 'http://download.tuneup.de/TUU2014/1004717/TuneUpUtilities2014_de-DE.exe'
}

##Italian - it-IT
#elseif($LCID -eq "1040"){
#$url = 'http://download.tuneup.de/TUU2014/10047XX/TuneUpUtilities2014_it-IT.exe'
#}

##Portuguese
elseif($LCID -eq "2070"){
$url = 'http://download.tune-up.com/TUU2014/1004723/TuneUpUtilities2014_pt-PT.exe'
}

##Portuguese Brazilian
elseif($LCID -eq "1046"){
$url = 'http://download.tune-up.com/TUU2014/1004722/TuneUpUtilities2014_pt-BR.exe'
}

##Dutch - nl-NL
#elseif($LCID -eq "1043"){
#$url = 'http://download.tuneup.de/TUU2014/10047XX/TuneUpUtilities2014_nl-NL.exe'
#}

##Russian - ru-RU
#elseif($LCID -eq "1049"){
#$url = 'http://download.tuneup.de/TUU2014/10047XX/TuneUpUtilities2014_ru-RU.exe'
#}

##Czech - cs-CZ
#elseif($LCID -eq "1029"){
#$url = 'http://download.tuneup.de/TUU2014/10047XX/TuneUpUtilities2014_cs-CZ.exe'
#}

##Polish - pl-PL
#elseif($LCID -eq "1045"){
#$url = 'http://download.tuneup.de/TUU2014/10047XX/TuneUpUtilities2014_pl-PL.exe'
#}

##Korean - kr-KR
#elseif($LCID -eq "1042"){
#$url = 'http://download.tuneup.de/TUU2014/10047XX/TuneUpUtilities2014_kr-KR.exe'
#}

##Japanese - jp-JP
#elseif($LCID -eq "1041"){
#$url = 'http://download.tuneup.de/TUU2014/10047XX/TuneUpUtilities2014_jp-JP.exe'
#}

##Chinese - zh-CN zh-SG zh-TW zh-HK zh-MO
#elseif(($LCID -eq "2052") -or ($LCID -eq "4100") -or ($LCID -eq "1028") -or ($LCID -eq "3076") -or ($LCID -eq "5124")){
#$url = 'http://download.tuneup.de/TUU2014/10047XX/TuneUpUtilities2014_zh-CN.exe'
#}

##Britain English
elseif($LCID -eq "2057"){
$url = 'http://download.tune-up.com/TUU2014/1004718/TuneUpUtilities2014_en-GB.exe'
}

##United States English
else{
$url = 'http://download.tune-up.com/TUU2014/1004716/TuneUpUtilities2014_en-US.exe'
}

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes

#LCID table
#http://msdn.microsoft.com/es-es/goglobal/bb964664.aspx