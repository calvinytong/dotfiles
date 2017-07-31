# system aliases
alias df="df -Tha --total"
alias free="free -mt"
alias psg="ps aux | grep -v grep | grep -i -e VSZ -e"
alias histg="history | grep"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias c='clear'

# git aliases
alias ga='git add'
alias gs='git status'
alias gp='git push'
alias gc='git commit'
alias gb='git branch'

# docker aliases
alias dockerka='docker kill $(docker ps -q)'
alias dockercleanc='printf "\n>>> Deleting stopped containers\n\n" && docker rm $(docker ps -a -q)'
alias dockercleani='printf "\n>>> Deleting untagged images\n\n" && docker rmi $(docker images -q -f dangling=true)'
alias dockerclean='dockercleanc || true && dockercleani'

# cognescent py3 alias
alias py3='source ~/ws/py3.venv/bin/activate'
