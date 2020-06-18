export PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\][\u]\[\033[00m\] \[\033[01;34m\]\W\[\033[00m\] \[\033[1;93m\]$(__git_ps1 "(%s)")\[\033[0m\] \[\033[01;37m\]>>\[\033[00m\] '

export BAT_THEME="GitHub"

# FZF
export FZF_CTRL_T_OPTS="--preview 'batcat --style=numbers --color=always --line-range :500 {}'"
