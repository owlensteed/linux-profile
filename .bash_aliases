[ "$TERM" ] && alias htop='TERM=screen htop'

if [ -f "/bin/firewall-cmd" ] || [ -f "/usr/sbin/csf" ]; then
  deny_ip_add() {
    [ "$1" == "" ] && printf "\033[1;31mYou must specify an IP address to block.\033[0;0m\n" && return 1
    [ -f "/bin/firewall-cmd" ] &&
      /usr/bin/sudo /bin/firewall-cmd --zone="drop" --add-source="$1" &&
      /usr/bin/sudo /bin/firewall-cmd --permanent --zone="drop" --add-source="$1" 1>/dev/null
    [ -f "/usr/sbin/csf" ] &&
      /usr/bin/sudo /usr/sbin/csf -d "$1"
  }
  deny_ip_remove() {
    [ "$1" == "" ] && printf "\033[1;31mYou must specify an IP address to unblock.\033[0;0m\n" && return 1
    [ -f "/bin/firewall-cmd" ] &&
      /usr/bin/sudo /bin/firewall-cmd --zone="drop" --remove-source="$1" &&
      /usr/bin/sudo /bin/firewall-cmd --permanent --zone="drop" --remove-source="$1" 1>/dev/null
    [ -f "/usr/sbin/csf" ] &&
      /usr/bin/sudo /usr/sbin/csf -dr "$1"
  }
  alias firewall-deny=deny_ip_add
  alias firewall-denyr=deny_ip_remove
fi

[ "$PS1" ] && export PS1="\[$(tput sgr0)\]\[$(tput setaf 1)\][\[$(tput setaf 3)\]\u\[$(tput setaf 2)\]@\[$(tput setaf 4)\]\h \[$(tput setaf 5)\]\w\[$(tput setaf 1)\]]\[$(tput setaf 7)\]\\$ \[$(tput sgr0)\]"

export PATH=$PATH:$HOME/.local/bin
