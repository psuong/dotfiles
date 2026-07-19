# Theme
if ($IsWindows) {
    oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression
}

if ($IsLinux) {
    # Add cargo to the env
    . "$HOME/.cargo/env.ps1"

    # Add some programs to my $PATH 
    $env:PATH += ":/home/blank/sources/bin/binget:/home/blank/sources/bin/omnisharp:/home/blank/.spicetify"

    # Use the negligible theme
    oh-my-posh init pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/negligible.omp.json" | Invoke-Expression
}

function Invoke-Tere {
    $result = & (Get-Command -CommandType Application tere) $args
    if ($result) {
        Set-Location $result
    }
}
Set-Alias tere Invoke-Tere

Get-InstalledModule | ForEach-Object {
    Import-Module $_.Name
}
Invoke-Expression "psc update --all"

Set-PSReadLineKeyHandler -Key Ctrl+l -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion()
}