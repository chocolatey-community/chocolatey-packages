$packageName = '{{PackageName}}'
$installerType = 'EXE'
$LCID = (Get-Culture).LCID
$silentArgs = ''
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx
#OK
##Spanish - Spain (Modern Sort) - Spain (Traditional Sort) (es-es)
if(($LCID -eq "3082") -or ($LCID -eq "1034")){
$url = 'http://products.kaspersky-labs.com/spanish/homeuser/kav2015/kav15.0.1.415es-es.exe'
}
#OK
##Spanish - Mexico (es-mx)
elseif($LCID -eq "2058"){
$url = 'http://products.kaspersky-labs.com/spanish/homeuser/kav2015/kav15.0.0.463es-mx_6313.exe'
}
#OK
##Dutch
##Dutch - Netherlands		1043
##Dutch - Belgium			2067
elseif(($LCID -eq "1043") -or ($LCID -eq "2067")){
$url = 'http://trial.kaspersky-labs.com/trial/registered/o1oldvwlo1jq21578qsk/kav15.0.0.463nl-nl_fr-be.exe'
}
#OK
##French
elseif($LCID -eq "1036"){
$url = 'http://products.kaspersky-labs.com/french/homeuser/kav2015/kav15.0.1.415fr_6869.exe'
}
#OK
##German
elseif($LCID -eq "1031"){
$url = 'http://products.kaspersky-labs.com/german/homeuser/kav2015/kav15.0.1.415de-de.exe'
}
#OK
##Italian
elseif($LCID -eq "1040"){
$url = 'http://products.kaspersky-labs.com/italian/homeuser/kav2015/kav15.0.1.415it-it.exe'
}
#OK
##Portuguese - Brazil (pt-br)
elseif($LCID -eq "1046"){
$url = 'http://products.kaspersky-labs.com/portuguese/homeuser/kav2015/kav15.0.0.463pt-br_6306.exe'
}
#OK
##Portuguese - Portugal (pt-pt)
##For now Portuguese - Brazil (pt-br) is used
elseif($LCID -eq "2070"){
$url = 'http://products.kaspersky-labs.com/portuguese/homeuser/kav2015/kav15.0.1.415pt-pt.exe'
}

##Portuguese - South Africa (pt-za) ?
#elseif($LCID -eq "XXXX"){
#$url = 'http://products.kaspersky-labs.com/portuguese/homeuser/kav2014/kav14.0.0.4651pt-za.exe'
#}
#OK
##Russian - Russian (ru-ru) - Russian-Moldava (ru-mo)
elseif(($LCID -eq "1049") -or ($LCID -eq "2073")){
$url = 'http://products.kaspersky-labs.com/russian/homeuser/kav2015/kav15.0.1.415ru-ru.exe'
}
#OK
##English - United Kingdom (en-gb)
##For now English - US (en-us) is used
elseif($LCID -eq "2057"){
$url = 'http://products.kaspersky-labs.com/english/homeuser/kav2015/kav15.0.1.415en-gb.exe'
}
#OK
##English - US (en-us)
else{
$url = 'http://products.kaspersky-labs.com/english/homeuser/kav2015/kav15.0.1.415en_6868.exe'
}

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes

#LCID table
#http://msdn.microsoft.com/es-es/goglobal/bb964664.aspx

#downloads location
#http://products.kaspersky-labs.com/