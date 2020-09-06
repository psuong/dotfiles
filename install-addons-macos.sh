#!/bin/sh

if [ ! -f ~/.bash_aliases ]; then
    echo ".bash_aliases is not found, creating one at the home directory"
    touch ~/.bash_aliases
fi

# Bash Warning
echo "export BASH_SILENCE_DEPRECATION_WARNING=1" >> ~/.bash_aliases

# Git completion
echo "source ~/.git-prompt.sh" >> ~/.bash_aliases
echo "source ~/.git-completion.bash" >> ~/.bash_aliases

# Vulkan support
VULKAN_SDK_ROOT="$HOME/sources/vulkansdk-macos-"
VULKAN_SDK_VERSION="1.2.135.0"
VULKAN_ROOT="$VULKAN_SDK_ROOT$VULKAN_SDK_VERSION"
echo "source $VULKAN_ROOT/setup-env.sh" >> ~/.bash_aliases

# echo "export VULKAN_DIR="$HOME/sources/$VULKAN_SDK_ROOT$VULKAN_SDK_VERSION/macOS"" >> ~/.bash_aliases
# echo "export VK_ICD_FILENAMES="\$VULKAN_SDK/etc/vulkan/icd.d/MoltenVK_icd.json"" >> ~/.bash_aliases
# echo "export VK_LAYER_PATH="\$VULKAN_SDK/etc/vulkan/explicit_layers.d"" >> ~/.bash_aliases
# echo "export DYLD_LIBRARY_PATH="\$VULKAN_SDK/lib/"" >> ~/.bash_aliases
# echo "export PATH="\$VULKAN_SDK:$PATH"" >> ~/.bash_aliases

if [ ! -f ~/.bashrc ]; then
    echo "Reloading the .bashrc file"
    source ~/.bashrc
fi

if [ ! -f ~/.bash_profile ]; then
    echo "Reloading the .bash_profile file"
    source ~/.bash_profile
fi