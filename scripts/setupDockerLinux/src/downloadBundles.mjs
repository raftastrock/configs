'use strict'

import download from 'download'
import fsExtra from 'fs-extra'

import projectPath from './userHome.mjs'

export default function getLiferayBundles() {
	const mirrorsUrl = 'http://mirrors/files.liferay.com/private/ee/'
	const dxpBundle = `${mirrorsUrl}/portal/7.0.10.6/liferay-dxp-digital-enterprise-tomcat-7.0-sp6-20171010144253003.zip`
	// const fixPackMirrorUrl = `${mirrorsUrl}/fix-packs/7.0.10/de/liferay-fix-pack-de-32-7010.zip`

	const bundleDest = `${projectPath}/docker/local/liferay/liferay.zip`
	const patchDest = '/opt/java/liferay/patching-tool/patches/patch.zip'

	console.log('Downloading Liferay zip')

	// download(fixPackMirrorUrl)
	// 	.then(data => {
	// 		console.log('Saving file Bundle zip to', bundleDest)

	// 		fsExtra.outputFile(bundleDest, data)

	// 		console.log('Saving file Patch zip to', patchDest)

	// 		fsExtra.outputFile(patchDest, data)

	// 		console.log('Done!')
	// 	})
	// 	.catch(err => console.error(err))

	download(dxpBundle)
		.then(data => {
			console.log('Saving file Bundle zip to', bundleDest)

			fsExtra.outputFile(bundleDest, data)

			console.log('Saving file Patch zip to', patchDest)

			fsExtra.outputFile(patchDest, data)

			console.log('Done!')
		})
		.catch(err => console.error(err))
}
