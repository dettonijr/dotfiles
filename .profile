alias gs='git status'
alias gp='git pull'
alias ga='git add'
alias gc='git commit'
alias gco='git checkout'
alias glog='git log'
alias gpush='git push origin HEAD'
alias gtree='git log --oneline --all --graph --decorate'
alias n='nvim'

gitgo () {
  git commit -a -m "$*" && git push origin HEAD
}
