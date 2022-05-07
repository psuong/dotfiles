New-Item -ItemType SymbolicLink -Path $HOME\.vim -Target $HOME\sources\dotfiles\.vim
New-Item -ItemType SymbolicLink -Path $HOME\AppData\Local\nvim -Target $HOME\sources\dotfiles\.config\nvim
New-Item -ItemType SymbolicLink -Path $HOME\AppData\Roaming\alacritty -Target $HOME\sources\dotfiles\.config\alacritty