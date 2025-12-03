# Theme
oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression

$modules = @('Posh-Git', 'PSReadLine')
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

Function br {
    $args = $args -join ' '
    $cmd_file = New-TemporaryFile

    $process = Start-Process -FilePath 'broot.exe' `
        -ArgumentList "--outcmd $($cmd_file.FullName) $args" `
        -NoNewWindow -PassThru -WorkingDirectory $PWD

    Wait-Process -InputObject $process #Faster than Start-Process -Wait
    If ($process.ExitCode -eq 0) {
        $cmd = Get-Content $cmd_file
        Remove-Item $cmd_file
        If ($null -ne $cmd) { Invoke-Expression -Command $cmd }
    }
    Else {
        Remove-Item $cmd_file
        Write-Host "`n" # Newline to tidy up broot unexpected termination
        Write-Error "broot.exe exited with error code $($process.ExitCode)"
    }
}