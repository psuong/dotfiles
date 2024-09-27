# Theme
oh-my-posh.exe init pwsh --config $env:POSH_THEMES_PATH\negligible.omp.json | Invoke-Expression

Import-Module Posh-Git
Import-Module PSReadLine
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineOption -PredictionViewStyle List

function Invoke-Tere() {
    $result = . (Get-Command -CommandType Application tere) $args
    if ($result) {
        Set-Location $result
    }
}
Set-Alias tere Invoke-Tere
