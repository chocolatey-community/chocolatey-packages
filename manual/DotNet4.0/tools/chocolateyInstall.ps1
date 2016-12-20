if(!(Test-Path "hklm:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\SKUs\.NETFramework,Version=v4.0")) {
    $env:chocolateyPackageFolder="$env:temp\chocolatey\webcmd"
    Install-ChocolateyZipPackage 'webcmd' 'http://www.iis.net/community/files/webpi/webpicmdline_anycpu.zip' $env:temp
    .$env:temp\WebpiCmdLine.exe /products: NetFramework4 /accepteula
}
else {
     Write-Output "Microsoft .Net 4.0 Framework is already installed on your machine."
} 