'use strict'

var marble = require('marble')

module.exports = {
	codeMirrorLanguages: ['shell', 'xml', 'css', 'javascript'],
	deployOptions: {
		branch: 'deploy',
	},
	metalComponents: ['electric-marble-components'],
	sassOptions: {
		includePaths: ['node_modules', marble.src],
	},
	vendorSrc: ['node_modules/marble/build/fonts/**'],
}
