'use strict'

var marble = require('marble')

const date = new Date

module.exports = {
	codeMirrorLanguages: ['shell', 'xml', 'css', 'javascript'],
	deployOptions: {
		branch: 'gh-pages',
		message: `Update: ${date.toLocaleDateString()} @ ${date.toLocaleTimeString()}`,
		url: 'https://protoevangelion.github.io/notes',
	},
	metalComponents: ['electric-marble-components'],
	sassOptions: {
		includePaths: ['node_modules', marble.src],
	},
	vendorSrc: ['node_modules/marble/build/fonts/**'],
}
