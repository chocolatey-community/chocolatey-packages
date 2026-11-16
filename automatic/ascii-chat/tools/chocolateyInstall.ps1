$arm64 = $env:PROCESSOR_ARCHITEW6432 -eq 'ARM64'
$url = if ($arm64) { 'https://github.com/zfogg/ascii-chat/releases/download/v0.16.30/ascii-chat-0.16.30-Windows-arm64.zip' } else { 'https://github.com/zfogg/ascii-chat/releases/download/v0.16.30/ascii-chat-0.16.30-Windows-amd64.zip' }
$hash = if ($arm64) { '7FDF983570A0EE7FD0AC8BE46892A1FDAE9999992094F850CB596CD1A5EE8A88' } else { 'B774D063563AC072AA65FFC60336556B282DDCF3A115E96A68FE1C898F438693' }
Install-ChocolateyZipPackage -PackageName 'ascii-chat' -Url $url -UnzipLocation (Join-Path (Get-ToolsLocation) 'ascii-chat') -Checksum $hash -ChecksumType 'sha256'
Install-BinFile -Name 'ascii-chat' -Path (Join-Path (Get-ToolsLocation) 'ascii-chat\ascii-chat.exe')
