
alias nb='npm run build'
alias nd='npm run deploy'
alias ng='sudo npm i -g '
alias nis='npm i -S '
alias nid='npm i -D '
alias no='npm outdated'
alias nl='npm list'
alias nlink='sudo npm link'
alias nlocation='sudo npm -g list --depth=0'
alias nu='npm uninstall '
alias nud='npm uninstall -D '
alias nug='npm uninstall -g '
alias nus='npm uninstall -S '
alias nr='npm run '
alias ns='npm start'
alias nt='npm test'

alias yg='yarn i -g '
alias yis='yarn i -S '
alias yid='yarn i -D '
alias yr='yarn run '
alias ys='yarn start'
alias yt='yarn test'

function nv(){
	npm view $1 versions --json
}
