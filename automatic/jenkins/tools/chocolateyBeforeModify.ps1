if (Get-Service Jenkins -ErrorAction SilentlyContinue) {
    Stop-Service Jenkins
}