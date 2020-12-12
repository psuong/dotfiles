export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u]\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\] \[\033[1;93m\]$(__git_ps1 "(%s)")\[\033[0m\] \[\033[01;37m\]>>\[\033[00m\] '

# Bat (Like cat)
# ------------------------------------------------------------------------------------------------------------------
export BAT_THEME="OneHalfDark"

# FZF
# ------------------------------------------------------------------------------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
source ~/sources/fzf-tab-completion/bash/fzf-bash-completion.sh
bind -x '"\t": fzf_bash_completion'

# WSL Terminal CColors
# ------------------------------------------------------------------------------------------------------------------
eval "$(dircolors -p | \
    sed 's/ 4[0-9];/ 01;/; s/;4[0-9];/;01;/g; s/;4[0-9] /;01 /' | \
    dircolors /dev/stdin)"
