export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="agnoster"

plugins=(
  cp
  sudo
  zsh-autosuggestions
  zsh-syntax-highlighting
  command-not-found
  dnf
  docker-compose
  frontend-search
  git
  vscode
  yarn
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

# History size
SAVEHIST=50001

export EDITOR='nvim'

command -v eza >/dev/null && { alias l="eza -lahg --icons --octal-permissions" && alias ll="eza -lhg --icons --octal-permissions" }

alias zshrc="${=EDITOR} ~/.zshrc"

# autojump
[[ -s /usr/share/autojump/autojump.zsh ]] && source /usr/share/autojump/autojump.zsh

# pfetch
echo
pfetch
export PATH=$PATH:/home/h.loewe/.spicetify:/home/h.loewe/.cargo/bin

# add fucking fuck fuck alias
eval $(thefuck --alias)
