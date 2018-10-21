$packageName = 'Julia'
$installerType = 'exe'
$chk32 = 'df7b3685c1bef8acb694ae2e771a9b9744494140815a7b3a5a40a28954d724ff';
$chk64 = '3bf5572cbcbc7848b235dcf21caf24ce26b9fb3839eb13db1a7170d20cdf834d';
$url32 = 'https://julialang-s3.julialang.org/bin/winnt/x86/1.0/julia-1.0.0-win32.exe'
$url64 = 'https://julialang-s3.julialang.org/bin/winnt/x64/1.0/julia-1.0.0-win64.exe'
$silentArgs = "/S"
 
Install-ChocolateyPackage -checksum $chk32 -checksumType sha256 -checksum64 $chk64 -checksumType64 sha256 "$packageName" "$installerType" "$silentArgs" "$url32" "$url64"
