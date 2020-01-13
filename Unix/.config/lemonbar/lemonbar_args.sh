#!/bin/bash

clock() 
{
    date '+%Y-%m-%d %H:%M' # print current date and time: yyyy-mm-dd HH:MM
}

battery()
{
    BATC=/sys/class/power_supply/BAT0/capacity
    BATS=/sys/class/power_supply/BAT0/status

    # prepend percentage with a '+' if charging, '-' otherwise
    test "`cat $BATS`" = "Charging" && echo -n '[+]' || echo -n '[-]'

    # print out the content (forced myself to use `sed` :P)
    sed -n p $BATC
}

volume()
{
    amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'| uniq
}

cpu() 
{
    LINE=`ps -eo pcpu |grep -vE '^\s*(0.0|%CPU)' |sed -n '1h;$!H;$g;s/\n/ +/gp'`
    bc <<< $LINE
}

mem() 
{
    read t <<< `grep -E 'Total' /proc/meminfo |awk '{print $2}'`
    read f <<< `grep -E 'Free' /proc/meminfo |awk '{print $2}'`
    bc <<< "scale=2; 100 - $f / $t * 100" | cut -d. -f1
}

network()
{
   # The following assumes you have 3 interfaces: loopback, ethernet, wifi
    read lo int1 int2 <<< `ip link | sed -n 's/^[0-9]: \(.*\):.*$/\1/p'`

    # iwconfig returns an error code if the interface tested has no wireless
    # extensions
    if iwconfig $int1 >/dev/null 2>&1; then
        wifi=$int1
        eth0=$int2
    else 
        wifi=$int2
        eth0=$int1
    fi 

    ip link show $eth0 | grep 'state UP' >/dev/null && int=$eth0 || int=$wifi
    echo -n "$int"
    ping -c 1 8.8.8.8 >/dev/null 2>&1 && echo -e '\u2713' || echo -e '\u2717'
}

groups() {
    cur=`xprop -root _NET_CURRENT_DESKTOP | awk '{print $3}'`
    tot=`xprop -root _NET_NUMBER_OF_DESKTOPS | awk '{print $3}'`

    for w in `seq 0 $((cur - 1))`; do line="${line}☐"; done
    line="${line}☒"
    for w in `seq $((cur + 2)) $tot`; do line="${line}☐"; done
    echo $line
}

while :
do
    buf="%{l} "
    buf="${buf} [$(groups)] %{c}"
    buf="${buf} $(clock) %{r}|"
    buf="${buf} VOL: $(volume)% |"
    buf="${buf} CPU: $(cpu)% |"
    buf="${buf} RAM: $(mem)% |"
    buf="${buf} NET: $(network) |"
    buf="${buf} BAT: $(battery)% |"

    echo $buf
    sleep 1s
done
