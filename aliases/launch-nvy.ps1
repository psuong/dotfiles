if (Get-Command "nvy.exe" -ErrorAction SilentlyContinue) {
    Invoke-Expression "Nvy.exe --maximize --disable-fullscreen"
}
else {
    Write-Error "Nvy.exe not found in PATH" -ForegroundColor Red
}
