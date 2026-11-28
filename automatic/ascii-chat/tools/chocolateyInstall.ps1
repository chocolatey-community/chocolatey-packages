$arm64 = $env:PROCESSOR_ARCHITEW6432 -eq 'ARM64'
$url = if ($arm64) { 'https://github.com/zfogg/ascii-chat/releases/download/v0.16.113/ascii-chat-0.16.113-Windows-arm64.zip' } else { 'https://github.com/zfogg/ascii-chat/releases/download/v0.16.113/ascii-chat-0.16.113-Windows-amd64.zip' }
$hash = if ($arm64) { '80301E2173BC274577D5DDB59FD7F90CD608183C428EFE359BB4123E177072CB' } else { 'FD6583B490AF182B2EBE3BF3F3E7C8F5127890C5CB9DBF86D042F0175AD45F83' }
Install-ChocolateyZipPackage -PackageName 'ascii-chat' -Url $url -UnzipLocation (Join-Path (Get-ToolsLocation) 'ascii-chat') -Checksum $hash -ChecksumType 'sha256'
Install-BinFile -Name 'ascii-chat' -Path (Join-Path (Get-ToolsLocation) 'ascii-chat\ascii-chat.exe')
