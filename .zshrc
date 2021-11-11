export PS1="%d 🤓 "

# export PATH="$PATH:$HOME/.composer/vendor/bin"
export PATH=$HOME/bin:/opt/homebrew/bin:/usr/local/bin:$PATH
# export PATH=$HOME/bin:/opt/homebrew/bin:/opt/composer:/usr/local/bin:$PATH
# export PATH=$HOME/bin:/usr/local/bin:/opt/homebrew/bin:$PATH

# Vergroot de history
HISTSIZE=99999
HISTFILESIZE=999999
SAVEHIST=$HISTSIZE

# Om standaard '1' toe te voegen om zo vanaf het begin van de geschiedenis te zoeken
alias hist="history 1"

# alias ibrew='arch -x86_64 brew'
# alias a="arch -x86_64"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias la="ls -lhA ${colorflag}"

# init z! (https://github.com/rupa/z)
. ~/z.sh

# . /usr/local/opt/asdf/asdf.sh

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion