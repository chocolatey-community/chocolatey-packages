$packageName = '{{PackageName}}'
$installerType = 'EXE'
$LCID = (Get-Culture).LCID
$silentArgs = ''
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

##Spanish
if(($LCID -eq "3082") -or ($LCID -eq "1034")){
$url = 'http://g.live.com/1rewlive5-web/es/wlsetup-web.exe'
}

##French
elseif($LCID -eq "1036"){
$url = 'http://g.live.com/1rewlive5-web/fr/wlsetup-web.exe'
}

##German
elseif($LCID -eq "1031"){
$url = 'http://g.live.com/1rewlive5-web/de/wlsetup-web.exe'
}

##Italian
elseif($LCID -eq "1040"){
$url = 'http://g.live.com/1rewlive5-web/it/wlsetup-web.exe'
}

##Portuguese
elseif($LCID -eq "2070"){
$url = 'http://g.live.com/1rewlive5-web/pt-pt/wlsetup-web.exe'
}

##Portuguese Brazilian
elseif($LCID -eq "1046"){
$url = 'http://g.live.com/1rewlive5-web/pt-br/wlsetup-web.exe'
}

##Catalan
elseif($LCID -eq "1027"){
$url = 'http://g.live.com/1rewlive5-web/ca/wlsetup-web.exe'
}

##Dutch
elseif($LCID -eq "1043"){
$url = 'http://g.live.com/1rewlive5-web/nl/wlsetup-web.exe'
}

##Danish
elseif($LCID -eq "1030"){
$url = 'http://g.live.com/1rewlive5-web/da/wlsetup-web.exe'
}

##Britain English
elseif($LCID -eq "2057"){
$url = 'http://g.live.com/1rewlive5-web/en-gb/wlsetup-web.exe'
}

##United States English
else{
$url = 'http://g.live.com/1rewlive5-web/en/wlsetup-web.exe'
}

Install-ChocolateyPackage "$packageName" "$installerType" "$silentArgs" "$url"  -validExitCodes $validExitCodes

#LCID table
#http://msdn.microsoft.com/es-es/goglobal/bb964664.aspx