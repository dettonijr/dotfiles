force_color_prompt=yes
source git-completion.bash

export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

alias ls="ls --color=auto"

git() {
    if [[ $@ == "tree" ]]; then
        command git log --oneline --all --graph --decorate
    else
        command git "$@"
    fi
}
