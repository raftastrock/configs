'use strict'

import fsExtra from 'fs-extra'
import yaml from 'js-yaml'

import projectPath from './userHome.mjs'

export default function rewriteHttpdPort() {
	const dockerYmlPath = `${projectPath}/docker/local/docker-compose.yaml`

	try {
		const initialYml = yaml.safeLoad(fsExtra.readFileSync(dockerYmlPath, 'utf8'))

		initialYml.services.httpd.ports[0] = '81:80'

		const modifedYml = yaml.safeDump(initialYml)

		fsExtra
			.outputFile(dockerYmlPath, modifedYml)
			.then(() => console.log('Successfully rewrote port for', dockerYmlPath))
			.catch(err => console.error(err))
	} catch (err) {
		console.error('Error rewriting Httpd port', err)
	}
}
