if ($IsWindows) {
    # Install OhMyPosh via winget
    winget install JanDeDobbeleer.OhMyPosh -s winget

    # Set the $PATH
    $env:PATH += "$HOME\\AppData\\Local\\Programs\\oh-my-posh\\bin"
}

if ($IsLinux) {
    # Need to set up the path and install any requirements
    # curl -s https://ohmyposh.dev/install.sh | bash -s
}
