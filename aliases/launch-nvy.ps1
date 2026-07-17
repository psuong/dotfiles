if (Get-Command "nvy.exe" -ErrorAction SilentlyContinue) {
    Invoke-Expression "nvy.exe --maximize --disable-fullscreen"
}
else {
    Write-Error "nvy.exe not found in PATH" -ForegroundColor Red
}