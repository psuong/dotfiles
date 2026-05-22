# Appends content to a file if it does not exist
function Add-FileContentIfMissing {
    param (
        [Parameter(Mandatory)]
        [string]$SourcePath,

        [Parameter(Mandatory)]
        [string]$DestinationPath
    )

    if (-not (Test-Path $SourcePath)) {
        throw "Source file does not exist: $SourcePath"
    }

    if (-not (Test-Path $DestinationPath)) {
        New-Item -ItemType File -Path $DestinationPath -Force | Out-Null
    }

    $contentToAppend = Get-Content $SourcePath -Raw
    $existingContent = Get-Content $DestinationPath -Raw

    if ($existingContent -notmatch [regex]::Escape($contentToAppend)) {
        Add-Content -Path $DestinationPath -Value $contentToAppend
        Write-Host "Content appended."
    }
    else {
        Write-Host "Content already exists. Nothing added."
    }
}

if ($IsWindows) {
    New-Item -ItemType SymbolicLink -Target "$HOME\\sources\\dotfiles\\.config\\PowerShell" -Path "$HOME\\Documents\\PowerShell"
    
    winget install JanDeDobbeleer.OhMyPosh -s winget
    PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
    PowerShellGet\Install-Module PSCompletions -Scope CurrentUser -Force
    
    New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Local\nvim" -Target "$HOME\sources\dotfiles\.config\nvim"
    New-Item -ItemType SymbolicLink -Path "$HOME\AppData\Roaming\alacritty" -Target "$HOME\sources\dotfiles\.config\alacritty"
    New-Item -ItemType HardLink -Path "$HOME\AppData\Roaming\Vim\Vim Clap\config\config.toml" -Target "$HOME\sources\dotfiles\.config\vim-clap\config.toml"
}

if ($IsLinux) {
    Write-Host "Setting up for Linux"

    # We need to link the .config directory from the dotfiles to the actual path
    # Link everything from dotfiles .config to my ~/.config
    foreach ($item in Get-ChildItem "../.config") {
        $target = Join-Path "~/.config" $item.Name
	    if (-not (Test-Path $target)) {
	        Write-Host "Linking $($item.FullName) -> $($target)"
    	    # Suppress the output
            New-Item -ItemType SymbolicLink -Path $target -Target $item.FullName | Out-Null
        }
    }
    
    Write-Host "Installing OhMyPosh"
    curl -s https://ohmyposh.dev/install.sh | bash -s
    
    Write-Host "Installing Modules posh-git and PSCompletions"
    PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
    PowerShellGet\Install-Module PSCompletions -Scope CurrentUser -Force

    Write-Host "Appending git-delta configs to .gitconfig"
    Add-FileContentIfMissing -SourcePath "../templates/.gitconfig" -DestinationPath "~/.gitconfig"
}
