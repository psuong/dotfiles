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
    Write-Host "Setting up for Windows"
    $documentsPath = [System.Environment]::GetFolderPath("MyDocuments");
    $target = Join-Path $documentsPath "PowerShell";
    if (-not (Test-Path $target)) {
        New-Item -ItemType SymbolicLink -Target "$HOME\\sources\\dotfiles\\.config\\PowerShell" -Path $target 
    }

    Write-Host "Installing OhMyPosh"
    winget install JanDeDobbeleer.OhMyPosh -s winget
    
    if (-not (Test-Path "$HOME\\sources\\dotfiles\\.config\\nvim")) {
        New-Item -ItemType SymbolicLink -Path "$HOME\\AppData\\Local\\nvim" -Target "$HOME\\sources\\dotfiles\\.config\\nvim"
    }
    if (-not (Test-Path "$HOME\\sources\\dotfiles\\.config\\alacritty")) {
        New-Item -ItemType SymbolicLink -Path "$HOME\\AppData\\Roaming\\alacritty" -Target "$HOME\\sources\\dotfiles\\.config\\alacritty"
    }

    if (-not (Test-Path "$HOME\\sources\\dotfiles\\.config\\vim-clap\\config.toml")) {
        New-Item -ItemType HardLink -Path "$HOME\AppData\Roaming\Vim\Vim Clap\config\config.toml" -Target "$HOME\sources\dotfiles\.config\vim-clap\config.toml"
    }
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

    Write-Host "Appending git-delta configs to .gitconfig"
    Add-FileContentIfMissing -SourcePath "../templates/.gitconfig" -DestinationPath "~/.gitconfig"
}

function Install-OrUpdateModule {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [ValidateSet("CurrentUser", "AllUsers")]
        [string]$Scope = "CurrentUser"
    )

    $module = Get-InstalledModule -Name $Name -ErrorAction SilentlyContinue

    if ($null -ne $module) {
        Write-Host "Updating module '$Name'..."
        Update-Module -Name $Name -ErrorAction Stop
    }
    else {
        Write-Host "Installing module '$Name'..."
        Install-Module -Name $Name -Scope $Scope -Force -ErrorAction Stop
    }
}

function Install-OrUpdatePSResource {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Name,

        [ValidateSet("CurrentUser", "AllUsers")]
        [string]$Scope = "CurrentUser"
    )

    $resource = Get-InstalledPSResource -Name $Name -ErrorAction SilentlyContinue

    if ($null -ne $resource) {
        Write-Host "Updating '$Name'..."
        Update-PSResource -Name $Name -Scope $Scope
    }
    else {
        Write-Host "Installing '$Name'..."
        Install-PSResource -Name $Name -Scope $Scope -TrustRepository
    }
}

# Install common modules
Install-OrUpdateModule -Name "PSCompletions"
Install-OrUpdatePSResource -Name "PSCompletions"