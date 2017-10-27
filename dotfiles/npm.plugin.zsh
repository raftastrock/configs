
alias ng='sudo npm i -g '
alias nis='npm i -S '
alias nid='npm i -D '
alias no='npm outdated'
alias nl='npm list'
alias nlink='sudo npm link'
alias nlocation='sudo npm -g list --depth=0'
alias nr='npm run '
alias ns='npm start'
alias nt='npm test'

alias yg='yarn i -g '
alias yis='yarn i -S '
alias yid='yarn i -D '
alias yr='yarn run '
alias ys='yarn start'
alias yt='yarn test'

function nsv(){
	npm show $1 versions
}