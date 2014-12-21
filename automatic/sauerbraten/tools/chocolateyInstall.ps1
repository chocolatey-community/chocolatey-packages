# {\{DownloadUrlx64}\} gets “misused” here as 32-bit download link due to limitations of Ketarin/chocopkgup
$url = '{{DownloadUrlx64}}'

Install-ChocolateyPackage '{{PackageName}}' 'exe' '/S' $url
