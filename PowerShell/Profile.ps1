# Theme
oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression

$modules = @('Posh-Git', 'PSReadLine')
foreach ($module in $modules) {
    if (-not (Get-Module -Name $module -ListAvailable)) {
        Import-Module $module
    }
}

Set-PSReadLineOption -ShowToolTips:$true
Set-PSReadLineOption -MenuCompleteStyle List

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
