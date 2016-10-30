

		# Variables
		$kb = "kb2999226"
		$packageName = $kb
		$proceed = $false
		# Windows Systems That Qualify for KB2999226
		$AppliesTo = @('Microsoft Windows Server 2012 R2 Datacenter','Microsoft Windows Server 2012 R2 Standard','Microsoft Windows Server 2012 R2 Essentials','Microsoft Windows Server 2012 R2 Foundation','Microsoft Windows 8.1 Enterprise','Microsoft Windows 8.1 Pro','Microsoft Windows 8.1','Microsoft Windows RT 8.1','Microsoft Windows Server 2012 Datacenter','Microsoft Windows Server 2012 Standard','Microsoft Windows Server 2012 Essentials','Microsoft Windows Server 2012 Foundation','Microsoft Windows 8 Enterprise','Microsoft Windows 8 Pro','Microsoft Windows 8','Microsoft Windows RT','Microsoft Windows Server 2008 R2 Datacenter Service Pack 1','Microsoft Windows Server 2008 R2 Enterprise Service Pack 1','Microsoft Windows Server 2008 R2 Standard Service Pack 1','Microsoft Windows 7 Service Pack 1','Microsoft Windows Server 2008 Service Pack 2','Microsoft Windows Vista Service Pack 2')
		$silentArgs = "/quiet /norestart /log:`"$env:TEMP\$kb.Install.evt`""
		# OS Information
		$os = Get-WmiObject -Class Win32_OperatingSystem
		$caption = $os.Caption
		$sp = $os.ServicePackMajorVersion
		if ($sp -gt 0) {
		$caption += "Service Pack $sp"
		}
		# Messages for the Consumer
		$proceeding = "Proceding with installation because this hotfix applies to $caption.`n"
		$skipping = "Skipping installation because hotfix $kb is already installed.`n"
		$matching = "You are using $caption, and do qualify for the $kb.`n"
		$fini_yes = "This $kb has been installed on your $caption.`n"
		$fini_no = "This $kb does not Apply to your $caption.`n"

	Try {
		foreach ( $detected in $AppliesTo  ) {
			if ( $detected -eq $caption ) {
				Write-Host $proceeding
				$proceed = $true
				if (Get-HotFix -id $kb -ea SilentlyContinue) {
					Write-Host $skipping
					$proceed = $false
					return
				}

				if ( $proceed ) {
					switch -Exact($os.version) {
						'6.3.9600' {
							# Windows 8.1 & Windows Server 2012 R2
							Write-Host $matching
							#32
							$url = 'https://download.microsoft.com/download/E/4/6/E4694323-8290-4A08-82DB-81F2EB9452C2/Windows8.1-KB2999226-x86.msu'
							$checksum = 'B83251219C5390536B02BEBAF5E43A6F13381CE1DB43E76483BCE07C4BCF877B'
							#64
							$url64 = 'https://download.microsoft.com/download/D/1/3/D13E3150-3BB2-4B22-9D8A-47EE2D609FFF/Windows8.1-KB2999226-x64.msu'
							$checksum64 = '9F707096C7D279ED4BC2A40BA695EFAC69C20406E0CA97E2B3E08443C6381D15'
							return
						}
						'6.2.9200' {
							# Windows 8.0 & Windows Server 2012
							Write-Host $matching
							#32
							$url = 'https://download.microsoft.com/download/1/E/8/1E8AFE90-5217-464D-9292-7D0B95A56CE4/Windows8-RT-KB2999226-x86.msu'
							$checksum = '0F36750FBB06FEE23131F68B4D0943841EED24730EC1D5D77DEDC41D359BE88D'
							#64
							$url64 = 'https://download.microsoft.com/download/9/3/E/93E0745A-EAE9-4B5A-B50C-012F2D3B6659/Windows8-RT-KB2999226-x64.msu'
							$checksum64 = '50CAE25DA33FA950222D1A803E42567291EB7FEB087FA119B1C97FE9D41CD9F8'
							return
						}
						'6.1.7601' {
							# Windows 7 w/ SP1 & Windows Server 2008 R2 w/ SP1
							Write-Host $matching
							#32
							$url = 'https://download.microsoft.com/download/4/F/E/4FE73868-5EDD-4B47-8B33-CE1BB7B2B16A/Windows6.1-KB2999226-x86.msu'
							$checksum = '909E76C81EF0EB176144B253DDFFE7A8FDFACEBFAA15E97DEF003D2262FBF084'
							#64
							$url64 = 'https://download.microsoft.com/download/F/1/3/F13BEC9A-8FC6-4489-9D6A-F84BDC9496FE/Windows6.1-KB2999226-x64.msu'
							$checksum64 = '43234D2986CA9B0DE75D5183977964D161A8395C3396279DDFC9B20698E5BC34'
							return
						}
						'6.0.6002' {
							# Windows Vista w/ SP2 & Windows Server 2008 w/ SP2
							Write-Host $matching
							#32
							$url = 'https://download.microsoft.com/download/D/8/3/D838D576-232C-4C17-A402-75913F27113B/Windows6.0-KB2999226-x86.msu'
							$checksum = 'AE380F63BF4E8700ADA686406B04B01230A339B09EDF7819814A4C0BF4AB72E1'
							#64
							$url64 = 'https://download.microsoft.com/download/5/4/E/54E27BE2-CFB2-4FC9-AB03-C39302CA68A0/Windows6.0-KB2999226-x64.msu'
							$checksum64 = '10069DE7315CA3F405E2579846AF5DAB3089A8496AE4C1AB61763480F43A05A8'
							return
						}
						default { Write-Warning "Running on unsupported Operating System.  No installation will take place."; return}
					}
				}
			}

		}
	}
	Finally {
		if ($proceed) {
				$packageArgs = @{
				packageName   = $packageName
				fileType      = 'msu'
				url           = $url
				url64bit      = $url64
				silentArgs    = $silentArgs
				validExitCodes= @(0, 3010, 0x80240017)
				softwareName  = $packageName
				checksum      = $checksum
				checksumType  = 'sha256'
				checksum64    = $checksum64
				checksumType64= 'sha256'
				}
				Install-ChocolateyPackage @packageArgs
		Write-Host $fini_yes
		} else {
		Write-Host $fini_no
		}
	}
