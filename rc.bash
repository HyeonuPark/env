# `~/.bashrc` is executed on every `bash` shell loaded

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

PATH_COLOR=36
export PS1="\[\e[$PATH_COLOR;1m\]\w\[\e[0m\]\$(date +%H%M%S)\[\e[32;1m\]\$(git rev-parse --abbrev-ref HEAD 2> /dev/null)\[\e[33m\]\$ \[\e[0m\]"

export VISUAL='nano'
export EDITOR='nano'
export PAGER='less'

# silence macos terminal warning on using bash
export BASH_SILENCE_DEPRECATION_WARNING=1
# print backtrace msg on rust executable panic
export RUST_BACKTRACE=1

PATH="\
:$HOME/bin\
:$HOME/.local/bin\
:/usr/bin\
:/usr/local/bin\
:/usr/local/sbin\
:$PATH"

# insert 3rd party .bashrc lines here
source "$HOME/.cargo/env"

# dedupe $PATH without changing order
export PATH="$(echo -n "$PATH" | awk -v RS=':' -v ORS=':' '!x[$0]++' | head -c -1)"

COMPLETION_DIR_CANDIDATES="
/usr/local/etc/bash_completion.d
/usr/share/bash-completion/completions
/etc/bash_completion.d
"

for COMPLETION_DIR in $COMPLETION_DIR_CANDIDATES; do
	if [[ -d $COMPLETION_DIR ]]; then
		source $COMPLETION_DIR/git 2> /dev/null
		break
	fi
done

# Git aliases

function git-current-branch {
	git rev-parse --abbrev-ref HEAD 2> /dev/null
}

alias gfa='git fetch --all'; __git_complete gfa _git_fetch
alias gps='gfa && git push origin $(git-current-branch)'; __git_complete gps _git_push
alias gpsf='gps --force'; __git_complete gpsf _git_push
alias gpl='gfa && git merge --ff-only origin/$(git-current-branch)'; __git_complete gpl _git_merge
alias gplf='gfa && git reset --hard origin/$(git-current-branch)'; __git_complete gplf _git_reset

alias gap='git add --patch'; __git_complete gap _git_add
alias gb='git branch'; __git_complete gb _git_branch

alias gcl='git clone --recursive'; __git_complete gcl _git_clone
alias gcm='git commit'; __git_complete gcm _git_commit
alias gam='git commit --amend --no-edit'; __git_complete gam _git_commit
alias gck='git checkout'; __git_complete gck _git_checkout
alias gcp='git cherry-pick'; __git_complete gcp _git_cherry_pick

alias gdf='git diff --word-diff=color --word-diff-regex="[A-Za-z0-9_]+"'; __git_complete gdf _git_diff
alias gdfl='git diff'; __git_complete gdfl _git_diff
alias gs='git stash'; __git_complete gs _git_stash
alias gsp='git stash pop'; __git_complete gsp _git_stash
alias gst='git status'; __git_complete gst _git_status
alias gsh='git show'; __git_complete gsh _git_show

alias grb='git rebase'; __git_complete grb _git_rebase
alias grs='git reset'; __git_complete grs _git_reset

alias gla="git log --graph --abbrev-commit --decorate --format=format:'%C(bold blue)%h%C(reset) \- %C(bold green)(%cr)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all --invert-grep --grep='\btw\b' --grep='^test$' --exclude=gh-pages"; __git_complete gla _git_log
alias gl="gla -n 100"; __git_complete gl _git_log

# Cargo aliases

alias ck='cargo check'
alias cka='cargo check --all'
alias ckp='cargo check --package'

alias ct='cargo test'
alias cta='cargo test --all'
alias ctp='cargo test --package'

alias cb='cargo build'
alias cbb='cargo build --bin'
alias cr='cargo run'
alias crb='cargo run --bin'

# Misc aliases

# TODO: remove rg and exa deps on ad-hoc env, and remove bashism

alias ls='exa --time-style=iso --git --git-ignore'
alias ll='ls -l'
alias rmf='rm -rf'
alias cpr='cp -r'
alias cl='clear'
alias md='mkdir -p'

function mf {
	for file in $@; do
		mkdir -p "$(dirname $file)"
		touch "$file"
	done
}

function mvf {
	if [ $# -ne 2 ]; then
		echo 'Usage: $ mvf path/to/src path/to/dst'
		return 1
	fi

	tmp_path="$(mktemp)"
	mv $1 "$tmp_path"
	rm -r $2
	mkdir -p "$(dirname $2)"
	mv "$tmp_path" $2
}

function rgv {
	rg -p "$@" | less -R
}