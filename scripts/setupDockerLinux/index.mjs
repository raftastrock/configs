'use strict'

import downloadBundles from './src/getBundles.mjs'
import rewritePort from './src/rewritePort.mjs'

rewritePort()
downloadBundles()
