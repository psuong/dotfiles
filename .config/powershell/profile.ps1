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

$modules = @('posh-git', 'PSReadLine')
foreach ($module in $modules) {
    if (-not (Get-Module -Name $module -ListAvailable)) {
        Import-Module $module
    }
}

Set-PSReadLineOption -ShowToolTips:$true
Set-PSReadLineOption -PredictionViewStyle List
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key 'Alt+J' -Function NextSuggestion
Set-PSReadLineKeyHandler -Key 'Alt+K' -Function PreviousSuggestion

function Invoke-Tere {
    $result = & (Get-Command -CommandType Application tere) $args
    if ($result) {
        Set-Location $result
    }
}
Set-Alias tere Invoke-Tere
