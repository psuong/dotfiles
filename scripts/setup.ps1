if ($IsWindows) {
    New-Item -ItemType SymbolicLink -Target "$HOME\\sources\\dotfiles\\PowerShell" -Path "$HOME\\Documents\\PowerShell"
    
    winget install JanDeDobbeleer.OhMyPosh -s winget
    PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
    PowerShellGet\Install-Module PSCompletions -Scope CurrentUser -Force
    
    New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Local\nvim" -Target "$HOME\sources\dotfiles\.config\nvim"
    New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\alacritty" -Target "$HOME\sources\dotfiles\.config\alacritty"
    New-Item -ItemType HardLink -Path "$HOME\AppData\Roaming\Vim\Vim Clap\config\config.toml" -Target "$HOME\sources\dotfiles\.config\vim-clap\config.toml"
}

if ($IsLinux) {
    Write-Output "Setting up for Linux"

    # We need to link the .config directory from the dotfiles to the actual path
    # Link everything from dotfiles .config to my ~/.config
    foreach ($item in Get-ChildItem "../.config") {
        $target = Join-Path "~/.config" $item.Name
	if (-not (Test-Path $target)) {
	    Write-Output "Linking $($item.FullName) -> $($target)"
	    # Suppress the output
            New-Item -ItemType SymbolicLink -Path $target -Target $item.FullName | Out-Null
        }
    }
}
