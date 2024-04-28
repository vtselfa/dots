# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
# ZSH_THEME="candy"

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

# History management
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=()

source $ZSH/oh-my-zsh.sh

unsetopt correct_all
bindkey "^[[3~" delete-char
bindkey "^[[5D" backward-word
bindkey "^[[5C" forward-word

# Disable expanding the history using `!`
set +o histexpand

export EDITOR=$(which nvim)
export ZK_NOTEBOOK_DIR=~/zettelkasten
export ZERO_UUID="00000000-0000-0000-0000-000000000000"

function vault() {
    env=$1
    dom=$2
    shift 2
    VAULT_TOKEN=$(cat ~/.vault.${env}.${dom}.token) VAULT_ADDR=https://vault.${env}.${dom}.thedock.cloud command vault $@
}

function add_key_pair() {
    local ENV=$1
    local PARTNER=$2
    local USER_NAME=$3 # The username in the email

    PRIVATE=${HOME}/dock-credentials/${ENV}/${USER_NAME}_${ENV}_private.pem
    PUBLIC=${HOME}/dock-credentials/${ENV}/${USER_NAME}_${ENV}_public.pem

    if [ -f "${PRIVATE}" ]; then
        echo "${PRIVATE} file already exists"
    else
        openssl genpkey -algorithm EC -pkeyopt ec_paramgen_curve:P-521 > ${PRIVATE} && echo "Created ${PRIVATE}"
        openssl pkey -pubout -in ${PRIVATE} > ${PUBLIC} && echo "Created ${PUBLIC}"
    fi

    ln -s ${PUBLIC}  ${HOME}/dock-credentials/${ENV}/${PARTNER}/${USER_NAME}_${PARTNER}_${ENV}_public.pem && echo "Linked public key"
    ln -s ${PRIVATE} ${HOME}/dock-credentials/${ENV}/${PARTNER}/${USER_NAME}_${PARTNER}_${ENV}_private.pem && echo "Linked private key"
}

function gen_idempotency_key() {
    echo "$(date +%Y%m%d)"'!'"$(uuidgen | awk '{print tolower}')"
}

function store_created_user() {
    local FILE=$1
    local USER_NAME=$2
    local ENV=$(yq -r '.environment' "${FILE}")
    local PARTNER=$(yq -r '.partner' "${FILE}")
    # local USER_NAME=$(yq -r '.username' "${FILE}")
    DEST="${HOME}/dock-credentials/${ENV}/${PARTNER}/${USER_NAME}_${PARTNER}_${ENV}.yaml"

    read -q "response?Writing to ${DEST}. Are you sure? y/n: "
    echo

    # Check the user's response
    if [[ $response != "y" ]]; then
        echo "Aborting"
        return 1
    fi
  
    if [ -f "${DEST}" ]; then
        echo "${DEST} file already exists"
        return 1
    fi

  yq -y '{environment,partner,title,given_names,surnames,gender,email_address,nationality,identity_id,tenant_id,user_id,actor_id,public_key_id,device_token,idempotency_key}' "${FILE}" | tee "${DEST}"
}


alias enable_hdmi1="sudo ddcutil --display 1 setvcp 60 0x11"
alias enable_usbc="sudo ddcutil --display 1 setvcp 60 0x1b"

# Replace the openssl shipped by mac os 
alias openssl="$(brew --prefix openssl)/bin/openssl"

# Fucking stupid mac os having ridiculously low limits
ulimit -n 4096

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load autocompletion functions provided by homebrew
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit; compinit

eval "$(starship init zsh)"

# grit
export GRIT_INSTALL="$HOME/.grit"
export PATH="$GRIT_INSTALL/bin:$PATH"
