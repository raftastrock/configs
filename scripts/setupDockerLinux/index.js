'use strict'

const download = require('download')
const fsExtra = require('fs-extra')
const userHome = require('user-home')
const yaml = require('js-yaml')

const projectPath = `${userHome}/dev/www-workspace`

function rewriteHttpdPort() {
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
		console.error(err)
	}
}

function getLiferayBundles() {
	const mirrorsUrl = 'http://mirrors/files.liferay.com/private/ee/'
	const dxpBundle = `${mirrorsUrl}/portal/7.0.10.6/liferay-dxp-digital-enterprise-tomcat-7.0-sp6-20171010144253003.zip`
	const fixPackMirrorUrl = `${mirrorsUrl}/fix-packs/7.0.10/de/liferay-fix-pack-de-32-7010.zip`

	const bundleDest = `${projectPath}/docker/local/liferay/liferay.zip`
	const patchDest = '/opt/java/liferay/patching-tool/patches/patch.zip'

	console.log('Downloading Liferay zip')

	download(fixPackMirrorUrl)
		.then(data => {
			console.log('Saving file Bundle zip to', bundleDest)

			fsExtra.outputFile(bundleDest, data)

			console.log('Saving file Patch zip to', patchDest)

			fsExtra.outputFile(patchDest, data)

			console.log('Done!')
		})
		.catch(err => console.error(err))
}

rewriteHttpdPort()
getLiferayBundles()
