(( $+commands[npm] )) && {
		__NPM_COMPLETION_FILE="${ZSH_CACHE_DIR}/npm_completion"

		if [[ ! -f $__NPM_COMPLETION_FILE ]]; then
				npm completion >! $__NPM_COMPLETION_FILE 2>/dev/null
				[[ $? -ne 0 ]] && rm -f $__NPM_COMPLETION_FILE
		fi

		[[ -f $__NPM_COMPLETION_FILE ]] && source $__NPM_COMPLETION_FILE

		unset __NPM_COMPLETION_FILE
}


alias ng="sudo npm i -g "
alias nis="npm i -S "
alias nid="npm i -D "
alias no="npm outdated"
alias nl="npm list"
alias nlink='sudo npm link'
alias nlocation='sudo npm -g list --depth=0'
alias nr="npm run "
alias ns="npm start"
alias nt="npm test"

alias yg="sudo yarn i -g "
alias yis="yarn i -S "
alias yid="yarn i -D "
alias yr="yarn run "
alias ys="yarn start"
alias yt="yarn test"

function nsv(){
	npm show $1 versions
}
