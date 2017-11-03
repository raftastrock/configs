'use strict'

var marble = require('marble')

const date = new Date

module.exports = {
	codeMirrorLanguages: ['shell', 'xml', 'css', 'javascript'],
	deployOptions: {
		message: `Update: ${date.toLocaleDateString()} @ ${date.toLocaleTimeString()}`,
		force: true,
		branch: 'gh-pages',
	},
	metalComponents: ['electric-marble-components'],
	sassOptions: {
		includePaths: ['node_modules', marble.src],
	},
	vendorSrc: ['node_modules/marble/build/fonts/**'],
}
