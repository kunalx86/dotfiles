# Enable colors and change prompt:
autoload -U colors && colors	# Load colors

# For git branch information
autoload -Uz vcs_info

zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:*' unstagedstr '!'
zstyle ':vcs_info:*' untrackedstr '?'
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' actionformats '%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
zstyle ':vcs_info:git*' formats "%{$fg[cyan]%}[%F{034}%b %{$fg[blue]%}%c%{$fg[yellow]%}%u%{$fg[cyan]%}]"
zstyle ':vcs_info:*' enable git 

zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
+vi-git-untracked() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --no-empty-directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
    hook_com[staged]+='%F{1}?'
fi
}

precmd() {
  vcs_info
}

# Found on Stackoverflow
function git_branch_test_color() {
  local ref=$(git symbolic-ref --short HEAD 2> /dev/null)
  if [ -n "${ref}" ]; then
    echo "%F{071}[%F{070}$ref %F{071}]"
  fi

}

zstyle ':vcs_info:git*+set-message:*' hooks git-remotebranch
+vi-git-remotebranch() {

  local remote=${$(git rev-parse --verify ${hook_com[branch]}@{upstream} \
        --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
	if [ -n "${remote}" ]; then
    hook_com[branch]="${hook_com[branch]}"
  fi
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
  [[ $(git ls-files --other --no-empty-directory --exclude-standard | sed q | wc -l | tr -d ' ') == 1 ]] ; then
    hook_com[staged]+='%F{1}?'
fi
  
}

setopt PROMPT_SUBST

export PS1='%B%{$fg[cyan]%}[%{$fg[red]%}%n%{$fg[yellow]%}::%{$reset_color%}% %{$fg[blue]%}%B%M%B%F{cyan}] [%{$fg[magenta]%}%~%{$reset_color%}%B] %{$vcs_info_msg_0_%}'$'\n''%(?.%F{green}.%F{red})λ>%b %{$reset_color%}%'
# Important ls aliases
alias ls='ls --color=auto'
alias dir='dir --color=auto'
alias grep='grep --color=auto'
alias dmesg='dmesg --color=auto'
alias docker_clean_images='docker rmi $(docker images -a --filter=dangling=true -q)'
alias docker_clean_ps='docker rm $(docker ps --filter=status=exited --filter=status=created -q)'
alias ll='ls -lah'

alias p8='ping 8.8.8.8'

setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# History in cache directory:
HISTSIZE=10000000
SAVEHIST=10000000

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1
export MOZ_PROFILER_STARTUP=1

# From LukeSmith's config
# Change cursor shape for different vi modes.
function zle-keymap-select () {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';;      # block
    viins|main) echo -ne '\e[5 q';; # beam
  esac
}
zle -N zle-keymap-select
zle-line-init() {
  zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
  echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Only needed if using NVM else comment it out
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
export PATH=/home/$USER/.local/bin/:$PATH

ZSH_AUTOSUGGEST_STRATEGY=(completion)
source ~/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
# Load syntax highlighting; should be last.
export EDITOR=nvim
figlet "Hello Kunal" | lolcat
# Ensure you have fast-syntax-highlighting installed
source ~/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh 2>/dev/null

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# [ -f "/home/kunal/.ghcup/env" ] && source "/home/kunal/.ghcup/env" # ghcup-env
