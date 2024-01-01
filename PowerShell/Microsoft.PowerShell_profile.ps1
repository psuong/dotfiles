# Theme
oh-my-posh.exe init pwsh --config $env:POSH_THEMES_PATH\negligible.omp.json | Invoke-Expression

Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionViewStyle InlineView
Import-Module Posh-Git