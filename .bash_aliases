export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u]\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\] \[\033[1;93m\]$(__git_ps1 "(%s)")\[\033[0m\] \[\033[01;37m\]>>\[\033[00m\] '

# Bat (Like cat)
# ------------------------------------------------------------------------------------------------------------------
export BAT_THEME="TwoDark"

# FZF
# ------------------------------------------------------------------------------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    source ~/sources/fzf-tab-completion/bash/fzf-bash-completion.sh
    bind -x '"\t": fzf_bash_completion'
fi

# WSL Terminal CColors
# ------------------------------------------------------------------------------------------------------------------
if [ command -v dircolors &> /dev/null ]; then
    eval "$(dircolors -p | \
        sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
        dircolors /dev/stdin)"
fi

# MacOS Settings
# ----------------------------------------------------------------------------------------
if [[ "$OSTYPE" == "darwin"* ]]; then
    [[ -r "/usr/local/etc/profile.d/bash_completion.sh" ]] && . "/usr/local/etc/profile.d/bash_completion.sh"
    export BASH_SILENCE_DEPRECATION_WARNING=1
    source ~/.git-prompt.sh
    source ~/.git-completion.bash
    source /Users/psuong/sources/vulkansdk-macos-1.2.135.0/setup-env.sh
fi
