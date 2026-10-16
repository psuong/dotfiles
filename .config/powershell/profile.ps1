# Theme
if ($IsWindows) {
    oh-my-posh.exe init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression
}

if ($IsLinux) {
    # Add cargo to the env
    . "$HOME/.cargo/env.ps1"

    # Add some programs to my $PATH 
    $env:PATH += ":/home/blank/sources/bin:/home/blank/sources/bin/omnisharp:/home/blank/.spicetify:/home/blank/.local/share/powershell/Modules"

    $env:VULKAN_SDK = "$HOME/vulkan/1.4.363.0/x86_64"
    $env:PATH = "$env:VULKAN_SDK/bin;$env:PATH"
    $env:LD_LIBRARY_PATH = "$env:VULKAN_SDK/lib/VulkanLoader/lib" +
        $(if ($env:LD_LIBRARY_PATH) { ";$env:LD_LIBRARY_PATH" })
    $env:VK_ADD_LAYER_PATH = "$env:VULKAN_SDK/share/vulkan/explicit_layer.d"
    $env:PKG_CONFIG_PATH = "$env:VULKAN_SDK/share/pkgconfig;$env:VULKAN_SDK/lib/pkgconfig" +
        $(if ($env:PKG_CONFIG_PATH) { ";$env:PKG_CONFIG_PATH" })
    $env:CMAKE_PREFIX_PATH = "$env:VULKAN_SDK;$env:VULKAN_SDK/lib/VulkanLoader"

    # Use the negligible theme
    oh-my-posh init pwsh --config "https://raw.githubusercontent.com/JanDeDobbeleer/oh-my-posh/refs/heads/main/themes/negligible.omp.json" | Invoke-Expression
}

function Invoke-Tere {
    $result = & (Get-Command -CommandType Application tere) $args
    if ($result) {
        Set-Location $result
    }
}
Set-Alias tere Invoke-Tere

Get-InstalledModule | ForEach-Object {
    Import-Module $_.Name
}
Invoke-Expression "psc update --all"

Set-PSReadLineKeyHandler -Key Ctrl+n -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptSuggestion()
}