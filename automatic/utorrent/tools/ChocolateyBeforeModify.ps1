if (Get-Process uTorrent -ea SilentlyContinue) {
  Stop-Process uTorrent
}
