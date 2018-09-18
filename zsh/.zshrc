# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="candy"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

KSH_ARRAYS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
unsetopt correct_all
bindkey "^[[3~" delete-char
bindkey "^[[5D" backward-word
bindkey "^[[5C" forward-word

# Turn on 256 color support...
if [ "x$TERM" = "xxterm" ]
then
    export TERM="xterm-256color"
fi

export EDITOR=$(which vim)
export LANG=es_ES.utf8

alias csvpager='vim -c "set ft=csv" -c %ArrangeColumn -c 1split -c "wincmd j"'

# Quick ps in csv format
psv() {
	ps -Ao "pid,user,pcpu,pmem,comm" --sort -pcpu,-pmem | sed 's/^ \+//g; s/ \+$//g; s/ \+/ /g' | awk '{for (i=1; i<NF; i++){ if(i<=4) printf("%s|", $i); else printf("%s ", $i)} print $i}' | head -10 | csvlook -d '|'
}

fixenv() {
	eval $(tmux showenv -s SSH_AUTH_SOCK)
	eval $(tmux showenv -s DISPLAY)
}
