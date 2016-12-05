$packageName = '{{PackageName}}'
$installerType = 'EXE'
$url = '{{DownloadUrl}}'
$silentArgs = '/S'
$LCID = (Get-Culture).LCID
$url_version_dot= '{{PackageVersion}}'
$url_version = (Split-Path $url_version_dot -leaf).ToString().Replace(".", "")
$processor = Get-WmiObject Win32_Processor
$is64bit = $processor.AddressWidth -eq 64
$validExitCodes = @(0) #please insert other valid exit codes here, exit codes for ms http://msdn.microsoft.com/en-us/library/aa368542(VS.85).aspx

try {
 	 
	if ($is64bit) {
 
		###################################################### 64 bits downloads #################################################################  

		##Arabic
		##Arabic - Saudi Arabia  1025
		##Arabic - Algeria	5121
		##Arabic - Bahrain	15361
		##Arabic - Egypt	3073
		##Arabic - Iraq		2049
		##Arabic - Jordan	11265
		##Arabic - Kuwait	13313
		##Arabic - Lebanon	12289
		##Arabic - Libya	4097
		##Arabic - Morocco	6145
		##Arabic - Oman		8193
		##Arabic - Qatar	16385
		##Arabic - Syria	10241
		##Arabic - Tunisia	7169
		##Arabic - U.A.E.	14337
		##Arabic - Yemen	9217
		if(($LCID -eq "1025") -or ($LCID -eq "5121") -or ($LCID -eq "15361") -or ($LCID -eq "3073") -or ($LCID -eq "2049") -or ($LCID -eq "11265") -or ($LCID -eq "13313") -or ($LCID -eq "12289") -or ($LCID -eq "4097") -or ($LCID -eq "6145") -or ($LCID -eq "8193") -or ($LCID -eq "16385") -or ($LCID -eq "10241") -or ($LCID -eq "7169") -or ($LCID -eq "14337") -or ($LCID -eq "9271")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'ar.exe'
		}

		##Armenian
		##Armenian   1067
		elseif($LCID -eq "1067"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'am.exe'
		}

		##Azerbaijani
		##AAzeri (Cyrillic)   2092
		##AAzeri (Latin)      1068
		elseif(($LCID -eq "2092") -or ($LCID -eq "1068")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'az.exe'
		}

		##Belarusian
		##Belarusian   1059
		elseif($LCID -eq "1059"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'by.exe'
		}

		##Bulgarian
		##Bulgarian   1026
		elseif($LCID -eq "1026"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'bg.exe'
		}

		##Catalan
		##Catalan   1027
		elseif($LCID -eq "1027"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'by.exe'
		}

		##Chinese Simplified
		##Chinese - People's Republic of China 	 2052
		##Chinese - Singapore					 4100
		##Chinese - Hong Kong SAR	             3076
		##Chinese - Macao SAR					 5124
		#elseif(($LCID -eq "2052") -or ($LCID -eq "4100") -or ($LCID -eq "3076") -or ($LCID -eq "5124")){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-510sc.exe'
		#}

		##Chinese Traditional
		##Chinese - Taiwan					1028
		elseif($LCID -eq "1028"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'tc.exe'
		}

		##Croatian
		##Croatian				          1050
		##Croatian (Bosnia/Herzegovina)   4122
		elseif(($LCID -eq "1050") -or ($LCID -eq "4122")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'cro.exe'
		}

		##Czech
		##Czech   1029
		#elseif($LCID -eq "1029"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-510cz.exe'
		#}

		##Danish
		##Danish   1030
		elseif($LCID -eq "1030"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'dk.exe'
		}

		##Dutch
		##Dutch - Netherlands		1043
		##Dutch - Belgium			2067
		elseif(($LCID -eq "1043") -or ($LCID -eq "2067")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'nl.exe'
		}

		##Estonian
		##Estonian			1061
		elseif($LCID -eq "1061"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'est.exe'
		}

		##Finnish
		##Finnish			1035
		elseif($LCID -eq "1035"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'fi.exe'
		}

		##French
		##French			1036
		elseif($LCID -eq "1036"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'fr.exe'
		}

		##Galician
		##Galician			1110
		elseif($LCID -eq "1110"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'gl.exe'
		}

		##Georgian
		##Georgian			1079
		#elseif($LCID -eq "1079"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-501ge.exe'
		#}

		##German
		##German			1031
		elseif($LCID -eq "1031"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'d.exe'
		}

		##Greek
		##Greek				1032
		#elseif($LCID -eq "1032"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-510el.exe'
		#}

		##Hebrew
		##Hebrew			1037
		elseif($LCID -eq "1037"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'he.exe'
		}

		##Hungarian
		##Hungarian			1038
		elseif($LCID -eq "1038"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'hu.exe'
		}

		##Indonesian
		##Indonesian		1057
		elseif($LCID -eq "1057"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'id.exe'
		}

		##Italian
		##Italian - Italy			1040
		##Italian - Switzerland		2064
		#elseif(($LCID -eq "1040") -or ($LCID -eq "2064")){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-510it.exe'
		#}

		##Japanese
		##Japanese		1041
		elseif($LCID -eq "1041"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'j.exe'
		}

		##Korean
		##Korean		1042
		elseif($LCID -eq "1042"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'kr.exe'
		}

		##Lithuanian
		##Lithuanian	1063
		elseif($LCID -eq "1063"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'lt.exe'
		}

		##Macedonian
		##Macedonian											0047
		##Macedonian (Former Yugoslav Republic of Macedonia)	1071
		elseif(($LCID -eq "0047") -or ($LCID -eq "1071")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'mk.exe'
		}

		##Norwegian
		##Norwegian (Bokmål)		1044
		##Norwegian (Nynorsk)		2068
		elseif(($LCID -eq "1044") -or ($LCID -eq "2068")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'no.exe'
		}

		##Persian
		##Persian		0041
		##Persian Iran	1065
		elseif(($LCID -eq "0041") -or ($LCID -eq "1065")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'prs.exe'
		}

		##Polish
		##Polish		1045
		elseif($LCID -eq "1045"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'pl.exe'
		}

		##Portuguese - Portugal
		##Portuguese - Portugal 2070  (pt-pt)
		elseif($LCID -eq "2070"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'pt.exe'
		}

		##Portuguese - Brazil
		##Portuguese - Brazil  1046   (pt-br)
		elseif($LCID -eq "1046"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'br.exe'
		}

		##Romanian
		##Romanian			1048
		##Romanian Moldava  2072
		elseif(($LCID -eq "1048") -or ($LCID -eq "2072")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'ro.exe'
		}

		##Russian
		##Russian (ru-ru)			1049    
		##Russian-Moldava (ru-mo)	2073
		elseif(($LCID -eq "1049") -or ($LCID -eq "2073")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'ru.exe'
		}

		##Serbian Cyrillic
		##Serbian Cyrillic	3098
		elseif($LCID -eq "3098"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'srbcyr.exe'
		}

		##Serbian Latin
		##Serbian Latin		2074
		elseif($LCID -eq "2074"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'srblat.exe'
		}

		##Sinhala
		##Sinhala			1115
		#elseif($LCID -eq "1115"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-501si.exe'
		#}

		##Slovak
		##Slovak			1051
		#elseif($LCID -eq "1051"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-510sk.exe'
		#}

		##Slovenian		
		##Slovenian			1060
		#elseif($LCID -eq "1060"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-510slv.exe'
		#}

		##Spanish
		##Spanish - Spain (Modern Sort)			3082
		##Spanish - Spain (Traditional Sort)    1034   (es-es)
		##Spanish - Argentina   				11274
		##Spanish - Bolivia   					16394
		##Spanish - Chile   					13322
		##Spanish - Colombia   					9226
		##Spanish - Costa Rica  			 	5130
		##Spanish - Dominican Republic  	 	7178
		##Spanish - Ecuador  				 	12298
		##Spanish - El Salvador  			 	17418
		##Spanish - Guatemala  				 	4106
		##Spanish - Honduras   					18442
		##Spanish - Latin America 				22538
		##Spanish - Mexico				   		2058
		##Spanish - Nicaragua   				19466
		##Spanish - Panama   					6154
		##Spanish - Paraguay   					15370
		##Spanish - Peru   						10250
		##Spanish - Puerto Rico 		  		20490
		##Spanish - United States 		  		21514
		##Spanish - Uruguay 			  		14346
		##Spanish - Venezuela  			 		8202
		elseif(($LCID -eq "3082") -or ($LCID -eq "1034") -or ($LCID -eq "11274") -or ($LCID -eq "16394") -or ($LCID -eq "13322") -or ($LCID -eq "9226") -or ($LCID -eq "5130") -or ($LCID -eq "7178") -or ($LCID -eq "12298") -or ($LCID -eq "17418") -or ($LCID -eq "4106") -or ($LCID -eq "18442") -or ($LCID -eq "22538") -or ($LCID -eq "2058") -or ($LCID -eq "19466") -or ($LCID -eq "6154") -or ($LCID -eq "15370") -or ($LCID -eq "10250") -or ($LCID -eq "20490") -or ($LCID -eq "21514") -or ($LCID -eq "14346") -or ($LCID -eq "8202")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'es.exe'
		}

		##Swedish
		##Swedish					1053
		##Swedish - Finland			2077
		elseif(($LCID -eq "1053") -or ($LCID -eq "2077")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'sw.exe'
		}

		##Thai
		##Thai						1054
		#elseif($LCID -eq "1054"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-510th.exe'
		#}

		##Turkish
		##Turkish					1055
		#elseif($LCID -eq "1055"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-510tr.exe'
		#}

		##Turkmen
		##Turkmen					1090
		#elseif($LCID -eq "1090"){
			#$url = 'http://www.rarlab.com/rar/winrar-x64-500tkm.exe'
		#}

		##Ukrainian
		##Ukrainian					1058
		elseif($LCID -eq "1058"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'ukr.exe'
		}

		##Uzbek
		##Uzbek (Cyrillic)			2115
		##Uzbek (Latin)				1091
		elseif(($LCID -eq "2115") -or ($LCID -eq "1091")){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'uz.exe'
		}

		#Valencian
		#Valencian			2051
		elseif($LCID -eq "2051"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'va.exe'
		}

		##Vietnamese
		##Vietnamese		1066
		elseif($LCID -eq "1066"){
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'vn.exe'
		}

		##English
		##English --- all
		else{
			$url = 'http://www.rarlab.com/rar/winrar-x64-'+$url_version+'.exe'
		}  
		 
		} else {

		###################################################### 32 bits downloads #################################################################

		##Arabic
		##Arabic - Saudi Arabia  1025
		##Arabic - Algeria	5121
		##Arabic - Bahrain	15361
		##Arabic - Egypt	3073
		##Arabic - Iraq		2049
		##Arabic - Jordan	11265
		##Arabic - Kuwait	13313
		##Arabic - Lebanon	12289
		##Arabic - Libya	4097
		##Arabic - Morocco	6145
		##Arabic - Oman		8193
		##Arabic - Qatar	16385
		##Arabic - Syria	10241
		##Arabic - Tunisia	7169
		##Arabic - U.A.E.	14337
		##Arabic - Yemen	9217
		if(($LCID -eq "1025") -or ($LCID -eq "5121") -or ($LCID -eq "15361") -or ($LCID -eq "3073") -or ($LCID -eq "2049") -or ($LCID -eq "11265") -or ($LCID -eq "13313") -or ($LCID -eq "12289") -or ($LCID -eq "4097") -or ($LCID -eq "6145") -or ($LCID -eq "8193") -or ($LCID -eq "16385") -or ($LCID -eq "10241") -or ($LCID -eq "7169") -or ($LCID -eq "14337") -or ($LCID -eq "9271")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'ar.exe'
		}

		##Armenian
		##Armenian   1067
		elseif($LCID -eq "1067"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'am.exe'
		}

		##Azerbaijani
		##AAzeri (Cyrillic)   2092
		##AAzeri (Latin)      1068
		elseif(($LCID -eq "2092") -or ($LCID -eq "1068")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'az.exe'
		}

		##Belarusian
		##Belarusian   1059
		elseif($LCID -eq "1059"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'by.exe'
		}

		##Bulgarian
		##Bulgarian   1026
		elseif($LCID -eq "1026"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'bg.exe'
		}

		##Catalan
		##Catalan   1027
		elseif($LCID -eq "1027"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'by.exe'
		}

		##Chinese Simplified
		##Chinese - People's Republic of China 	 2052
		##Chinese - Singapore					 4100
		##Chinese - Hong Kong SAR	             3076
		##Chinese - Macao SAR					 5124
		#elseif(($LCID -eq "2052") -or ($LCID -eq "4100") -or ($LCID -eq "3076") -or ($LCID -eq "5124")){
			#$url = 'http://www.rarlab.com/rar/wrar510sc.exe'
		#}

		##Chinese Traditional
		##Chinese - Taiwan					1028
		elseif($LCID -eq "1028"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'tc.exe'
		}

		##Croatian
		##Croatian				          1050
		##Croatian (Bosnia/Herzegovina)   4122
		elseif(($LCID -eq "1050") -or ($LCID -eq "4122")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'cro.exe'
		}

		##Czech
		##Czech   1029
		#elseif($LCID -eq "1029"){
			#$url = 'http://www.rarlab.com/rar/wrar510cz.exe'
		#}

		##Danish
		##Danish   1030
		elseif($LCID -eq "1030"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'dk.exe'
		}

		##Dutch
		##Dutch - Netherlands		1043
		##Dutch - Belgium			2067
		elseif(($LCID -eq "1043") -or ($LCID -eq "2067")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'nl.exe'
		}

		##Estonian
		##Estonian			1061
		elseif($LCID -eq "1061"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'est.exe'
		}

		##Finnish
		##Finnish			1035
		elseif($LCID -eq "1035"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'fi.exe'
		}

		##French
		##French			1036
		elseif($LCID -eq "1036"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'fr.exe'
		}

		##Galician
		##Galician			1110
		elseif($LCID -eq "1110"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'gl.exe'
		}

		##Georgian
		##Georgian			1079
		#elseif($LCID -eq "1079"){
			#$url = 'http://www.rarlab.com/rar/wrar501ge.exe'
		#}

		##German
		##German			1031
		elseif($LCID -eq "1031"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'d.exe'
		}

		##Greek
		##Greek				1032
		#elseif($LCID -eq "1032"){
			#$url = 'http://www.rarlab.com/rar/wrar510el.exe'
		#}

		##Hebrew
		##Hebrew			1037
		elseif($LCID -eq "1037"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'he.exe'
		}

		##Hungarian
		##Hungarian			1038
		elseif($LCID -eq "1038"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'hu.exe'
		}

		##Indonesian
		##Indonesian		1057
		elseif($LCID -eq "1057"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'id.exe'
		}

		##Italian
		##Italian - Italy			1040
		##Italian - Switzerland		2064
		#elseif(($LCID -eq "1040") -or ($LCID -eq "2064")){
			#$url = 'http://www.rarlab.com/rar/wrar510it.exe'
		#}

		##Japanese
		##Japanese		1041
		elseif($LCID -eq "1041"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'j.exe'
		}

		##Korean
		##Korean		1042
		elseif($LCID -eq "1042"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'kr.exe'
		}

		##Lithuanian
		##Lithuanian	1063
		elseif($LCID -eq "1063"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'lt.exe'
		}

		##Macedonian
		##Macedonian											0047
		##Macedonian (Former Yugoslav Republic of Macedonia)	1071
		elseif(($LCID -eq "0047") -or ($LCID -eq "1071")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'mk.exe'
		}

		##Norwegian
		##Norwegian (Bokmål)		1044
		##Norwegian (Nynorsk)		2068
		elseif(($LCID -eq "1044") -or ($LCID -eq "2068")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'no.exe'
		}

		##Persian
		##Persian		0041
		##Persian Iran	1065
		elseif(($LCID -eq "0041") -or ($LCID -eq "1065")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'prs.exe'
		}

		##Polish
		##Polish		1045
		elseif($LCID -eq "1045"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'pl.exe'
		}

		##Portuguese - Portugal
		##Portuguese - Portugal 2070  (pt-pt)
		elseif($LCID -eq "2070"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'pt.exe'
		}

		##Portuguese - Brazil
		##Portuguese - Brazil  1046   (pt-br)
		elseif($LCID -eq "1046"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'br.exe'
		}

		##Romanian
		##Romanian			1048
		##Romanian Moldava  2072
		elseif(($LCID -eq "1048") -or ($LCID -eq "2072")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'ro.exe'
		}

		##Russian
		##Russian (ru-ru)			1049    
		##Russian-Moldava (ru-mo)	2073
		elseif(($LCID -eq "1049") -or ($LCID -eq "2073")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'ru.exe'
		}

		##Serbian Cyrillic
		##Serbian Cyrillic	3098
		elseif($LCID -eq "3098"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'srbcyr.exe'
		}

		##Serbian Latin
		##Serbian Latin		2074
		elseif($LCID -eq "2074"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'srblat.exe'
		}

		##Sinhala
		##Sinhala			1115
		#elseif($LCID -eq "1115"){
			#$url = 'http://www.rarlab.com/rar/wrar501si.exe'
		#}

		##Slovak
		##Slovak			1051
		#elseif($LCID -eq "1051"){
			#$url = 'http://www.rarlab.com/rar/wrar510sk.exe'
		#}

		##Slovenian		
		##Slovenian			1060
		#elseif($LCID -eq "1060"){
			#$url = 'http://www.rarlab.com/rar/wrar510slv.exe'
		#}

		##Spanish
		##Spanish - Spain (Modern Sort)			3082
		##Spanish - Spain (Traditional Sort)    1034   (es-es)
		##Spanish - Argentina   				11274
		##Spanish - Bolivia   					16394
		##Spanish - Chile   					13322
		##Spanish - Colombia   					9226
		##Spanish - Costa Rica  			 	5130
		##Spanish - Dominican Republic  	 	7178
		##Spanish - Ecuador  				 	12298
		##Spanish - El Salvador  			 	17418
		##Spanish - Guatemala  				 	4106
		##Spanish - Honduras   					18442
		##Spanish - Latin America 				22538
		##Spanish - Mexico				   		2058
		##Spanish - Nicaragua   				19466
		##Spanish - Panama   					6154
		##Spanish - Paraguay   					15370
		##Spanish - Peru   						10250
		##Spanish - Puerto Rico 		  		20490
		##Spanish - United States 		  		21514
		##Spanish - Uruguay 			  		14346
		##Spanish - Venezuela  			 		8202
		elseif(($LCID -eq "3082") -or ($LCID -eq "1034") -or ($LCID -eq "11274") -or ($LCID -eq "16394") -or ($LCID -eq "13322") -or ($LCID -eq "9226") -or ($LCID -eq "5130") -or ($LCID -eq "7178") -or ($LCID -eq "12298") -or ($LCID -eq "17418") -or ($LCID -eq "4106") -or ($LCID -eq "18442") -or ($LCID -eq "22538") -or ($LCID -eq "2058") -or ($LCID -eq "19466") -or ($LCID -eq "6154") -or ($LCID -eq "15370") -or ($LCID -eq "10250") -or ($LCID -eq "20490") -or ($LCID -eq "21514") -or ($LCID -eq "14346") -or ($LCID -eq "8202")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'es.exe'
		}

		##Swedish
		##Swedish					1053
		##Swedish - Finland			2077
		elseif(($LCID -eq "1053") -or ($LCID -eq "2077")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'sw.exe'
		}

		##Thai
		##Thai						1054
		#elseif($LCID -eq "1054"){
			#$url = 'http://www.rarlab.com/rar/wrar510th.exe'
		#}

		##Turkish
		##Turkish					1055
		#elseif($LCID -eq "1055"){
			#$url = 'http://www.rarlab.com/rar/wrar510tr.exe'
		#}

		##Turkmen
		##Turkmen					1090
		#elseif($LCID -eq "1090"){
			#$url = 'http://www.rarlab.com/rar/wrar500tkm.exe'
		#}

		##Ukrainian
		##Ukrainian					1058
		elseif($LCID -eq "1058"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'ukr.exe'
		}

		##Uzbek
		##Uzbek (Cyrillic)			2115
		##Uzbek (Latin)				1091
		elseif(($LCID -eq "2115") -or ($LCID -eq "1091")){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'uz.exe'
		}

		#Valencian
		#Valencian			2051
		elseif($LCID -eq "2051"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'va.exe'
		}

		##Vietnamese
		##Vietnamese		1066
		elseif($LCID -eq "1066"){
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'vn.exe'
		}

		##English
		##English --- all
		else{
			$url = 'http://www.rarlab.com/rar/wrar'+$url_version+'.exe'
		} 
	}

	Install-ChocolateyPackage $packageName $installerType $silentArgs $url -validExitCodes $validExitCodes
	
	Write-ChocolateySuccess $packageName
	
} catch {
	Write-ChocolateyFailure $packageName $($_.Exception.Message)
	throw 
}

#LCID table
#http://msdn.microsoft.com/es-es/goglobal/bb964664.aspx
#http://www.google.es/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=0CDEQFjAA&url=http%3A%2F%2Fdownload.microsoft.com%2Fdownload%2F9%2F5%2FE%2F95EF66AF-9026-4BB0-A41D-A4F81802D92C%2F%5BMS-LCID%5D.pdf&ei=vSPuUtDVEofH7AbQ3oGQBA&usg=AFQjCNEREnu7-8_K7zNDzWIGGf72VKYmGw&sig2=q2n0zBluoe0zWsvQXg5N-g

#downloads location
#http://www.rarlab.com/download.htm