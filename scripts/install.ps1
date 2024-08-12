New-Item -ItemType SymbolicLink -Target C:\Users\porri\sources\dotfiles\PowerShell\ -Path C:\Users\porri\Documents\PowerShell

winget install JanDeDobbeleer.OhMyPosh -s winget
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force

New-Item -ItemType SymbolicLink -Path $HOME\AppData\Local\nvim -Target $HOME\sources\dotfiles\.config\nvim
New-Item -ItemType SymbolicLink -Path $HOME\AppData\Roaming\alacritty -Target $HOME\sources\dotfiles\.config\alacritty
